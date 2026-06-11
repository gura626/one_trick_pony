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

  await prefs.setInt('count', count);

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
    count = prefs.getInt('count') ?? 0;

    String? savedDate =
        prefs.getString('lastCheckDate');

    if (savedDate != null) {
      lastCheckDate = DateTime.parse(savedDate);
    }
  });
}

  int count = 0;

  DateTime? lastCheckDate;

  bool checkedToday = false;

  void checkToday() {

    DateTime now = DateTime.now();

    if (lastCheckDate != null &&
        lastCheckDate!.year == now.year &&
        lastCheckDate!.month == now.month &&
        lastCheckDate!.day == now.day) {
          return;
        }
        setState(() {
          count ++;
          lastCheckDate = now;
        });

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
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
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
                const SizedBox(height: 20),
                const SizedBox(height: 70),
                ElevatedButton(
                  onPressed: checkToday,
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
                  'day $count ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}