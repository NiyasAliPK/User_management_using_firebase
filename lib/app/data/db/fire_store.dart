import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  final userCollection = FirebaseFirestore.instance.collection('users');

  updateUserData(String name, String job, String mobile, String uid,
      String image, String email, String id) async {
    Get.defaultDialog(
        content: CircularProgressIndicator(), title: 'Please wait...');

    final userCollection =
        FirebaseFirestore.instance.collection('users').doc(uid);

    final data = {
      "Name": name,
      "job": job,
      "Mobile": mobile,
      "Image": image,
      "Email": email,
      "id": id
    };

    await userCollection.set(data);
  }
}
