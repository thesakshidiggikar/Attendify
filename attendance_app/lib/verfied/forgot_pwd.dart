// ignore_for_file: depend_on_referenced_packages

import 'package:attendance_app/verfied/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();

  reset() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        leading: GestureDetector(
          onTap: () {
            // Navigate to SignUp page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignUp()),
            );
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: "enter email"),
            ),
            const SizedBox(
              height: 9.0,
            ),
            ElevatedButton(
                onPressed: ((
                ) => reset()), child: Text("Send Link")),
          ],
        ),
      ),
    );
  }
}
