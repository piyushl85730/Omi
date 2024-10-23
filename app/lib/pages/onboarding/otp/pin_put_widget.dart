import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

Widget buildPinPut(context, controller) {
  return Pinput(
    controller: controller,
    onCompleted: (pin) => debugPrint(pin),
    keyboardType: TextInputType.number,
    defaultPinTheme: PinTheme(
      width: MediaQuery.of(context).size.height * 0.04,
      height: 50,
      textStyle: const TextStyle(
          fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white24),
      padding: EdgeInsets.zero,
    ),
    length: 6,
  );
}
