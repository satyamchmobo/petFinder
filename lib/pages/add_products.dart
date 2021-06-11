import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_app_ui/constants/constants.dart';

import 'package:pet_app_ui/controller/userDataController.dart';
import 'package:pet_app_ui/db/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app_ui/model/userData.dart';
import 'package:pet_app_ui/theme/constant.dart';
import 'package:provider/provider.dart';

List<String> imageList = [];
bool buttonStatus=true;
enum SaleStatus { OnSale, NotOnSale }

SaleStatus _currentSaleStatus = SaleStatus.NotOnSale;

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  bool isLoading = false;
  String hintTextOfLocationTextField = 'Tap this - >';
  String intiVal = null;
  String phno;

  bool showSpinner = false;

  double latitudevalue = 0;
  double longitudevalue = 0;

  void _getCurrentLocation() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      latitudevalue = position.latitude;
      longitudevalue = position.longitude;
      hintTextOfLocationTextField = 'Location Saved';
      intiVal = "Location Saved";
    });
    FlutterToast.showToast(msg: 'Location Saved Succesfully  !');
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  @override
  initState() {
    // _signInAnonymously();
    super.initState();
  }

  Future<void> _signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  List<DropdownMenuItem<String>> caseType = <DropdownMenuItem<String>>[
    DropdownMenuItem(
      child: Text('Adoption'),
      value: 'Adoption',
    ),
    DropdownMenuItem(
      child: Text('Injured'),
      value: 'Injured',
    ),
  ];

  String currentCase = "Injured";

  changeSelectedCase(String selectedCase) {
    setState(() {
      currentCase = selectedCase;
    });
  }

  ProductService _productService = ProductService();

  //List<DropdownMenuItem<String>> iconSeq = ['0','1'];

  Color grey = Colors.grey;
  Color black = Colors.black;

  Color white = Colors.white;

  // File image1=new File('');
  // File image2=new File('');
  // File image3=new File('');

    File image1;
  File image2;
  File image3;

  // List<String> selectedSizes = <String>[]; //for selected checkboxes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
        title: Text(
          "Add Info",
          style: TextStyle(color: black),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Consumer<UserDataController>(builder: (BuildContext context,
            UserDataController userDataController, Widget child) {
          print(userDataController.uid.toString());
          return SingleChildScrollView(
            child: Form(
              ///form, of whole products
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Upload 3 photos of pet case",
                      style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlineButton(
                            onPressed: () {
                              // ignore: deprecated_member_use
                              _selectImage(
                                  ImagePicker.pickImage(
                                      source: ImageSource.gallery),
                                  1);
                            },
                            borderSide:
                                BorderSide(color: Colors.teal[700], width: 1.0),
                            child: _displayChild1(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlineButton(
                            onPressed: () {
                              // ignore: deprecated_member_use
                              _selectImage(
                                  ImagePicker.pickImage(
                                      source: ImageSource.gallery),
                                  2);
                            },
                            borderSide:
                                BorderSide(color: Colors.teal[700], width: 1.0),
                            child: _displayChild2(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlineButton(
                            onPressed: () {
                              // ignore: deprecated_member_use
                              _selectImage(
                                  ImagePicker.pickImage(
                                      source: ImageSource.gallery),
                                  3);
                            },
                            borderSide:
                                BorderSide(color: Colors.teal[700], width: 1.0),
                            child: _displayChild3(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Enter pet case information",
                      style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                    child: TextFormField(
                      controller: productNameController,
                      decoration: InputDecoration(
                        hintText: 'Enter pet Type Ex: Dog/Cat.',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.teal[700], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.teal[700], width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'You must enter the Case Name';
                        } else if (value.length > 30) {
                          return 'Case name cant have more than 10 letters';
                        }
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('Case Type :'),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: SizedBox(
                            height: 35,
                            width: 130,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.lightBlueAccent,
                                        offset: Offset(0.5, 0.5),
                                        blurRadius: 1)
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                                child: DropdownButton<String>(
                                  value: currentCase,
                                  icon: Icon(Icons.expand_more),
                                  iconSize: 20,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.black87),
                                  underline: Container(
                                    height: 0,
                                    width: 0,
                                  ),
                                  onChanged: (value) {
                                    changeSelectedCase(value);
                                  },
                                  items: caseType,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text("Short Description")),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      maxLines: 5,
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration: InputDecoration(
                        hintText: 'Need medical help...',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.teal[700], width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.teal[700], width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
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
                            // password = value;
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

                  // ),

                  Consumer<UserDataController>(builder: (BuildContext context,
                      UserDataController userDataController, Widget child) {
                    var userid = userDataController.uid;
                    var phone = userDataController.phoneno;
                    print(userid.toString());
                    print(phone.toString());

                    print("printing user id in button@@@@@@@@@@@@@@@@@@@@@@@2");
                    return FlatButton(
                    enable:
                      onPressed: buttonStatus?  validateAndUpload(userid, phone):null,
                       
                      
                      },
                      child: Text("Submit Case"),
                      color: primary,
                      textColor: Colors.white,
                      
                    );
                  })
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;

    switch (imageNumber) {
      case 1:
        setState(() {
          image1 = tempImg;
        });

        break;

      case 2:
        setState(() {
          image2 = tempImg;
        });

        break;

      case 3:
        setState(() {
          image3 = tempImg;
        });

        break;
      default:
    }
  }

  Widget _displayChild1() {
    if (image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 50, 8, 50),
        child: Icon(
          Icons.add,
          color: primary,
        ),
      );
    } else {
      return Image.file(image1, fit: BoxFit.cover, width: double.infinity);
    }
  }

  Widget _displayChild2() {
    if (image2 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 50, 8, 50),
        child: Icon(
          Icons.add,
          color: primary,
        ),
      );
    } else {
      return Image.file(image2, fit: BoxFit.cover, width: double.infinity);
    }
  }

  Widget _displayChild3() {
    if (image3 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 50, 8, 50),
        child: Icon(
          Icons.add,
          color: primary,
        ),
      );
    } else {
      return Image.file(
        image3,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
  }

  void validateAndUpload(userid, phone) async {
    if (_formKey.currentState.validate()) {
      if (image1 != null && image2 != null && image3 != null) {


         isLoading = true;
        // if (selectedSizes.isNotEmpty) {
        String imageUrl1; //to hold downloadable link that will be
        //stores in database(firestore or RTDB)
        String imageUrl2;
        String imageUrl3;

        final FirebaseStorage storage = FirebaseStorage.instance;

        //creation of unique names for all 3 images
        final String picture1 =
            "1${DateTime.now().millisecondsSinceEpoch.toString()}";
        final String picture2 =
            "2${DateTime.now().millisecondsSinceEpoch.toString()}";
        final String picture3 =
            "3${DateTime.now().millisecondsSinceEpoch.toString()}";

        //actual uploading to cloud storage by creating tasks

        StorageUploadTask task1 = storage.ref().child(picture1).putFile(image1);
        StorageUploadTask task2 = storage.ref().child(picture2).putFile(image2);
        StorageUploadTask task3 = storage.ref().child(picture3).putFile(image3);

        //after uploading recieving snapshot(for info) of uploaded image

        StorageTaskSnapshot snapshot1 =
            await task1.onComplete.then((snapshot) => snapshot);
        StorageTaskSnapshot snapshot2 =
            await task2.onComplete.then((snapshot) => snapshot);

        //but on recieving snap of third image theri is something
        //different
        //that is on successful uploadation and revieving info of third
        //image we should get downloadable url of all three images

        task3.onComplete.then((snapshot3) async {
          imageUrl1 = await snapshot1.ref.getDownloadURL();
          imageUrl2 = await snapshot2.ref.getDownloadURL();
          imageUrl3 = await snapshot3.ref.getDownloadURL();
          print(imageUrl3);
          print(imageUrl2);
          print(imageUrl1);
          print("==-=-=-");

          imageList = [imageUrl1, imageUrl2, imageUrl3];
        });
        print("llllllllllllllll");
        //print(imageUrl1);

        print(imageList[0]);

        // print(imageList[0].toString());
        // print('llllllllllllllllllllllllll');
        // print(imageList[1]);
        // print(imageList[2]);

        //now after getting image urls from storage
        //we need to pass this along other product details
        // with use of product.dart containing crud code for firestore
        //database
        if (imageList[2] != null) {
          print(userid);
          print("printing userid from model-0=0-0=-0-=0-=0-=0-=0-=0=-0-=0");
          _productService.uploadProducts(
            userid: userid,
            productName: productNameController.text,
            latitudevalue: latitudevalue,
            longitudevalue: longitudevalue,
            // sizes: selectedSizes,
            images: imageList,
            casetype: currentCase,
            phone: phone,
          );
        }
        setState({
buttonStatus=false;
        });

        _formKey.currentState.reset();
        isLoading = false;
        FlutterToast.showToast(msg: 'Succesfully ,Case Added');
        // } else {
        //   FlutterToast.showToast(msg: "Select atleast one size");
        // }
      } else {
        FlutterToast.showToast(msg: "All Images Must be provided");
      }
    }
  }
}
