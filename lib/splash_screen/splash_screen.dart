import 'package:chat_app/auth_screen/signup_screen.dart';
import 'package:chat_app/consts/consts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Creating Method to change the screen

  void changeScreen() {
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      // using GetX
      Get.to(() => const SignupScreen());
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              logo,
              width: 100,
            ),
            5.heightBox,
            onStart.text.color(darkFontGrey).fontFamily(bold).size(25).make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
