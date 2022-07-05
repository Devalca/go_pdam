import 'package:flutter/material.dart';

AppBar topbarCos() {
  return AppBar(
    elevation: 0,
    bottom: const TabBar(
      tabs: [
        Tab(
          text: "Daftar",
          icon: Icon(Icons.email_outlined),
        ),
        Tab(text: "Masuk", icon: Icon(Icons.people_outline)),
      ],
    ),
    title: const Text('Selamat Datang'),
  );
}
