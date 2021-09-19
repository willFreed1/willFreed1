import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenforma/routes/nav-drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(backgroundColor: Colors.green,
      title: Text('HomePage'),),
      body: Center(
        child: GestureDetector(
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
          child: Text("THIS IS HOME"),
        ),
      ),
    );
  }
}