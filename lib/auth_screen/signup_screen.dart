import 'package:chat_app/auth_screen/login_user.dart';
import 'package:chat_app/common_widgets/custom_text_field.dart';
import 'package:chat_app/common_widgets/our_button.dart';
import 'package:chat_app/consts/consts.dart';
import 'package:chat_app/firebase_functions.dart';
import 'package:chat_app/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                50.heightBox,
                Image.asset(
                  logo,
                  width: 50,
                ),
                signup.text.white.size(22).fontFamily(bold).make(),
                customTextField(
                    hint: nameHint,
                    title: name,
                    icon: Icons.person,
                    controller: _usernameController),
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
                    title: signup,
                    color: blueColor,
                    textcolor: whiteColor,
                    onPress: () async {
                      User? signUpSuccess =
                          await createUserWithEmailAndPassword(
                              _usernameController.text,
                              _emailController.text,
                              _passwordController.text);
                      if (signUpSuccess != null) {
                        // Navigate to HomeScreen after successful signup
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      }
                    }),
                other.text.color(darkFontGrey).make(),
                ourButton(
                    title: login,
                    color: darkFontGrey,
                    textcolor: whiteColor,
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
