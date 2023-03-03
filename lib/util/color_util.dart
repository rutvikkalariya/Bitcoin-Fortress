import 'package:flutter/material.dart';

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }
  return Color(int.parse(hexColor, radix: 16));
}

Color getPrimaryColor() {
  return getColorFromHex("#343434");
}

Color getDarkBackground() {
  return getColorFromHex("#21242D");
}

Color getSecondryColor() {
  return getColorFromHex("#0B52E1");
}

Color gethomeColor() {
  return getColorFromHex("#4A41F4");
}

Color gethomeContainerColor() {
  return getColorFromHex("#2AEFB4");
}

Color gethometEXTColor() {
  return getColorFromHex("#020248");
}

Color getAppBarTextColor() {
  return getColorFromHex("#451873");
}

Color gettopcoinTabColor() {
  return getColorFromHex("#576284");
}

Color gettopcoinTextColor() {
  return getColorFromHex("#E8F1FF");
}

Color gettopcoinBorderColor() {
  return getColorFromHex("#8FD1FE");
}

Color getTrends1Color() {
  return getColorFromHex("#2AEFB4");
}

Color getTrends2Color() {
  return getColorFromHex("#FF3980");
}

Color getTrends3Color() {
  return getColorFromHex("#576284");
}

Color getTrends4Color() {
  return getColorFromHex("#FF3980");
}

Color getTrends5Color() {
  return getColorFromHex("#4A41F4");
}
