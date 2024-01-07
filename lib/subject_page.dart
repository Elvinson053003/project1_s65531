import 'package:flutter/material.dart';
import 'subject_detail_page.dart';

class SubjectPage extends StatelessWidget {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.all(4),
            child: Text(
              'Course status for S65531..!',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900]),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (BuildContext context, int index) {
                String subject = subjects[index];
                return Container(
                  padding: const EdgeInsets.all(2.0),
                  margin: const EdgeInsets.all(3),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SubjectDetailPage(subject: subject),
                        ),
                      );
                    },
                    child: Text(subject),
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
