import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'dart:convert';

class ProductService {
  Firestore _firestore = Firestore.instance;
  String collectionName = 'cases';

  void uploadProducts({
    String productName,
    String userid,
   double  latitudevalue,
   double longitudevalue ,

    // List sizes,
    List images,
  }) {
    var id = Uuid();
    String productId = id.v1();

    _firestore.collection(collectionName).document(productId).setData({
      'name': productName,
      'image1': images[0],
      'image2': images[1],
      'image3': images[2],
      'lat':latitudevalue,
      'long': longitudevalue,
      'userid':userid,
    });
  }
}
