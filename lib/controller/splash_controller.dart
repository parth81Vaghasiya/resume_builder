import 'dart:async';

import 'package:get/get.dart';
import 'package:resume_builder/view/home_screen.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      return Get.off( const HomeScreen());
    });
    super.onReady();
  }
}
