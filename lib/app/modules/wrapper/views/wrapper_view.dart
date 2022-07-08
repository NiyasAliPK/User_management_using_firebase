import 'package:firebase/app/modules/authenticate/views/authenticate_view.dart';
import 'package:firebase/app/modules/home/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wrapper_controller.dart';

class WrapperView extends GetView<WrapperController> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            Center(
              child: Text("Something went wrong"),
            );
          } else if (snapshot.hasData) {
            return HomeView();
          }
          return AuthenticateView();
        });
  }
}
