import 'package:flutter/material.dart';

class ProfilBody extends StatefulWidget {
  const ProfilBody({Key? key, this.nama, this.email, this.idPen})
      : super(key: key);
  final String? nama;
  final String? email;
  final String? idPen;

  @override
  State<ProfilBody> createState() => _ProfilBodyState();
}

class _ProfilBodyState extends State<ProfilBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.people, size: 50),
                  title: const Text('Nama Lengkap'),
                  subtitle: Text(widget.nama ?? ""),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.mail, size: 50),
                  title: const Text('Email'),
                  subtitle: Text(widget.email ?? ""),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.water, size: 50),
                    title: const Text('ID Pelanggan'),
                    subtitle: Text(
                      widget.idPen == ""
                          ? "Silahkan Lakukan Pendaftaran PDAM"
                          : widget.idPen.toString(),
                      style: const TextStyle(color: Colors.red),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
