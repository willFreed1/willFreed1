import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greenforma/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LOGIN / SIGN UP"),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50,),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "EMAIL...",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50,),
              child: TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "USERNAME...",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50,),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "PASSWORD...",
                ),
                obscureText: true,
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              color: Colors.blue,
              child: FlatButton(
                onPressed: () async {
                  final String username = usernameController.text.trim();
                  final String password = passwordController.text.trim();

                  if(username.isEmpty){
                    print("Username is Empty");
                  } else {
                    if(password.isEmpty){
                      print("Password is Empty");
                    } else {
                      QuerySnapshot snap = await FirebaseFirestore.instance.collection("users")
                          .where("username", isEqualTo: username).get();
                      context.read<AuthService>().login(
                        snap.docs[0]['email'],
                        password,
                      );
                    }
                  }
                },
                child: Text("LOG IN"),
              ),
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              color: Colors.red,
              child: FlatButton(
                onPressed: () {
                  final String email = emailController.text.trim();
                  final String username = usernameController.text.trim();
                  final String password = passwordController.text.trim();

                  if(email.isEmpty){
                    print("Email is Empty");
                  } else {
                    if(password.isEmpty){
                      print("Password is Empty");
                    } else {
                      context.read<AuthService>().signUp(
                        email,
                        password,
                        "user",
                        username,
                      ).then((value) async {
                        User user = FirebaseAuth.instance.currentUser;

                        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
                          'uid': user.uid,
                          'email': email,
                          'username': username,
                          'password': password,
                          'role': 'user',
                        });
                      });
                    }
                  }
                },
                child: Text("SIGN UP"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}