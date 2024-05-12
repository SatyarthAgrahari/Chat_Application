import 'package:chat_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget ourButton({onPress, color, textcolor, String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(double.infinity, 40),
          shape: const LinearBorder()),
      onPressed: onPress,
      child: title!.text.color(textcolor).fontFamily(bold).make());
}
