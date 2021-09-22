import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greenforma/routes/Volunteer.dart';
import 'package:greenforma/routes/formingstructure.dart';
import 'package:greenforma/routes/greenArea.dart';
import 'package:greenforma/routes/partnership.dart';
import 'package:greenforma/routes/settings.dart';
import 'package:greenforma/screens/homescreen.dart';
import 'package:greenforma/main.dart';
import 'package:greenforma/routes/profile.dart';
import 'package:greenforma/screens/mainscreen.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Home',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/greenforma.PNG'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('HOME'),
            onTap: () => {selectItem(context, 0)},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {selectItem(context, 1)},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Volunteer'),
            onTap: () => {selectItem(context, 2)},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Forming Structure'),
            onTap: () => {selectItem(context, 3)},
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('GreenArea'),
            onTap: () => {selectItem(context, 4)},
          ),
          ListTile(
            leading: Icon(Icons.qr_code_2),
            title: Text('BarCode'),
            onTap: () => {selectItem(context, 5)},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {selectItem(context, 6)},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {selectItem(context, 7)},
          ),
        ],
      ),
    );
  }

  selectItem(BuildContext context, int i) {
    switch (i) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
        break;
    }
    switch (i) {
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SettingsUI(),
        ));
        break;
    }
    switch (i) {
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Volunteer(),
        ));
        break;
    }
    switch (i) {
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => formingStruc(),
        ));
        break;
    }
    switch (i) {
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => GreenArea(),
        ));
        break;
    }
    switch (i) {
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditProfilPage(),
        ));
        break;
    }
    switch (i) {
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Settings(),
        ));
        break;
    }
    switch (i) {
      case 7:
        FirebaseAuth.instance.signOut();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainScreen(),
        ));

    }
  }

}
