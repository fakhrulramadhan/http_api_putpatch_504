import 'dart:convert'; //utk json

import 'package:flutter/material.dart';
//pakai f1 -> add package pub assistn-> ketik http
import 'package:http/http.dart' as httpku;

void main() {
  runApp(const MyApp());
}

//put buat naruh edit data / replace
//patch buat update / edit data

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Beranda(),
    );
  }
}

//stateful karena mau merubah2 tampilan (data)
class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  //pasang controller handle inputya
  TextEditingController namecont = TextEditingController();
  TextEditingController jobcont = TextEditingController();

  //buat resposenya
  String hasilResponse = "Belum ada Data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Http Put / Patch"),
      ),
      body: ListView(
        //listiviewnya kasih padding agar tidak mepet
        padding: EdgeInsets.all(23),
        children: [
          TextField(
            autocorrect: false, //agar tidak otomatis ngebenarin kata
            keyboardType: TextInputType.text, //type keyboardnya text
            controller: namecont, //controller dari texteditingcontroller namcon
            decoration: InputDecoration(
                labelText: "Name", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            autocorrect: false, //agar tidak otomatis ngebenarin kata
            keyboardType: TextInputType.text, //type keyboardnya text
            controller: jobcont,
            decoration:
                InputDecoration(labelText: "Job", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () async {
                //sekarang pakai http method post,
                //kalau put,  harus ada bodynya utk dilempar datanya
                //buat variabel responseku dulu, await async utk menunggu
                var responseku = await httpku.patch(
                  Uri.parse("https://reqres.in/api/users/4"),

                  //cara parsing / lempar data dari inputan ke body post
                  //namacontroller.text
                  body: {"name": namecont.text, "job": jobcont.text},
                );

                //data responsknya masih berupa string,blm objek
                //print(responseku.body);

                //cara berubh menjadi objeknya yaitu json.decode sebagai mapping
                //nama variabel mapnya dataku
                Map<String, dynamic> dataku =
                    json.decode(responseku.body) as Map<String, dynamic>;

                setState(() {
                  //menampilkan datanya di teks hasil response
                  // string interpolation
                  hasilResponse = "${dataku['name']} - ${dataku['job']} ";
                  //hasilResponse = dataku["name"].toString();
                });
              },
              //enggak benar benar bisa ubah data, karena buat testing
              //server aja.Put dan Patch sama aja
              child: Text("Submit Put /  Patch")),
          SizedBox(
            height: 50, //kasih jarak 50 antara form sama keterangannya
          ),
          Divider(
            color: Colors.black,
          ), //buat pembatas
          SizedBox(
            height: 10,
          ),
          //Text("Data Belum Masuk"),
          Text(hasilResponse)
        ],
      ),
    );
  }
}
