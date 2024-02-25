import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentListItem extends StatefulWidget {
  final Map<String, dynamic> attendanceRecord;
  const StudentListItem({super.key, required this.attendanceRecord});

  @override
  State<StudentListItem> createState() => _StudentListItemState();
}

class _StudentListItemState extends State<StudentListItem> {
  bool isLoading = true;
  String studentName = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStudentName(id: widget.attendanceRecord["studentId"]);

    isLoading = false;
    setState(() {});
  }

  Future<void> getStudentName({required String id}) async {
    var record = await FirebaseFirestore.instance
        .collection('user')
        .where("id", isEqualTo: widget.attendanceRecord["studentId"])
        .limit(1)
        .get();
    studentName = record.docs[0].data()['username'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Card(
        child: Container(
          width: 20,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Loading'),
            ],
          ),
        ),
      );
    }
    return Card(
      child: Container(
        width: 20,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(studentName),
            Text(widget.attendanceRecord["status"]),
            Text(widget.attendanceRecord["date"]),
          ],
        ),
      ),
    );
  }
}
