import 'package:FitAdvisor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyles {
  static head(String content, double? size) {
    return Text(
      content,
      style: GoogleFonts.manrope(
          color: CustomColor.Whitetext(),
          fontSize: size,
          fontWeight: FontWeight.w900),
    );
  }

  static subtext(content, size, align) {
    return Text(
      content,
      style: GoogleFonts.manrope(color: CustomColor.GreyText(), fontSize: size),
      textAlign: align,
    );
  }
}
