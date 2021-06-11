import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_app_ui/main.dart';
import 'package:pet_app_ui/widgets/rounded_button.dart';

import 'package:pet_app_ui/constants/constants.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegistrationScreen extends StatefulWidget {
//  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  String email;
  String password;
  String name;
  String msg = ' ';
  String hintTextOfLocationTextField = 'Tap this - >';
  String intiVal = null;
  String phno;

  bool showSpinner = false;

  double latitudevalue = 0;
  double longitudevalue = 0;
  final _formKey = GlobalKey<FormState>();
  void _getCurrentLocation() async {
   // bool serviceEnabled;
      
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      latitudevalue = position.latitude;
      longitudevalue = position.longitude;
      hintTextOfLocationTextField = 'Location Saved';
      intiVal = "Location Saved";
    });
        FlutterToast.showToast(msg: 'Location Saved Succesfulle !');
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          //v v imp thing this is
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                 
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('assets/images/lolo_dog.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  //obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: kTextfieldDecoration.copyWith(
                      hintText: 'Enter Your Name '),
                  //input dec property is defined in kTextField variable which is defined in consant.dart
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                     validator: MultiValidator([
                      RequiredValidator(errorText: "Email is required"),
                      EmailValidator(errorText: "Enter correct email format")
                    ]
                    
                    ),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextfieldDecoration.copyWith(
                      hintText: 'Enter Your Email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 10) {
                      return 'Enter 10 digit phone number';
                    }
                    return null;
                  },
                  //obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    phno = value;
                  },
                  decoration: kTextfieldDecoration.copyWith(
                      hintText: 'Enter phone no.'),
                  //input dec property is defined in kTextField variable which is defined in consant.dart
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Mimum length should be 6';
                    }
                    return null;
                  },
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextfieldDecoration.copyWith(
                      hintText: 'Create your password'),
                  //input dec property is defined in kTextField variable which is defined in consant.dart
                ),
                SizedBox(
                  height: 0.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("To get closest results"),
                ),
         

               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 90,
                      width: 200,
                      child: TextFormField(
                        initialValue: intiVal,
                        validator: (value) {
                          value = intiVal;
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        enabled: false,
                        //obscureText: true,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: kTextfieldDecoration.copyWith(
                          hintText: hintTextOfLocationTextField,
                        ),
                        //input dec property is defined in kTextField variable which is defined in consant.dart
                      ),
                    ),
                    GFButton(
                      onPressed: () {
                        
                        _getCurrentLocation();
                      },
                      text: "Save",
                      icon: Icon(
                        Icons.gps_fixed,
                        color: Colors.white,
                      ),
                      shape: GFButtonShape.pills,
                      size: GFSize.MEDIUM,
                      fullWidthButton: false,
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 1.0,
                // ),
              //  Text(msg),
                RoundedButton(
                  title: 'Register',
                  color: Colors.teal[700],
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);

                        FirebaseUser user = await _auth.currentUser();
                        var userid = user.uid;
                        print(userid);

                        if (userid != null) {
                          await Firestore.instance
                              .collection('users')
                              .document(userid)
                              .setData({
                            'name': name,
                            'phoneno': phno,
                            'password': password,
                            'lat': latitudevalue,
                            'long': longitudevalue,
                          }, merge: true);
                        }

                        setState(() {
                          showSpinner = false;
                        });
                        if (newUser != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RootPage(
                                      userid: userid,
                                      username:name,
                                    )),
                          );
                        }
                      } catch (e) {
                        setState(() {
                          showSpinner = false;

                          msg = e.toString();
                        });
                        print(e);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please provide all information')));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
