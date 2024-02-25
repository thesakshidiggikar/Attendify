import 'package:attendance_app/verfied/login.dart';
import 'package:attendance_app/wrapper.dart';
//import 'package:attendance_app/verfied/signup.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      infiniteAutoScroll: false,
      autoScrollDuration: 3 * 1000,
      pages: [
        PageViewModel(
          title: "",
          bodyWidget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Attendance",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Image.asset("images/intro1.png"),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  "online attandance marking facility with\n ID verified students",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w200,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Online Teaching",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 60.0,
                ),
                Image.asset("images/intro2.png"),
                SizedBox(
                  height: 60.0,
                ),
                Text(
                  "Peer-to-peer teaching \n with personal doubts solving",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w200,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Cources",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Image.asset("images/intro3.png"),
                SizedBox(
                  height: 60.0,
                ),
                Text(
                  "online resources will be avaliable for differnet\ncoursce student can access",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w200,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
      showDoneButton: true,
      onDone: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Wrapper()));
      },
      done: Text("Start "),
      showNextButton: false,
      showBackButton: false,
      showSkipButton: true,
      skip: Text("Skip!"),
    );
  }
}
