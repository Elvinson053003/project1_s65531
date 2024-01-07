import 'package:flutter/material.dart';
import 'attendance_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubjectDetailPage extends StatefulWidget {
  final String subject;

  SubjectDetailPage({required this.subject});

  @override
  _SubjectDetailPageState createState() =>
      _SubjectDetailPageState(subject: subject);
}

class _SubjectDetailPageState extends State<SubjectDetailPage> {
  final String subject;
  double totalMark = 0;

  _SubjectDetailPageState({required this.subject});
  List<double> carryMarks = [0.0, 0.0, 0.0, 0.0];

  //refer shopping_list
  void _saveItem() async {
    final url = Uri.https(
        'project1-95656-default-rtdb.asia-southeast1.firebasedatabase.app',
        'data1.json');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {'TotalCarryMarks': totalMark, 'subject': subject},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject} Carry Marks'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Part')),
              DataColumn(
                  label: Text(
                'Carry Mark (%)',
              )),
              DataColumn(label: Text('Weight (%)')),
            ],
            rows: List<DataRow>.generate(
                  carryMarks.length,
                  (index) {
                    return DataRow(
                      cells: [
                        DataCell(Text(_getPartName(index))),
                        DataCell(
                          TextFormField(
                            initialValue: carryMarks[index].toString(),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                carryMarks[index] =
                                    double.tryParse(value) ?? carryMarks[index];
                              });
                            },
                            style: TextStyle(
                                fontSize: 20, color: Colors.green[900]),
                          ),
                        ),
                        DataCell(Text(
                          index == 2 || index == 3 ? '20' : '10',
                          style:
                              TextStyle(color: Colors.green[900], fontSize: 20),
                        )),
                      ],
                    );
                  },
                ) +
                [
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          'Total',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataCell(
                        Text(
                          _calculateTotalCarryMark().toString(),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[800]),
                        ),
                      ),
                      DataCell(
                        Text(
                          '60',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                totalMark = _calculateTotalCarryMark();
                _showEditDialog();

                _saveItem();
              },
              child: Text('Save Changes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SubjectAttendancePage(subject: subject),
                  ),
                );
              },
              child: Text('Check Attendance'),
            ),
          ],
        ),
      ),
    );
  }

  String _getPartName(int index) {
    switch (index) {
      case 0:
        return 'Quiz';
      case 1:
        return 'Lab Report';
      case 2:
        return 'Midterm Test';
      case 3:
        return 'Assignment';
      default:
        return '';
    }
  }

  double _calculateTotalCarryMark() {
    double total = 0.0;
    for (double mark in carryMarks) {
      total += mark;
    }
    return total;
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Changes Saved'),
          content: Text('Carry marks have been updated.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
