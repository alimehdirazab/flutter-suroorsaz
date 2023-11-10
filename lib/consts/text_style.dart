import 'package:flutter/material.dart';
import 'package:suroorsaz/consts/colors.dart';

const bold = "Bold";
const regular = "Regular";

ourStyle({family = regular, double? size = 14, color = whiteColor}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontFamily: family,
  );
}
