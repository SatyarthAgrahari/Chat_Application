import 'package:chat_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget customTextField(
    {String? hint, String? title, IconData? icon, controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.white.size(17).fontFamily(semibold).make(),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: darkFontGrey,
          ),
          filled: true,
          fillColor: lightGrey,
        ),
      ),
      5.heightBox,
    ],
  );
}
