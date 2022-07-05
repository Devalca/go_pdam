import 'package:flutter/material.dart';

import 'components/home_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.uid}) : super(key: key);
  final String? uid;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(
        uid: widget.uid,
      ),
    );
  }
}
