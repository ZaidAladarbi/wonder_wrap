// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AppRatio {
  static const double widthRatio = 1.2;
  static const double heightRatio = 1;
}

class ConstantColors {
  static const Color redColor = Colors.pink;
  static const Color whiteColor = Colors.white;
}

class AppConstants {
  static const double pageHeight = 700; // ==> get from media.query
  static const double pageWidth =
      400 * AppRatio.widthRatio; // ==> get from media.query
  static const double titleFontSize = 30;
  static const double subTitleFontSize = 25;
  static const double textFontSize = 20;
  static const String appUrl = 'http://10.0.0.15:8000/ai';//'http://3.13.91.206/ai';
}

class AppColors {
  static const Color primaryTextColor = ConstantColors.whiteColor;
  static const Color secondaryTextColor = ConstantColors.redColor;
  static const Color otherTextColor = Colors.black;
  static Color backgroundColor = Colors.deepOrange[50]!;
}

class ButtonConstants {
  static const double buttonWidth = 250 * AppRatio.widthRatio;
  static const double buttonHeight = 50;
  static const double buttonFontSize = 15;
  static const Color primaryButtonColor = ConstantColors.redColor;
  static const Color secondaryButtonColor = ConstantColors.whiteColor;
}

class TextFieldConstants {
  static const double textFieldWidth = 250 * AppRatio.widthRatio;
  static const double textFieldHeight = 50;
  static const Color textFieldColor = ConstantColors.redColor;
}

class DividerConstants {
  static const Color dividerColor = ConstantColors.redColor;
}

class SliderConstants {
  static const double sliderWidth = 250 * AppRatio.widthRatio;
  static const Color sliderActiveColor = ConstantColors.redColor;
  static const Color sliderInactiveColor = ConstantColors.whiteColor;
  static const Color thumbColor = ConstantColors.redColor;
}

class MultiOptionConstants {
  static const double sizedBoxWidth = 250 * AppRatio.widthRatio;
  static const double sizedBoxHeight = 250;
  static const double buttonWidth = 120 * AppRatio.widthRatio;
  static const double buttonHeight = 35;
  static const double buttonFontSize = 20;
  static const Color clickedButtonColor = ConstantColors.redColor;
  static const Color unclickedButtonColor = ConstantColors.whiteColor;
}

class SwipingCardsConstants {
  static const double photoReductionRatio = 0.79;
  static const double photoWidth = 360 * photoReductionRatio;
  static const double photoHeight = 731 * photoReductionRatio;
}

class PriceRangeConstants {
  static const double minPrice = 10;
  static const double maxPrice = 1000;
}
