import 'package:flutter/material.dart';
import 'subject_page.dart';
import 'result_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green, // Set app bar background color
        ),
        scaffoldBackgroundColor: Colors.greenAccent,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<String> subjects = [
    'CSF3123',
    'CSF3133',
    'CSF3034',
    'CSF3023',
    'CSF3003'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Exam Status'),
        centerTitle: true,
      ),
      body: SubjectPage(),
      //Lab 7 : drawer_demo
      drawer: Drawer(
        child: ListView(
          children: [
            const SizedBox(
              height: 60.0,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                child: Text(
                  'Student Course Status',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            for (String subject in subjects)
              ListTile(
                title: Text(subject),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(subject: subject),
                    ),
                  );
                },
              ),
          ], //yes
        ),
      ),
    );
  }
}
