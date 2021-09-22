import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greenforma/screens/adminscreen.dart';
import 'package:greenforma/screens/homescreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String role = 'user';

  @override
  void initState() {
    super.initState();
    _checkRole();
  }

  void _checkRole() async {
    User user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    setState(() {
      role = snap['role'];
    });

    if(role == 'user'){
      navigateNext(HomeScreen());
    } else if(role == 'admin'){
      navigateNext(AdminScreen());
    }
  }

  void navigateNext(Widget route) {
    Timer(Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => route));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (
        Container(
          child: Center(child: Text(''),),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: new NetworkImage('https://images.assetsdelivery.com/compings_v2/nad1992/nad19921505/nad1992150500013.jpg'),

            )
          ),
        )
      ),
    );
  }
}