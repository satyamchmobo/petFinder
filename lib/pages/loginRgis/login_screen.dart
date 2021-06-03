import 'package:flutter/material.dart';
import 'package:pet_app_ui/constants/constants.dart';
import 'package:pet_app_ui/widgets/rounded_button.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:pet_app_ui/pages/loginRgis/registration_screen.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  // static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String msg = "";
  String password;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 48.0,
              ),
              Flexible(
                child: Hero(
                  tag:
                      'logo', //animation of flash logo sahred resource animation using tag property of hero widdgety
                  child: Container(
                    height: 200.0,
                    child: Image.asset('assets/images/lolo_dog.png'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextfieldDecoration.copyWith(
                  hintText: 'Enter Your Email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextfieldDecoration.copyWith(
                    hintText: 'Enter Your Password '),
              ),
              msg == "ERROR_USER_NOT_FOUND"
                  ? RoundedButton(
                      title: 'Register',
                      color: Colors.indigoAccent[400],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RootPage()),
                        );
                        // Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                    )
                  : Text(msg),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: ' Log In',
                color: Colors.indigo[400],
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);

                    

                    if (user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RootPage(
                                 
                                )),
                      );
                      print('logged in');
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    switch (e.code) {
                      case "ERROR_WRONG_PASSWORD":
                        setState(() {
                          showSpinner = false;
                          msg = "Wong Password !";
                        });

                        break;
                      case "ERROR_USER_NOT_FOUND":
                        setState(() {
                          showSpinner = false;
                          msg = "ERROR_USER_NOT_FOUND";
                        });

                        break;
                      case "ERROR_NETWORK_REQUEST_FAILED":
                        setState(() {
                          showSpinner = false;
                          msg = "Network Error! Check internet conection.";
                        });

                        break;

                      case "ERROR_INVALID_EMAIL":
                        setState(() {
                          showSpinner = false;
                          msg = "Invalid Email Format !.";
                        });

                        break;

                      default:
                        setState(() {
                          showSpinner = false;
                          msg = "";
                          print(e);
                        });
                    }

                    // setState(() {
                    //   showSpinner = false;
                    //   msg = 'Network Error! check Intenet connection.';
                    // });
                    // print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
