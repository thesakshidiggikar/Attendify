import 'package:attendance_app/teacher_interace/student_listitem.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherInterface extends StatefulWidget {
  const TeacherInterface({super.key});

  @override
  State<TeacherInterface> createState() => _TeacherInterfaceState();
}

class _TeacherInterfaceState extends State<TeacherInterface> {
  List<Map<String, dynamic>> AttendanceRecords = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAttendanceRecord();
  }

  getAttendanceRecord() async {
    var records =
        await FirebaseFirestore.instance.collection("attendance").get();
    for (var i in records.docs) {
      AttendanceRecords.add(i.data());
    }
    print(AttendanceRecords.length);
    isLoading = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher Screen"),
      ),
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: AttendanceRecords.length,
            itemBuilder: (context, index) {
              return StudentListItem(attendanceRecord: AttendanceRecords[index]);
            },
          )
        ]),
      ),
    );
  }

  getStudentName({required String studentID}) async {

  }

}
