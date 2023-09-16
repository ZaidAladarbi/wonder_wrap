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
      350 * AppRatio.widthRatio; // ==> get from media.query
  static const double titleFontSize = 30;
  static const double subTitleFontSize = 25;
  static const double textFontSize = 20;
  static const String appUrl = 'https://wonderwrap-fjkb7.ondigitalocean.app/ai';
}

class AppColors {
  static const Color primaryTextColor = ConstantColors.whiteColor;
  static const Color secondaryTextColor = ConstantColors.redColor;
  static const Color otherTextColor = Colors.black;
  static Color backgroundColor =
      ConstantColors.whiteColor; //Colors.deepOrange[50]!;
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
  static const Color textFieldColor = Colors.grey; //ConstantColors.redColor;
  static const Color textOfTextFieldColor = Colors.black;
}

class DividerConstants {
  static const Color dividerColor = ConstantColors.redColor;
}

class SliderConstants {
  static const double sliderWidth = 250 * AppRatio.widthRatio;
  static const Color sliderActiveColor = ConstantColors.redColor;
  //static const Color sliderInactiveColor = ConstantColors.whiteColor;
  static const Color thumbColor = ConstantColors.redColor;
}

class MultiOptionConstants {
  static const double sizedBoxWidth = 280 * AppRatio.widthRatio;
  static const double sizedBoxHeight = 280;
  static const double buttonWidth = 130 * AppRatio.widthRatio;
  static const double buttonHeight = 42;
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
