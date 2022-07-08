import 'dart:convert';
import 'dart:io';
import 'package:firebase/app/data/db/fire_store.dart';
import 'package:firebase/app/modules/authenticate/widgets/screen_login.dart';
import 'package:firebase/app/modules/authenticate/widgets/screen_sign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticateController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isbuttonClicked = false;
  List pages = [ScreenLogIn(), ScreenSignIn()];
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final DatabaseController _databaseController = Get.put(DatabaseController());
  String img = '';

  changePage(bool value) {
    isbuttonClicked = value;
    emailController.clear();
    passwordController.clear();
    update();
  }

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  logIn(String email, String password, dynamic context) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Please enter your login credentials ", '');
      return;
    }
    Get.defaultDialog(
        content: CircularProgressIndicator(), title: 'Please wait...');
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      Get.snackbar(e.message.toString(), '');
      return;
    }
    Get.back();
    emailController.clear();
    passwordController.clear();
  }

  signUp(String email, String password) async {
    final isvalid = formKey.currentState!.validate();
    if (!isvalid) {
      return;
    }
    Get.defaultDialog(
        content: CircularProgressIndicator(), title: 'Please wait...');
    try {
      final UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      _databaseController.updateUserData(
          nameController.text.toString(),
          jobController.text.toString(),
          numberController.text.toString(),
          result.user!.uid,
          img,
          result.user!.email!,
          result.user!.uid);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      Get.snackbar(e.message.toString(), '');
      return;
    }
    Get.back();
    Get.back();
    nameController.clear();
    numberController.clear();
    jobController.clear();
    emailController.clear();
    passwordController.clear();
    img = '';
  }

  pickimage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    } else {
      update();
      final bytes = File(pickedImage.path).readAsBytesSync();
      img = base64Encode(bytes);
      update();
      if (img != '') {
        Get.snackbar(
          "Image picked",
          '',
          colorText: Colors.white,
        );
      }
    }
  }
}
