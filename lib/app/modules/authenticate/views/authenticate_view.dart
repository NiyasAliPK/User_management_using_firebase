import 'package:firebase/app/modules/authenticate/widgets/screen_login.dart';
import 'package:firebase/app/modules/authenticate/widgets/screen_sign.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/authenticate_controller.dart';

class AuthenticateView extends GetView<AuthenticateController> {
  final AuthenticateController _controller = Get.put(AuthenticateController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticateController>(
      builder: (controller) {
        return _controller.isbuttonClicked == true
            ? ScreenSignIn()
            : ScreenLogIn();
      },
    );
  }
}
