import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pet_app_ui/pages/loginRgis/login_screen.dart';
import 'package:pet_app_ui/pages/loginRgis/registration_screen.dart';
import 'package:pet_app_ui/theme/constant.dart';


import 'package:pet_app_ui/widgets/rounded_button.dart';


import 'registration_screen.dart';


class WelcomeScreen extends StatefulWidget {
  static String id =
      'welcome_screen'; //staic to ot to make object while calkling
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

//ticker provider
class _WelcomeScreenState extends State<WelcomeScreen> {


  void initState() {
    //this method invokes at the very beginning
    //when _WelcomeScreenState created
    super.initState();
  


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('assets/images/lolo_dog.png',height: 150,),
                    height: 130,
                  ),
                ),
                // TypewriterAnimatedTextKit(
                //   text: ['Sagar On'],
                //   textStyle: TextStyle(
                //     fontSize: 45.0,
                //     fontWeight: FontWeight.w900,
                //     color: Colors.blue
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              color: primary,
              onPressed: () {
                  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );
             //   Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Register',
              color: Colors.teal[700],
              onPressed: () {
                  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => RegistrationScreen()),
  );
               // Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
            FlatButton(
              onPressed: () {
               // Navigator.pushNamed(context, HomePage.id);
              },
              child: Text("Skip"),
            ),
          ],
        ),
      ),
    );
  }
}
