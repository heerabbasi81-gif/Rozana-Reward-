import 'package:flutter/material.dart';

void main() {
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
                  onPressed: () {
                    if (phone.text.trim().length < 10) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid mobile number.'),
                        ),
                      );
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomePage(),
                      ),
                    );
                  },
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int points = 0;
  final List<String> history = [];

  void addPoints(int amount, String message) {
    setState(() {
      points += amount;
      history.insert(0, '$message +$amount points');
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$message +$amount points'),
      ),
    );
  }

  void watchAd() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Watch Ad'),
          content: const Text(
            'Demo ad completed. Real ads will be connected later.',
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                addPoints(5, 'Ad completed!');
              },
              child: const Text('Complete Ad'),
            ),
          ],
        );
      },
    );
  }

  void playGame() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Mini Game 🎮'),
          content: const Text(
            'Demo game completed! Tap below to collect your points.',
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                addPoints(20, 'Game completed!');
              },
              child: const Text('Collect 20 Points'),
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
        ),
      ),
    );
  }

  void resetPoints() {
    setState(() {
      points = 0;
      history.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Points reset.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            ),
            const SizedBox(height: 25),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.monetization_on,
                  color: Colors.amber,
                  size: 40,
                ),
                title: const Text('Your Points'),
                subtitle: const Text('Keep earning!'),
                trailing: Text(
                  '$points',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

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
                leading: const Icon(Icons.task_alt),
                title: const Text('Complete your first task'),
                subtitle: const Text('Earn 10 points'),
                trailing: FilledButton(
                  onPressed: () {
                    addPoints(10, 'Task completed!');
                  },
                  child: const Text('Start'),
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.games),
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
                leading: const Icon(Icons.ondemand_video),
                title: const Text('Watch Ads'),
                subtitle: const Text('Earn 5 points per demo ad'),
                trailing: OutlinedButton(
                  onPressed: watchAd,
                  child: const Text('Watch'),
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.account_balance_wallet),
                title: const Text('Wallet & Withdraw'),
                subtitle: const Text('View balance and withdrawal options'),
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

class WalletPage extends StatelessWidget {
  final int points;
  final List<String> history;

  const WalletPage({
    super.key,
    required this.points,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    final double estimatedValue = points / 1000;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Padding(
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
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Demo value: ${estimatedValue.toStringAsFixed(2)}',
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
                leading: const Icon(Icons.phone_android),
                title: const Text('JazzCash'),
                subtitle: const Text('Payment connection required'),
                trailing: FilledButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'JazzCash withdrawal will be connected after payment setup.',
                        ),
                      ),
                    );
                  },
                  child: const Text('Withdraw'),
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.account_balance),
                title: const Text('Easypaisa'),
                subtitle: const Text('Payment connection required'),
                trailing: FilledButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Easypaisa withdrawal will be connected after payment setup.',
                        ),
                      ),
                    );
                  },
                  child: const Text('Withdraw'),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: history.isEmpty
                  ? const Center(
                      child: Text('No activity yet.'),
                    )
                  : ListView.builder(
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.history),
                            title: Text(history[index]),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
