import 'package:chat_app/auth_screen/signup_screen.dart';
import 'package:chat_app/common_widgets/custom_text_field.dart';
import 'package:chat_app/common_widgets/our_button.dart';
import 'package:chat_app/consts/consts.dart';
import 'package:chat_app/firebase_functions.dart';
import 'package:chat_app/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          margin: const EdgeInsetsDirectional.only(top: 50),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    logo,
                    width: 50,
                  ),
                  login.text.white.size(30).fontFamily(bold).make(),
                  customTextField(
                      hint: emailHint,
                      title: email,
                      icon: Icons.email,
                      controller: _emailController),
                  customTextField(
                      hint: passwordHint,
                      title: password,
                      icon: Icons.lock,
                      controller: _passwordController),
                  ourButton(
                      title: login,
                      color: blueColor,
                      textcolor: whiteColor,
                      onPress: () {
                        if (_emailController.text.isNotEmpty) {
                          signInWithEmailAndPassword(
                              _emailController.text, _passwordController.text);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          );
                        }
                      }),
                  other.text.color(darkFontGrey).make(),
                  ourButton(
                      title: signup,
                      color: darkFontGrey,
                      textcolor: whiteColor,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
