import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const GymApp());
}

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Workout Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Colors.amber,
          secondary: Colors.amberAccent,
        ),
      ),
      home: const GymHomePage(),
    );
  }
}

class GymHomePage extends StatefulWidget {
  const GymHomePage({super.key});

  @override
  State<GymHomePage> createState() => _GymHomePageState();
}

class _GymHomePageState extends State<GymHomePage> {
  int _restTime = 60;
  Timer? _timer;
  bool _isRunning = false;

  void _startTimer() {
    setState(() {
      _restTime = 60;
      _isRunning = true;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_restTime > 0) {
        setState(() => _restTime--);
      } else {
        _timer?.cancel();
        setState(() => _isRunning = false);
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _restTime = 60;
      _isRunning = false;
    });
  }

  final List<Map<String, dynamic>> workouts = [
    {
      'day': '1-KUN: Ko‘krak + Tritseps',
      'exercises': [
        'Gorizontal shtanga press — 4x10',
        'Niyashon gantel press — 3x12',
        'Brusda ishlash — 3x12',
        'Blokda tritseps (kanat) — 4x12',
        'Fransuzcha press — 3x10'
      ]
    },
    {
      'day': '2-KUN: Orqa + Bitseps',
      'exercises': [
        'Turnik (keng ushlash) — 4x8',
        'T-shtanga tortish — 4x10',
        'Blokni ko‘krakka tortish — 3x12',
        'Shtanga bilan bitseps — 4x10',
        'Gantel bolg‘a (hammer) — 3x12'
      ]
    },
    {
      'day': '3-KUN: Oyoq + Yelka',
      'exercises': [
        'Shtanga bilan o‘tirib-turish — 4x10',
        'Oyoq press trenajyorda — 4x12',
        'Gantel bilan yelka press — 4x10',
        'Gantellarni yonga ko‘tarish — 4x15',
        'Pres (mashqlar to‘plami) — 3x20'
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GYM WORKOUT TRACKER', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1)),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.amber.withOpacity(0.5), width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Dam olish vaqti:', style: TextStyle(color: Colors.grey, fontSize: 13)),
                    const SizedBox(height: 4),
                    Text(
                      '$_restTime sek',
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.amber),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _isRunning ? null : _startTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Boshlash', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.grey),
                      onPressed: _resetTimer,
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: workouts.length,
              itemBuilder: (context, index) {
                final item = workouts[index];
                return Card(
                  color: const Color(0xFF1E1E1E),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ExpansionTile(
                    iconColor: Colors.amber,
                    collapsedIconColor: Colors.grey,
                    title: Text(item['day'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15)),
                    children: (item['exercises'] as List<String>)
                        .map((ex) => ListTile(
                              leading: const Icon(Icons.fitness_center, size: 18, color: Colors.amber),
                              title: Text(ex, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                            ))
                        .toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
