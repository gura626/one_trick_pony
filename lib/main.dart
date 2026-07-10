import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Homepage());
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    super.initState();
    loadCount();
  }

Future<void> saveCount() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setInt('streak', streak);

  if (lastCheckDate != null) {
    await prefs.setString(
      'lastCheckDate',
      lastCheckDate!.toIso8601String(),
    );
  }
}

Future<void> loadCount() async {
  final prefs = await SharedPreferences.getInstance();

  setState(() {
    streak = prefs.getInt('streak') ?? 0;

    String? savedDate =
        prefs.getString('lastCheckDate');

    if (savedDate != null) {
      lastCheckDate = DateTime.parse(savedDate);
    }
  });
}

  int streak = 0;

  DateTime? lastCheckDate;

  bool isCheckedToday() {
    DateTime now = DateTime.now();

    return lastCheckDate != null &&
        lastCheckDate!.year == now.year &&
        lastCheckDate!.month == now.month &&
        lastCheckDate!.day == now.day;
  }

  void checkToday() {

    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(
      now.year,
      now.month,
      now.day -1,
    );

    if (lastCheckDate != null &&
        lastCheckDate!.year == now.year &&
        lastCheckDate!.month == now.month &&
        lastCheckDate!.day == now.day) {
          return;
        }
        if (lastCheckDate == null) {
          streak = 1;
        } else if (
          lastCheckDate!.year == yesterday.year &&
          lastCheckDate!.month == yesterday.month &&
          lastCheckDate!.day == yesterday.day) {
            streak++;
          } else {
            streak = 1;
          }

        saveCount();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Color.from(alpha: 0.02, red: 250, green: 253, blue: 255,
        ),
        fontFamily: 'jost',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'One Trick Pony',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 27,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(2, 250, 253, 255),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Today Event',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 90),
                ElevatedButton(
                  onPressed: isCheckedToday()
                    ? null
                    : checkToday,
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 300),
                  ),
                  child: const Text(
                    'Check',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'streak $streak',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )
                )
              ],
            ),
        ),
      ),
    );
  }
}