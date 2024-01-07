import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultScreen extends StatefulWidget {
  final String subject;

  ResultScreen({required this.subject});

  @override
  _ResultScreenState createState() => _ResultScreenState(subject: subject);
}

class _ResultScreenState extends State<ResultScreen> {
  final String subject;
  double carryMark = 0; // Replace with your actual carry mark
  String statusStatement = "";

  _ResultScreenState({required this.subject});
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        'project1-95656-default-rtdb.asia-southeast1.firebasedatabase.app',
        'project1.json');
    final response = await http.get(url);
    final url2 = Uri.https(
        'project1-95656-default-rtdb.asia-southeast1.firebasedatabase.app',
        'data1.json');
    final response2 = await http.get(url2);
    print('#Debug grocery_list.dart');
    print(response.body);
    final Map<String, dynamic> listData = json.decode(response.body);
    final Map<String, dynamic> listData2 = json.decode(response2.body);
    print('#Debug grocery_list.dart');
    print(listData);
    setState(() {
      for (final item in listData.entries) {
        if (item.value['subject'] == subject) {
          statusStatement = item.value['status'];
        }
      }
      for (final item in listData2.entries) {
        if (item.value['subject'] == subject) {
          carryMark = item.value['TotalCarryMarks'];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Result Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            const Text(
              'Dear S65531,                                                  ',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            const Text(
              'Your total carry mark for',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '$subject',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'is',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '$carryMark%',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              statusStatement,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: statusStatement ==
                        'You are eligible to attend the final exam!                                      '
                    ? Colors.green
                    : Colors.red,
              ),
            ),
            SizedBox(height: 20),
            Expanded(child: Container()), // Spacer
          ],
        ),
      ),
    );
  }
}
