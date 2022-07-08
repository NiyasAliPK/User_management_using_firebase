import 'package:get/get.dart';

import 'package:firebase/app/modules/authenticate/bindings/authenticate_binding.dart';
import 'package:firebase/app/modules/authenticate/views/authenticate_view.dart';
import 'package:firebase/app/modules/edit/bindings/edit_binding.dart';
import 'package:firebase/app/modules/edit/views/edit_view.dart';
import 'package:firebase/app/modules/home/bindings/home_binding.dart';
import 'package:firebase/app/modules/home/views/home_view.dart';
import 'package:firebase/app/modules/profile/bindings/profile_binding.dart';
import 'package:firebase/app/modules/profile/views/profile_view.dart';
import 'package:firebase/app/modules/wrapper/bindings/wrapper_binding.dart';
import 'package:firebase/app/modules/wrapper/views/wrapper_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WRAPPER;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATE,
      page: () => AuthenticateView(),
      binding: AuthenticateBinding(),
    ),
    GetPage(
      name: _Paths.WRAPPER,
      page: () => WrapperView(),
      binding: WrapperBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT,
      page: () => EditView(),
      binding: EditBinding(),
    ),
  ];
}
