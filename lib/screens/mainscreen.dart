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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                    margin: EdgeInsets.symmetric(
                      horizontal: 50,
                    ),
                    child: Text('Green',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 110.0, 0.0, 0.0),
                    margin: EdgeInsets.symmetric(
                      horizontal: 80,
                    ),
                    child: Text('Forma',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(230.0, 115.0, 0.0, 0.0),
                    margin: EdgeInsets.symmetric(
                      horizontal: 90,
                    ),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
              child: TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                    labelText: 'USERNAME',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                obscureText: true,
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 150,
              ),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.greenAccent,
                color: Colors.green,
                elevation: 7.0,
                child: FlatButton(
                  onPressed: () async {
                    final String username = usernameController.text.trim();
                    final String password = passwordController.text.trim();

                    if (username.isEmpty) {
                      print("Username is Empty");
                    } else {
                      if (password.isEmpty) {
                        print("Password is Empty");
                      } else {
                        QuerySnapshot snap = await FirebaseFirestore.instance
                            .collection("users")
                            .where("username", isEqualTo: username)
                            .get();
                        context.read<AuthService>().login(
                          snap.docs[0]['email'],
                          password,
                        );
                      }
                    }
                  },
                  child: Text(
                    "LOG IN",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 40.0,
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(
                horizontal: 150,
              ),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.0),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0)),
                child: FlatButton(
                  onPressed: () {
                    final String email = emailController.text.trim();
                    final String username = usernameController.text.trim();
                    final String password = passwordController.text.trim();

                    if (email.isEmpty) {
                      print("Email is Empty");
                    } else {
                      if (password.isEmpty) {
                        print("Password is Empty");
                      } else {
                        context
                            .read<AuthService>()
                            .signUp(
                          email,
                          password,
                          "user",
                          username,
                        )
                            .then((value) async {
                          User user = FirebaseAuth.instance.currentUser;

                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(user.uid)
                              .set({
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
                  child: Text(
                    "Sign up !",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
