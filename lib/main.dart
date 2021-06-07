import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pet_app_ui/pages/home_page.dart';
import 'package:pet_app_ui/pages/loginRgis/welcome_screen.dart';
import 'package:pet_app_ui/pages/search_page.dart';
import 'package:pet_app_ui/theme/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'controller/userDataController.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => UserDataController(), 
    child: MyApp()
    )
    );

class MyApp extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    return user != null;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet App UI',
      theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
          scaffoldBackgroundColor: appBackground),
      home: WelcomeScreen(),
    );
  }
}

class RootPage extends StatefulWidget {
  String userid;
  RootPage({this.userid});
  @override
  _RootPageState createState() => _RootPageState(userid: userid);
}

class _RootPageState extends State<RootPage> {
  String userid;
  _RootPageState({this.userid});
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: Icon(
          LineIcons.home,
          size: 27,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            "Home",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        )),
    BottomNavigationBarItem(
        icon: Icon(
          LineIcons.search,
          size: 27,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            "Search",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        )),
    BottomNavigationBarItem(
        icon: Icon(LineIcons.book, size: 27),
        title: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            "Articles",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        )),
    BottomNavigationBarItem(
        icon: Icon(LineIcons.bell, size: 27),
        title: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            "Notification",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        )),
    BottomNavigationBarItem(
        icon: Icon(LineIcons.user, size: 27),
        title: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            "Profile",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ))
  ];
  int selectedIndex = 0;
  List<Widget> pages = [
    Homepage(),
    SearchPage(),
    Center(
      child: Text(
        "Articles",
        style: TextStyle(fontSize: 40),
      ),
    ),
    Center(
      child: Text(
        "Notifications",
        style: TextStyle(fontSize: 40),
      ),
    ),
    Center(
      child: Text(
        "Profile",
        style: TextStyle(fontSize: 40),
      ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
    create: (context) => UserDataController(), 
        
        child: getBody()),
        
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BottomNavigationBar(
          items: items,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          selectedItemColor: primary,
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget getBody() {
    return pages.elementAt(selectedIndex);
  }
}
