import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/app/modules/wrapper/views/wrapper_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  updateData(
      {String? id,
      String? name,
      String? job,
      String? mobile,
      String? image}) async {
    final user = FirebaseFirestore.instance.collection('users').doc(id);
    final data = {"Name": name, "Mobile": mobile, "job": job, "Image": image};

    Get.defaultDialog(
        content: CircularProgressIndicator(), title: 'Please wait...');

    try {
      print('started');
      await user.update(data).whenComplete(() {
        // navigatorKey.currentState!.pop();
        print('Finished');
        Get.back();
        Get.offAll(() => WrapperView());
        Get.snackbar('Profile has been updated', '', colorText: Colors.white);
      });
    } on FirebaseException catch (e) {
      Get.snackbar(e.message.toString(), "");
    }
  }
}
