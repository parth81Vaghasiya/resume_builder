import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app_config/app_color_config.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
          init: SplashController(),
          builder: (logic) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Resume Builder',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Please Wait..',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                const LinearProgressIndicator(
                  backgroundColor: AppColour.primaryColor,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColour.lightYellowColor),
                ),
                SizedBox(
                  height: 25.h,
                )
              ],
            );
          }),
    );
  }
}
