import 'package:flutter/material.dart';

void main() {
  runApp(const Homepage());
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Color.from(alpha: 0.02, red: 250, green: 253, blue: 255)
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('One Trick Pony',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(2, 250, 253, 255)
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text('Today Event(1日1回だけ押せる)',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  ),
                ),
                SizedBox(height: 70,),
                ElevatedButton(onPressed: () {}, 
                child: Text('Check',),
                style: ElevatedButton.styleFrom(fixedSize: Size(200, 200)),
                ),
                SizedBox(
                  height: 100,
                ),
                Text('count +1day',
                style: TextStyle(
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