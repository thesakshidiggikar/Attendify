import 'package:attendance_app/views/homeScreen.dart';
import 'package:attendance_app/views/homescreen2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:cloud_firestore/cloud_firestore.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AttendanceScreen(),
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late List<bool> attendanceList;
  late DateTime currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    attendanceList = List.generate(
      DateTime(currentDate.year, currentDate.month + 1, 0).day,
      (index) => false,
    );

    // Call the function to load attendance data
    loadAttendanceData();
  }

  @override
  Widget build(BuildContext context) {
    String month = DateFormat('MMMM yyyy').format(currentDate);

    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Sheet: $month"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: ((context) => HomeScreen2())),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "For Month ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "$month",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: List.generate(
                attendanceList.length,
                (index) => Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(14),
                    color: attendanceList[index]
                        ? Colors.green
                        : currentDate.day == index + 1
                            ? Colors.blue
                            : Colors.transparent,
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        color:
                            attendanceList[index] ? Colors.grey : Colors.black,
                        fontWeight: currentDate.day == index + 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadAttendanceData() async {
    try {
      DateTime currentDate = DateTime.now();
      String formattedCurrentDate =
          "${currentDate.year}-${currentDate.month}-${currentDate.day}";

      // Fetch data from Firestore for the current date
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('attendance')
              .where('date', isEqualTo: formattedCurrentDate)
              .get();

      // Check if there is a document with status 'p' for the current date
      bool isPresent = querySnapshot.docs.isNotEmpty &&
          querySnapshot.docs.first['status'] == 'p';

      // Update the attendanceList using setState
      setState(() {
        // Check if the status is 'p' for present or if it's the current date
        attendanceList[currentDate.day - 1] =
            isPresent || currentDate.day == currentDate.day;
      });
    } catch (e) {
      // Handle errors
      print('Error loading attendance data: $e');
    }
  }

}
