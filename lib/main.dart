import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://jortcgndkmqrfhmchrub.supabase.co';
const supabasePublishableKey =
    'sb_publishable_MruMtPwY_Nw4j1tRDabfpg_INfG9X3d';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    publishableKey: supabasePublishableKey,
  );

  runApp(const RozanaRewards());
}

class RozanaRewards extends StatelessWidget {
  const RozanaRewards({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rozana Rewards',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6D28D9),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

// ================= LOGIN =================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phone = TextEditingController();

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }

  void continueToApp() {
    final number = phone.text.trim();

    if (number.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid mobile number.'),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.stars_rounded,
                size: 80,
                color: Color(0xFF6D28D9),
              ),
              const SizedBox(height: 16),
              const Text(
                'Rozana Rewards',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Daily tasks • Games • Rewards',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 35),
              TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Mobile number',
                  prefixText: '+92 ',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: continueToApp,
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= HOME =================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int points = 0;
  List<String> history = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      points = prefs.getInt('points') ?? 0;
      history = prefs.getStringList('history') ?? [];
      loading = false;
    });
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('points', points);
    await prefs.setStringList('history', history);
  }

  Future<void> addPoints(int amount, String message) async {
    setState(() {
      points += amount;
      history.insert(0, '$message +$amount points');
    });

    await saveData();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$message +$amount points'),
      ),
    );
  }

  void completeTask() {
    addPoints(10, 'Task completed!');
  }

  void playGame() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Mini Game 🎮'),
          content: const Text(
            'Demo game completed! Collect your reward.',
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                addPoints(20, 'Game completed!');
              },
              child: const Text('Collect 20 Points'),
            ),
          ],
        );
      },
    );
  }

  void watchAd() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Watch Ad 📺'),
          content: const Text(
            'Demo ad completed. Real ads can be connected later.',
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                addPoints(5, 'Ad completed!');
              },
              child: const Text('Complete Ad'),
            ),
          ],
        );
      },
    );
  }

  void openWallet() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WalletPage(
          points: points,
          history: history,
          onChanged: loadData,
        ),
      ),
    );
  }

  Future<void> resetPoints() async {
    setState(() {
      points = 0;
      history.clear();
    });

    await saveData();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Points reset.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rozana Rewards'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome! 🎉',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Complete tasks and earn rewards every day.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 25),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: const Icon(
                  Icons.monetization_on,
                  color: Colors.amber,
                  size: 42,
                ),
                title: const Text('Your Points'),
                subtitle: const Text('Keep earning!'),
                trailing: Text(
                  '$points',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Daily Tasks',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: const Icon(Icons.task_alt, size: 35),
                title: const Text('Complete your first task'),
                subtitle: const Text('Earn 10 points'),
                trailing: FilledButton(
                  onPressed: completeTask,
                  child: const Text('Start'),
                ),
              ),
            ),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: const Icon(Icons.games, size: 35),
                title: const Text('Play & Earn'),
                subtitle: const Text('Earn 20 points'),
                trailing: FilledButton(
                  onPressed: playGame,
                  child: const Text('Play'),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'More Ways to Earn',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: const Icon(
                  Icons.ondemand_video,
                  size: 35,
                ),
                title: const Text('Watch Ads'),
                subtitle: const Text(
                  'Earn 5 points per demo ad',
                ),
                trailing: OutlinedButton(
                  onPressed: watchAd,
                  child: const Text('Watch'),
                ),
              ),
            ),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: const Icon(
                  Icons.account_balance_wallet,
                  size: 35,
                ),
                title: const Text('Wallet & Withdraw'),
                subtitle: const Text(
                  'View balance and withdrawal options',
                ),
                trailing: OutlinedButton(
                  onPressed: openWallet,
                  child: const Text('Open'),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: resetPoints,
                child: const Text('Reset Points'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= WALLET =================

class WalletPage extends StatefulWidget {
  final int points;
  final List<String> history;
  final Future<void> Function() onChanged;

  const WalletPage({
    super.key,
    required this.points,
    required this.history,
    required this.onChanged,
  });

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late int points;
  late List<String> history;

  static const int minimumWithdrawal = 100;

  @override
  void initState() {
    super.initState();
    points = widget.points;
    history = List<String>.from(widget.history);
  }

  Future<void> requestWithdrawal(
    String method,
    String number,
  ) async {
    if (points < minimumWithdrawal) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Minimum withdrawal is 100 points.',
          ),
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    setState(() {
      points -= minimumWithdrawal;
      history.insert(
        0,
        'Withdrawal requested: $method ($number) - '
        '$minimumWithdrawal points',
      );
    });

    await prefs.setInt('points', points);
    await prefs.setStringList('history', history);
    await widget.onChanged();

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Request Submitted ✅'),
          content: Text(
            'Your $method withdrawal request has been recorded.\n\n'
            'Amount: $minimumWithdrawal points\n'
            'Account: $number\n\n'
            'Payment is not automatic yet. Real JazzCash/Easypaisa '
            'payment will require secure merchant integration.',
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showWithdrawalForm(String method) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('$method Withdrawal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Minimum withdrawal: 100 points',
              ),
              const SizedBox(height: 15),
              TextField(
                controller: controller,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: '$method mobile number',
                  hintText: '03XXXXXXXXX',
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final number = controller.text.trim();

                if (number.length < 10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please enter a valid mobile number.',
                      ),
                    ),
                  );
                  return;
                }

                Navigator.pop(dialogContext);
                requestWithdrawal(method, number);
              },
              child: const Text('Submit Request'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Available Points',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$points',
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Withdraw',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: const Icon(
                  Icons.phone_android,
                  size: 35,
                ),
                title: const Text('JazzCash'),
                subtitle: const Text('Request withdrawal'),
                trailing: FilledButton(
                  onPressed: () {
                    showWithdrawalForm('JazzCash');
                  },
                  child: const Text('Withdraw'),
                ),
              ),
            ),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: const Icon(
                  Icons.account_balance,
                  size: 35,
                ),
                title: const Text('Easypaisa'),
                subtitle: const Text('Request withdrawal'),
                trailing: FilledButton(
                  onPressed: () {
                    showWithdrawalForm('Easypaisa');
                  },
                  child: const Text('Withdraw'),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            if (history.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text('No activity yet.'),
                ),
              )
            else
              ...history.map(
                (item) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(item),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

