import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../Bills/bills_screen.dart';
import '../../Profil/profil_screen.dart';

class NavigateDrawer extends StatefulWidget {
  const NavigateDrawer({Key? key, this.uid}) : super(key: key);
  final String? uid;

  @override
  State<NavigateDrawer> createState() => _NavigateDrawerState();
}

class _NavigateDrawerState extends State<NavigateDrawer> {
  String? _nama;

  DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child("data_report");
  DatabaseReference dbSer = FirebaseDatabase.instance.ref().child("data_user");

  @override
  void initState() {
    dbSer.child(widget.uid!).get().then((DataSnapshot? snapshot) {
      var value = Map<String, dynamic>.from(snapshot!.value as Map);
      setState(() {
        _nama = value['nama'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: null,
            accountName: Text(_nama ?? ""),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.people_alt_outlined, color: Colors.black),
              onPressed: () {},
            ),
            title: const Text('Akun'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilScreen(
                          uid: widget.uid,
                        )),
              );
            },
          ),
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.payment, color: Colors.black),
              onPressed: () {},
            ),
            title: const Text('Tagihan'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BillsScreen(uid: widget.uid!)),
              );
            },
          ),
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.exit_to_app, color: Colors.black),
              onPressed: () {},
            ),
            title: const Text('Keluar'),
            onTap: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((res) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                    (Route<dynamic> route) => false);
              });
            },
          ),
        ],
      ),
    );
  }
}
