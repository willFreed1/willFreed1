import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';


class EditProfilPage extends StatefulWidget {
  @override
  _EditProfilPageState createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  bool pressed = false;

  var user;

  Future <void> getUserData() async{
    var userData = await FirebaseAuth.instance.currentUser;
    setState(() {
      user = userData;
    });
  }

  @override
  void initState(){
    super.initState();
    getUserData();
  }


  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('BarCode'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
    body: ListView(
      children: <Widget>[
        pressed ?(
    SfBarcodeGenerator(
      value:user.email +"  " +user.uid + "  ",
      symbology: QRCode(),
      showValue: true,
      textSpacing: 15,
    ))

            : SizedBox(),
        RaisedButton(
          child: Text("Generate a Bar Code"),
          onPressed: () {

            setState(() {
              pressed = true;
            });
          },
        )
      ],
    ),
  );
}
