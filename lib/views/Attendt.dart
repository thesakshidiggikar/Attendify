import 'package:attendance_app/views/attendace.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import "package:firebase_auth/firebase_auth.dart";

class Attend extends StatefulWidget {
  const Attend({Key? key}) : super(key: key);

  @override
  State<Attend> createState() => _AttendState();
}

class _AttendState extends State<Attend> {
  bool isFinished = false;

  // Add a reference to your Firestore collection
  final CollectionReference attendanceCollection =
      FirebaseFirestore.instance.collection('attendance');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Swipeable button example"),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
            child: SwipeableButtonView(
              buttonText: "Mark your Attendance",
              buttonWidget: Container(
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                ),
              ),
              activeColor: Colors.green,
              isFinished: isFinished,
              onWaitingProcess: () {
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    isFinished = true;
                  });
                  // When the user swipes, update Firestore
                  updateAttendance();
                });
              },
              onFinish: () async {
                // Navigate to AttendanceScreen on finish
                await Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: AttendanceScreen(),
                  ),
                );
                setState(() {
                  isFinished = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function to update Firestore with attendance data
  void updateAttendance() async {
    try {
      DateTime currentDate = DateTime.now();
      String formattedDate =
          "${currentDate.year}-${currentDate.month}-${currentDate.day}";

      // Update Firestore with the attendance data
      await attendanceCollection.add({
        'date': formattedDate,
        'status': 'p',
        'studentId':
            FirebaseAuth.instance.currentUser!.uid // 'p' for present, you can change it accordingly
      });

      print('Attendance marked for $formattedDate');
    } catch (e) {
      print('Error updating attendance: $e');
    }
  }
}
