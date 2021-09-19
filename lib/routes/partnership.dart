import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:greenforma/screens/createuserscreen.dart';
import 'package:greenforma/screens/edituserdata.dart';


 class Partnership extends StatelessWidget {
  @override


 /* static QuerySnapshot snap =  FirebaseFirestore.instance.collection('users').where('email', isEqualTo: "frixwillis@gmail.com");
  setState()( {
  email = userEmail;
  role = snap.docs[0]['role'];
  password = snap.docs[0]['password'];

  ableToEdit = true;
  });*/
  Future <QuerySnapshot> querySnapshot  =  FirebaseFirestore.instance.collection("users").where('email', isEqualTo: "frixwillis@gmail.com").get();
 get uid => querySnapshot;



  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('partnerships'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),

        body: Center(

          child: Container(
            height: 200,
            child: SfBarcodeGenerator(
              value: uid.runtimeType.toString(),
              symbology: QRCode(),
              showValue: true,
              textSpacing: 15,
            ),
          ),
        ),
      );
}
