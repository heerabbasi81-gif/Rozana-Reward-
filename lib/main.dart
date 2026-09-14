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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rozana Rewards'),
        centerTitle: true,
      ),
      body: Padding(
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
            const Text('Complete tasks and earn rewards every day.'),
            const SizedBox(height: 25),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.monetization_on,
                  color: Colors.amber,
                  size: 40,
                ),
                title: const Text('Your Points'),
                subtitle: const Text('Start earning today'),
                trailing: const Text(
                  '0',
                  style: TextStyle(
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
                subtitle: const Text('Earn points'),
                trailing: FilledButton(
                  onPressed: () {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Task started! +10 points')),
  );
},
                  child: const Text('Start'),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.games),
                title: const Text('Play & Earn'),
                subtitle: const Text('Games and rewards'),
                trailing: FilledButton(
                  onPressed: () {},
                  child: const Text('Play'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
