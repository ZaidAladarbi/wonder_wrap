// ignore_for_file: file_names, await_only_futures

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'package:compute/compute.dart';

import 'AppConstants.dart';

AppLib appLib = AppLib();

class AppLib {
  Widget insertPhoto(
      {String path =
          "/Users/admin/Desktop/Development/wonder_wrap/images/logo.png"}) {
    return Image.asset(path, fit: BoxFit.cover);
  }

  Widget createRichText(String text,
      {Color textColor = AppColors.otherTextColor,
      double fontSize = ButtonConstants.buttonFontSize,
      String fontFamily = 'quicksand',
      bool bold = false,
      bool underLine = false}) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily,
          color: textColor,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          decoration:
              underLine ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }

  Widget createButton(
    String text,
    var navigationdPage,
    BuildContext context, {
    double height = ButtonConstants.buttonHeight,
    double width = ButtonConstants.buttonWidth,
    Color buttonColor = ButtonConstants.primaryButtonColor,
    Color textColor = AppColors.primaryTextColor,
    Color borderColor = ButtonConstants.primaryButtonColor,
  }) {
    return SizedBox(
        width: width,
        height: height,
        child: TextButton(
            style: TextButton.styleFrom(
              elevation: 2,
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: borderColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => navigationdPage),
              );
            },
            child: createRichText(text, textColor: textColor)));
  }

  Widget createFunctionButton(
    String text,
    BuildContext context,
    Function() onPressed, {
    double height = ButtonConstants.buttonHeight,
    double width = ButtonConstants.buttonWidth,
    Color buttonColor = ButtonConstants.primaryButtonColor,
    Color textColor = AppColors.primaryTextColor,
  }) {
    return SizedBox(
        width: width,
        height: height,
        child: TextButton(
            style: TextButton.styleFrom(
              elevation: 2,
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              await onPressed();
            },
            child: createRichText(text, textColor: textColor)));
  }

  Widget createTextField(TextEditingController controller, String label,
      {double width = TextFieldConstants.textFieldWidth,
      double height = TextFieldConstants.textFieldHeight}) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: TextFieldConstants.textOfTextFieldColor),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: TextFieldConstants.textOfTextFieldColor),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: TextFieldConstants.textFieldColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: TextFieldConstants.textFieldColor),
          ),
        ),
        obscureText: label == 'Password' || label == 'Confirm Password',
      ),
    );
  }

  Widget createColumn(List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget createPage(BuildContext context, var child,
      {double height = AppConstants.pageHeight,
      double width = AppConstants.pageWidth}) {
    return Scaffold(
        body: Center(
            child: Container(
                color: AppColors.backgroundColor,
                height: height,
                width: width,
                child: Center(child: child))));
  }

  Widget createPageWithBack(BuildContext context, var child,
      {double height = AppConstants.pageHeight,
      double width = AppConstants.pageWidth}) {
    return Scaffold(
        body: Column(children: [
      IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back))
    ]));
  }

  // GifteePage functions
  Widget createMultiButton(
    String label,
    String selected,
    Function(String) onPressed, {
    double height = ButtonConstants.buttonHeight,
    double width = ButtonConstants.buttonWidth,
    Color borderColor = ButtonConstants.primaryButtonColor,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: selected == label
                ? ButtonConstants.primaryButtonColor
                : ButtonConstants.secondaryButtonColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            onPressed(label);
          },
          child: createRichText(
            label,
            bold: true,
            textColor: selected == label
                ? ButtonConstants.secondaryButtonColor
                : ButtonConstants.primaryButtonColor,
          )),
    );
  }

  Widget createAgeSlider(double selectedAge, ValueChanged<double> onChanged,
      {double sliderWidth = SliderConstants.sliderWidth,
      Color sliderActiveColor = SliderConstants.sliderActiveColor,
      Color sliderInactiveColor = SliderConstants.sliderInactiveColor,
      Color thumbColor = SliderConstants.thumbColor,
      double trackThickness = 2}) {
    return SizedBox(
      width: sliderWidth,
      child: SliderTheme(
        data: SliderThemeData(
          activeTrackColor: sliderActiveColor,
          inactiveTrackColor: Colors.deepOrange[50], //sliderInactiveColor,
          thumbColor: thumbColor,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
          trackHeight: trackThickness,
        ),
        child: Slider(
          value: selectedAge,
          min: 0,
          max: 100,
          onChanged: onChanged,
        ),
      ),
    );
  }

  // SignUpPage functions
  Widget createNameRow(var firstNameController, var lastNameController) {
    double width = (TextFieldConstants.textFieldWidth / 2) - 5;
    double height = TextFieldConstants.textFieldHeight;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        createTextField(firstNameController, 'First Name',
            width: width, height: height),
        SizedBox(width: 10),
        createTextField(lastNameController, 'Last Name',
            width: width, height: height),
      ],
    );
  }

  Widget createDividerWithText(String text,
      {double dividerWidth = TextFieldConstants.textFieldWidth}) {
    return SizedBox(
      width: dividerWidth,
      child: Row(
        children: [
          Expanded(child: Divider(color: DividerConstants.dividerColor)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: DividerConstants.dividerColor,
              ),
            ),
          ),
          Expanded(child: Divider(color: DividerConstants.dividerColor)),
        ],
      ),
    );
  }

  Widget createGuestureText(
      String text, var navigationdPage, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigationdPage),
        );
      },
      child: createRichText('Sign up', bold: true), // underLine: true),
    );
  }

  // RelationAndOcassionPage function
  Widget createSelectOption(
    String hintText,
    List<String> options,
    String selectedOption,
    Function(String) onChanged, {
    Color borderColor = ButtonConstants.primaryButtonColor,
  }) {
    return SizedBox(
      width: MultiOptionConstants.sizedBoxWidth,
      child: createColumn([
        createRichText(hintText,
            fontSize: MultiOptionConstants.buttonFontSize, bold: true),
        SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MultiOptionConstants.buttonWidth /
                  MultiOptionConstants.buttonHeight,
              crossAxisSpacing: 10,
              mainAxisSpacing: 6),
          itemCount: options.length,
          itemBuilder: (context, index) {
            String option = options[index];
            bool isSelected = option == selectedOption;

            return SizedBox(
              width: MultiOptionConstants.buttonWidth,
              height: MultiOptionConstants.buttonHeight,
              child: TextButton(
                onPressed: () {
                  onChanged(option);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // Remove default padding
                  backgroundColor: isSelected
                      ? ButtonConstants.primaryButtonColor
                      : ButtonConstants.secondaryButtonColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: isSelected
                          ? ButtonConstants.primaryButtonColor
                          : Colors.pink[200]!, //borderColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: createRichText(
                  bold: true,
                  option,
                  textColor: isSelected
                      ? AppColors.primaryTextColor
                      : AppColors
                          .secondaryTextColor, //AppColors.otherTextColor,
                ),
              ),
            );
          },
        ),
      ]),
    );
  }

  // QuestionPage function
  Widget decodePhoto(String base64EncodedImageString) {
    Uint8List decodedImage = base64Decode(base64EncodedImageString);
    return Image.memory(decodedImage);
  }

  Future<Uint8List> decodePhotoAsync(String base64EncodedImageString) async {
    return await compute(base64Decode, base64EncodedImageString);
  }

  Widget createSwipingImageCard(
      String base64EncodedImageString, Function(bool) handleSwipe) {
    return FutureBuilder<Uint8List>(
      future: decodePhotoAsync(base64EncodedImageString),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Container(
            color: AppColors.backgroundColor,
            width: SwipingCardsConstants.photoWidth,
            height: SwipingCardsConstants.photoHeight,
            child: Dismissible(
              key: Key(base64EncodedImageString), // Unique key for the card
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  // Swiped to the left (dislike)
                  handleSwipe(false);
                } else if (direction == DismissDirection.startToEnd) {
                  // Swiped to the right (like)
                  handleSwipe(true);
                }
              },
              child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: decodePhoto(base64EncodedImageString)),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget createTitleRichText(
    String text, {
    Color textColor = AppColors.otherTextColor,
  }) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: AppConstants.titleFontSize,
          fontFamily: 'Roboto',
          color: textColor,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
        ),
        children: <InlineSpan>[
          WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: SizedBox(width: 10)),
        ],
      ),
    );
  }
}
