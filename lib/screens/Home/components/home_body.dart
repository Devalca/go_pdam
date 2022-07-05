import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_pdam/main.dart';
import 'package:go_pdam/screens/Bills/bills_screen.dart';
import 'package:go_pdam/screens/Home/home_screen.dart';
import 'package:go_pdam/screens/Profil/profil_screen.dart';
import 'package:go_pdam/screens/Report/report_screen.dart';
import 'package:go_pdam/screens/Sub/sub_screen.dart';

import '../../../constant.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key, this.uid}) : super(key: key);
  final String? uid;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String get uid => widget.uid.toString();
  String? _nama;
  String? _lokasi;
  String? _idPelanggan;
  String? _verif;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child("data_report");
  DatabaseReference dbPen =
      FirebaseDatabase.instance.ref().child("data_pelanggan");
  DatabaseReference dbSer = FirebaseDatabase.instance.ref().child("data_user");
  List<Map<dynamic, dynamic>> lists = [];

  @override
  void initState() {
    dbSer.child(widget.uid!).get().then((DataSnapshot? snapshot) {
      var value = Map<String, dynamic>.from(snapshot!.value as Map);
      setState(() {
        _nama = value['nama'];
        _lokasi = value['alamat'];
        _verif = value['idPelanggan'];
      });
    });
    dbPen.child(widget.uid!).get().then((DataSnapshot? snapshot) {
      if (snapshot!.value == null) {
        if (_verif == "") {
          setState(() {
            _idPelanggan = "kosong";
          });
        } else {
          setState(() {
            _idPelanggan = "ada";
          });
        }
      } else {
        setState(() {
          _idPelanggan = "ada";
        });
      }
    });
    super.initState();
  }

  void refreshBtn() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => super.widget));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newAppbar(context),
      floatingActionButton:
          NewFloating(uid: widget.uid, nama: _nama, lokasi: _lokasi),
      drawer: NavigateDrawer(nama: _nama, lokasi: _lokasi, uid: widget.uid),
      body: FutureBuilder(
          future: dbRef.orderByChild("idUser").equalTo(widget.uid).once(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              lists.clear();
              final getfirst = (snapshot.data! as DatabaseEvent).snapshot.value;
              if (getfirst == null) {
                return const Center(child: Text('Data Kosong'));
              } else {
                final firstdata = getfirst as Map<Object?, dynamic>;
                firstdata.forEach((key, values) {
                  lists.add(values);
                });
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          leading: Image.network(lists[index]['gambar']),
                          title:
                              Text("Jenis Keluhan: " + lists[index]['jenis']),
                          subtitle:
                              Text("Keterangan: " + lists[index]['keluhan']),
                          trailing: lists[index]['status'] == "Pending" ||
                                  lists[index]['status'] == "Proses"
                              ? const Icon(Icons.pending_actions)
                              : const Icon(
                                  Icons.done,
                                  color: kPrimaryColor,
                                ),
                          isThreeLine: true,
                        ),
                      );
                    });
              }
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  AppBar newAppbar(BuildContext context) {
    return AppBar(
      title: const Text("PDAM"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.refresh_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            refreshBtn();
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.note_add_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            _idPelanggan == "kosong"
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubScreen(
                              uid: widget.uid!,
                              nama: _nama,
                            )),
                  )
                : showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Terima Kasih"),
                        content: _verif == ""
                            ? const Text(
                                'Pendaftaran sedang di proses, jika data tidak valid silahkan input ulang data asli anda!')
                            : const Text("Terimakasih Sudah Mendaftar"),
                        actions: [
                          TextButton(
                            child: const Text("Ok"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
          },
        ),
      ],
    );
  }
}

class NavigateDrawer extends StatefulWidget {
  const NavigateDrawer({Key? key, this.nama, this.lokasi, this.uid})
      : super(key: key);
  final String? nama;
  final String? lokasi;
  final String? uid;

  @override
  State<NavigateDrawer> createState() => _NavigateDrawerState();
}

class _NavigateDrawerState extends State<NavigateDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: null,
            accountName: Text(widget.nama ?? ""),
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

class NewFloating extends StatelessWidget {
  const NewFloating({
    Key? key,
    this.uid,
    this.nama,
    this.lokasi,
  }) : super(key: key);
  final String? uid;
  final String? nama;
  final String? lokasi;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        lokasi != ""
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ReportScreen(uid: uid, nama: nama, lokasi: lokasi)),
              )
            : showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Alret"),
                    content: const Text(
                        "Silahkan Melakukan Pendaftaran PDAM Terlebih Dahulu Di Pojok Kanan Atas Sebelum Melakukan Laporan"),
                    actions: [
                      TextButton(
                        child: const Text("Ok"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
      },
      backgroundColor: kPrimaryColor,
      child: const Icon(Icons.add_a_photo, color: Colors.white),
    );
  }
}
