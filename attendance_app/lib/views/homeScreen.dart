import 'package:attendance_app/main.dart';
import 'package:attendance_app/verfied/login.dart';
import 'package:attendance_app/verfied/signup.dart';
import 'package:attendance_app/views/Attendt.dart';
import 'package:attendance_app/views/attendace.dart';
import 'package:attendance_app/views/homescreen2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attendance_app/views/navigation_drawer.dart';
import 'package:attendance_app/views/drawer_items.dart';
import 'package:attendance_app/views/people.dart';
//import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  late String greeting; // Declare the greeting field

  // Add a named constructor to initialize greeting
  HomeScreen.withGreeting(String greeting) : greeting = greeting;

  String gifUrl = "images/animation.gif";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFinished = false;
  bool alertShown = false;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // Initialize greeting in initState
    widget.greeting = getGreeting();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (user != null) {
        showLoginAlertDialog(context);
      }
    });
  }

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good morning!";
    } else if (hour < 17) {
      return "Good afternoon!";
    } else {
      return "Good evening!";
    }
  }
String username = '';
  signout() async {
    await FirebaseAuth.instance.signOut();
  }
  void showLoginAlertDialog(BuildContext context) async {
    if (alertShown) {
      return; // Do nothing if the alert is already shown
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Mark Your Attendance!"),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the AlertDialog
                alertShown = true; // Set the flag to true

                // Navigate to Attendance screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Attend()),
                )..then((value) {
                    // This block will be executed when returning from the AttendanceScreen
                    // If you need to navigate to HomeScreen, do it here
                    if (value == true) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Attend()),
                      );
                    }
                  });
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
  // After the alert is dismissed, navigate to the desired screen

  // signout() async {
  //   await FirebaseAuth.instance.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //--------------sideBar-------------
      drawer: Drawer(
        child: Material(
          color: Color.fromARGB(255, 242, 239, 239),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
            child: Column(
              children: [
                headerWidget(),
                const SizedBox(
                  height: 10.0,
                ),
                Divider(
                  thickness: 1,
                  //indent: 3,
                  //endIndent: 10,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                DrawerItems(
                  name: "People",
                  icon: Icons.people,
                  onPressed: () => onItemPressed(context, index: 0),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Divider(
                  thickness: 1,
                  //indent: 3,
                  //endIndent: 10,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                DrawerItems(
                    name: "About",
                    icon: Icons.report,
                    onPressed: () => onItemPressed(context, index: 0)),
                const SizedBox(
                  height: 4.0,
                ),
                Divider(
                  thickness: 1,
                  //indent: 3,
                  //endIndent: 10,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                DrawerItems(
                  name: "Attendace...",
                  icon: Icons.login_rounded,
                  onPressed: (() async {
                    await signout();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AttendanceScreen()));
                  }),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                Divider(
                  thickness: 1,
                  //indent: 3,
                  //endIndent: 10,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                DrawerItems(
                    name: "feedback",
                    icon: Icons.people,
                    onPressed: () => onItemPressed(context, index: 0)),
                const SizedBox(
                  height: 4.0,
                ),
                Divider(
                  thickness: 1,
                  //indent: 3,
                  //endIndent: 10,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                DrawerItems(
                    name: "help",
                    icon: Icons.people,
                    onPressed: () => onItemPressed(context, index: 0)),
                const SizedBox(
                  height: 4.0,
                ),
                Divider(
                  thickness: 1,
                  //indent: 3,
                  //endIndent: 10,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                DrawerItems(
                  name: "Logout...",
                  icon: Icons.login_rounded,
                  onPressed: (() async {
                    await signout();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  }),
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
      //----------------------HomeScreen----------------------
      appBar: AppBar(
        title: Text("HomePage 1 "),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4),
            child: Container(
              height: 160,
              color: Colors.white,
              padding: EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello! ',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          getGreeting(),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 18),
                        Text(
                          "Check todays updates! ",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      "images/animation.gif", // Use Image.asset for local assets
                      height: 210,
                      width: 210,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 18),
          Padding(
            padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4),
            child: Container(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate on container click
                      // Add your navigation logic here
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black45, width: 3.0), // Add border
                          borderRadius: BorderRadius.circular(12.0),
                          // Optional: Add border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.9),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Java Func.",
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 14),
                            Text(
                              "Java Advance",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //

                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black45, width: 3.0), // Add border
                        borderRadius: BorderRadius.circular(12.0),
                        // Optional: Add border radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Java Func.",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 14),
                          Text(
                            "Java Advance",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black45, width: 3.0), // Add border
                        borderRadius: BorderRadius.circular(12.0),
                        // Optional: Add border radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Java Func.",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 14),
                          Text(
                            "Java Advance",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black45, width: 3.0), // Add border
                        borderRadius: BorderRadius.circular(12.0),
                        // Optional: Add border radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Java Func.",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 14),
                          Text(
                            "Java Advance",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black45, width: 3.0), // Add border
                        borderRadius: BorderRadius.circular(12.0),
                        // Optional: Add border radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Java Func.",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 14),
                          Text(
                            "Java Advance",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4),
            child: Container(
              height: 160,
              margin: EdgeInsets.only(right: 10.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/intro2.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Column(
                        children: [
                          Container(
                              //adjusting the title
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Operating System",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                              )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            //adjusting the title
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Mrs. Jully Porchey",
                              //style: AppWidget.LightTextFeildStyle(),
                            ),
                          ),
                          Container(
                            //adjusting the title
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "\$40",
                              //style: AppWidget.semiBoldTextFeildStyle(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4),
            child: Container(
              height: 160,
              margin: EdgeInsets.only(right: 10.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/intro2.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Column(
                        children: [
                          Container(
                              //adjusting the title
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Container and Orchestration",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                              )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            //adjusting the title
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Dr.Thomas . P",
                              //style: AppWidget.LightTextFeildStyle(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4),
            child: Container(
              height: 160,
              margin: EdgeInsets.only(right: 10.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/intro2.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Column(
                        children: [
                          Container(
                              //adjusting the title
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "OS Assignment Submission",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                              )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            //adjusting the title
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Miss.Juelia Lomunius",
                              //style: AppWidget.LightTextFeildStyle(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4),
            child: Container(
              height: 160,
              margin: EdgeInsets.only(right: 10.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/intro2.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Column(
                        children: [
                          Container(
                              //adjusting the title
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Java Advance",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                              )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            //adjusting the title
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Dr.Jack",
                              //style: AppWidget.LightTextFeildStyle(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4),
            child: Container(
              height: 160,
              margin: EdgeInsets.only(right: 10.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/intro2.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Column(
                        children: [
                          Container(
                              //adjusting the title
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Python Core",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                              )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            //adjusting the title
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Dr.Christopher .D",
                              //style: AppWidget.LightTextFeildStyle(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4),
            child: Container(
              height: 160,
              margin: EdgeInsets.only(right: 10.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/intro2.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Column(
                        children: [
                          Container(
                              //adjusting the title
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Infrastructure Security",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                              )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            //adjusting the title
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "Dr. Stein Thomas",
                              //style: AppWidget.LightTextFeildStyle(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: (() async {
      //     await signout();
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (context) => LoginPage()));
      //   }),
      //   child: Icon(Icons.login_rounded),
      // ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const People()));
        break;
      default:
        Navigator.pop(context);
        break;
    }
  }

  Widget headerWidget() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          // backgroundImage: NetworkImage(url)
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username.isNotEmpty ? username : 'Anonymous',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Text(
                  user?.email ?? "No email",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
