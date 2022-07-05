import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_pdam/screens/Home/home_screen.dart';
import 'package:go_pdam/screens/Profil/components/profil_body.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key, this.uid}) : super(key: key);
  final String? uid;

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String? _nama;
  String? _email;
  String? _idPen;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("data_user");

  @override
  void initState() {
    dbRef.child(widget.uid!).get().then((DataSnapshot? snapshot) {
      Map<dynamic, dynamic>? values = snapshot?.value as Map?;
      setState(() {
        _nama = values!['nama'];
        _email = values['email'];
        _idPen = values['idPelanggan'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: newAppBar(context),
        body: SingleChildScrollView(
            child: ProfilBody(idPen: _idPen, email: _email, nama: _nama)));
  }

  AppBar newAppBar(BuildContext context) {
    return AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(uid: widget.uid)),
              );
            }),
        title: const Text("Profil Page"));
  }
}
