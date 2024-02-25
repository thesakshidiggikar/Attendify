import 'dart:ui';

import 'package:attendance_app/views/drawer_items.dart';
import 'package:attendance_app/views/people.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: Column(
            children: [
              headerWidget(),
              DrawerItems(
                  name: "People",
                  icon: Icons.people,
                  onPressed: () => onItemPressed(context, index: 0)),
              const SizedBox(
                height: 30.0,
              ),
              DrawerItems(
                  name: "About",
                  icon: Icons.people,
                  onPressed: () => onItemPressed(context, index: 0)),
              const SizedBox(
                height: 30.0,
              ),
              DrawerItems(
                  name: "profile",
                  icon: Icons.people,
                  onPressed: () => onItemPressed(context, index: 0)),
              const SizedBox(
                height: 30.0,
              ),
              DrawerItems(
                  name: "feedback",
                  icon: Icons.people,
                  onPressed: () => onItemPressed(context, index: 0)),
              const SizedBox(
                height: 30.0,
              ),
              DrawerItems(
                  name: "Attendance",
                  icon: Icons.people,
                  onPressed: () => onItemPressed(context, index: 0)),
              const SizedBox(
                height: 30.0,
              ),
              DrawerItems(
                  name: "Coming...",
                  icon: Icons.people,
                  onPressed: () => onItemPressed(context, index: 0)),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
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
          //backgroundImage:NetworkImage(url)
        ),
        const SizedBox(
          width: 20,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text("People name",
              style: TextStyle(fontSize: 14, color: Colors.red)),
          SizedBox(
            height: 10,
          ),
          Text("person@gmail.com",
              style: TextStyle(fontSize: 14, color: Colors.red))
        ])
      ],
    );
  }
}
