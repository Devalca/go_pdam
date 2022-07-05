import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_pdam/constant.dart';
import 'package:go_pdam/screens/Home/home_screen.dart';
import 'package:go_pdam/screens/Sign/sign_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  User? result = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("Koneksi DB Berhasil!");
    });
    Timer(const Duration(seconds: 3), () {
      if (result != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(uid: result!.uid)));
      } else {
        _auth.signOut();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SignScreen(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: <Color>[
                      Color.fromARGB(255, 225, 0, 255),
                      Color.fromARGB(255, 20, 133, 238)
                      //add more color here.
                    ],
                  ).createShader(const Rect.fromLTWH(0.0, 0.0, 500.0, 100.0))),
            child: const Text(
              "PDAM",
            ),
          ),
          const DefaultTextStyle(
            style: TextStyle(color: kPrimaryColor, fontSize: 12),
            child: Text("Hadir Dengan Inovasi Baru Dalam Digital"),
          )
        ],
      ),
    );
  }
}
