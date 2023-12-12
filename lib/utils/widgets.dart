import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textWidget(
    {required String text,
    required double fontSize,
    required FontWeight fontWeight,
    required Color fontColor}) {
  return Text(
    text,
    style: GoogleFonts.dmSans(
        color: fontColor, fontSize: fontSize, fontWeight: fontWeight),
  );
}

Widget heightBox(double height) {
  return SizedBox(
    height: height,
  );
}
