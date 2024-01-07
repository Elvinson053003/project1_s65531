import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubjectAttendancePage extends StatefulWidget {
  final String subject;

  SubjectAttendancePage({required this.subject});

  @override
  _SubjectAttendancePageState createState() =>
      _SubjectAttendancePageState(subject: subject);
}

class _SubjectAttendancePageState extends State<SubjectAttendancePage> {
  final String subject;

  _SubjectAttendancePageState({required this.subject});
  List<AttendanceStatus> attendanceStatusList =
      List.generate(14, (index) => AttendanceStatus.absent);
  String statusStatement = '';

  //refer shopping_list
  void _saveItem() async {
    final url = Uri.https(
        'project1-95656-default-rtdb.asia-southeast1.firebasedatabase.app',
        'project1.json');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {'status': statusStatement, 'subject': subject},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalWeeks = attendanceStatusList.length;
    int totalAttendedWeeks = attendanceStatusList
        .where((status) => status == AttendanceStatus.attend)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject} Attendance'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text('Week')),
                DataColumn(label: Text('Attend')),
                DataColumn(label: Text('Absent')),
              ],
              rows: List<DataRow>.generate(
                attendanceStatusList.length,
                (index) {
                  return DataRow(
                    cells: [
                      DataCell(Text('Week ${index + 1}')),
                      DataCell(
                        GestureDetector(
                          onTap: () {
                            _setAttendanceStatus(
                                index, AttendanceStatus.attend);
                          },
                          child: attendanceStatusList[index] ==
                                  AttendanceStatus.attend
                              ? Icon(Icons.fiber_manual_record,
                                  color: Colors.green)
                              : Icon(Icons.radio_button_unchecked,
                                  color: Colors.grey),
                        ),
                      ),
                      DataCell(
                        GestureDetector(
                          onTap: () {
                            _setAttendanceStatus(
                                index, AttendanceStatus.absent);
                          },
                          child: attendanceStatusList[index] ==
                                  AttendanceStatus.absent
                              ? Icon(Icons.fiber_manual_record,
                                  color: Colors.red)
                              : Icon(Icons.radio_button_unchecked,
                                  color: Colors.grey),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.all(3),
              padding: EdgeInsets.all(5),
              child: Text(
                totalAttendedWeeks / totalWeeks >= 0.8
                    ? 'You are eligible to attend the final exam!                                      '
                    : 'You need to attend at least 80% of classes to be eligible for the final exam.',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: totalAttendedWeeks / totalWeeks >= 0.8
                      ? Colors.green
                      : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                statusStatement = totalAttendedWeeks / totalWeeks >= 0.8
                    ? 'You are eligible to attend the final exam!                                      '
                    : 'You need to attend at least 80% of classes to be eligible for the final exam.';
                _saveItem();
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void _setAttendanceStatus(int weekIndex, AttendanceStatus status) {
    setState(() {
      attendanceStatusList[weekIndex] = status;
    });
  }
}

enum AttendanceStatus {
  attend,
  absent,
}
