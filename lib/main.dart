import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_pdam/screens/Intro/intro_screen.dart';

import 'constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PDAM',
        theme: ThemeData(
            // primaryColor: kPrimaryColor,
            colorScheme:
                const ColorScheme.light().copyWith(primary: kPrimaryColor),
            textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
            scaffoldBackgroundColor: kBackgroundColor,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: const IntroScreen());
  }
}
