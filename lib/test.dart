import 'package:flutter/material.dart';

import 'myLib/AppWidgetsLib.dart';
import 'package:wonder_wrap/myLib/AppConstants.dart';

AppLib appLib = AppLib();

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartingPage(),
    );
  }
}


class StartingPage extends StatefulWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  StartingPageState createState() => StartingPageState();
}

class StartingPageState extends State<StartingPage> {
  final String _title = 'Wonder Wrap';
  final String _subTitle = '\nLet AI choose\nyour Gift';
  final String _buttonText = 'Get Started';

  @override
  Widget build(BuildContext context) {
    return appLib.createPage( context,
      appLib.createColumn([
          appLib.insertPhoto(),
          SizedBox(height: 30),
          appLib.createRichText(_title, bold:true, fontSize: AppConstants.titleFontSize),
          appLib.createRichText(_subTitle, fontSize: AppConstants.subTitleFontSize),
          SizedBox(height: 50),
          appLib.createButton(_buttonText, SignInPage(), context),
      ]));
    }
  }


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final String _signInText = 'Sign In';
  final String _newUserText1 = 'Don\'t have an account';
  final String _signUpText = 'Sign Up';
  final String _guestText = 'Continue as a Guest';

  final String _logInText = 'Log in';
  
  final String _emailLabel = 'Email';
  final String _passwordLabel = 'Password';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return appLib.createPage( context,
      appLib.createColumn([
        appLib.insertPhoto(),
        SizedBox(height: 30),
        appLib.createRichText(_signInText, fontSize: 22, bold:true),
        SizedBox(height: 20),
        appLib.createTextField(emailController, _emailLabel),
        SizedBox(height: 10),
        appLib.createTextField(passwordController, _passwordLabel),
        SizedBox(height: 20),
        appLib.createButton(_logInText, GifteePage(), context),
        SizedBox(height: 15),
        appLib.createRichText(_newUserText1),
        SizedBox(height: 5),
        appLib.createGuestureText(_signUpText, SignUpPage(), context),
        SizedBox(height: 15),
        appLib.createDividerWithText('or'),
        SizedBox(height: 15),
        appLib.createButton(_guestText, GifteePage(), context, buttonColor: ButtonConstants.secondaryButtonColor,textColor: ButtonConstants.primaryButtonColor),
      ])
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final String _createText = 'Create a new account';
  final String _emailLabel = 'Email';
  final String _passwordLabel = 'Password';
  final String _confirmPasswordLabel = 'Confirm Password';
  final String _signUpText = 'Sign up';
  final String _haveAccountText = 'Do you have an account?';
  final String _signInText = 'Sign in';

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return appLib.createPage( context,
      appLib.createColumn([
      appLib.createRichText(_createText,fontSize: AppConstants.subTitleFontSize),
      SizedBox(height: 20),
      appLib.insertPhoto(),
      SizedBox(height: 20),
      appLib.createNameRow(firstNameController, lastNameController),
      SizedBox(height: 5),
      appLib.createTextField(emailController, _emailLabel),
      SizedBox(height: 5),
      appLib.createTextField(passwordController, _passwordLabel),
      SizedBox(height: 5),
      appLib.createTextField(confirmPasswordController, _confirmPasswordLabel),
      SizedBox(height: 20),
      appLib.createButton(_signUpText, GifteePage(), context),
      SizedBox(height: 10),
      appLib.createDividerWithText('or'),
      appLib.createRichText(_haveAccountText),
      SizedBox(height: 5),
      appLib.createButton(_signInText, SignInPage(), context, buttonColor: ButtonConstants.secondaryButtonColor,textColor: ButtonConstants.primaryButtonColor),
      ])
    );
  }
}

class GifteePage extends StatefulWidget {
  const GifteePage({Key? key}) : super(key: key);

  @override
  GifteePageState createState() => GifteePageState();
}

class GifteePageState extends State<GifteePage> {
  final String _genderText = 'Gender of giftee';
  final String _nextText = 'Next';

  String selectedGender = '';
  double selectedAge = 0;

  @override
  Widget build(BuildContext context) {
    return appLib.createPage( context,
      appLib.createColumn([
        appLib.createRichText(_genderText,fontSize: AppConstants.subTitleFontSize),
        SizedBox(height: 50),
        appLib.createMultiButton('Male', selectedGender, (newGender) {setState(() {selectedGender = newGender;});}),
        SizedBox(height: 10),
        appLib.createMultiButton('Female', selectedGender, (newGender) {setState(() {selectedGender = newGender;});}),
        SizedBox(height: 10),
        appLib.createMultiButton('Prefare not to answer', selectedGender, (newGender) {setState(() {selectedGender = newGender;});}),
        SizedBox(height: 30),
        appLib.createRichText('${selectedAge.toInt()} years old',textColor:AppColors.secondaryTextColor),
        SizedBox(height: 30),
        appLib.createAgeSlider(selectedAge, (value) {setState(() {selectedAge = value;});}),
        SizedBox(height: 30),
        appLib.createButton(_nextText, RelationAndOcassionPage(), context)
      ])
      );

  }
  }

class RelationAndOcassionPage extends StatefulWidget {
  const RelationAndOcassionPage({Key? key}) : super(key: key);

  @override
  RelationAndOcassionPageState createState() => RelationAndOcassionPageState();
}

class RelationAndOcassionPageState extends State<RelationAndOcassionPage> {
  final String _relationshipText = 'What is the relationship?';
  final String _ocassionText = 'What is the ocassion?';
  final String _continueText = 'Continue';

  String selectedRelation = '';
  String selectedOcassion = '';

  @override
  Widget build(BuildContext context) {
    return appLib.createPage( context,
      appLib.createColumn([
      appLib.createSelectOption(_relationshipText, ['Parents', 'Soulmate', 'Son/Daughter', 'Family', 'Friend', 'Other'], selectedRelation, (newOption) {
      setState(() {selectedRelation = newOption;}); }),
      SizedBox(height: 20),
      appLib.createSelectOption(_ocassionText, ['Holidays', 'BirthDay', 'Love YOU Gift', 'Thank YOU Gift', 'Graduations', 'Other'], selectedOcassion, (newOption) {
      setState(() {selectedOcassion = newOption;});}),
      SizedBox(height: 30),
      appLib.createButton(_continueText, QuestionPage(), context)

     ]));
  }
}

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  QuestionPageState createState() => QuestionPageState();
}

class QuestionPageState extends State<QuestionPage> {
  final List<String> images = [
    "image_url_1",
    "image_url_2",
  ];

  int currentIndex = 0;

  void handleSwipe(bool like) {
    setState(() {
      if (like) {
        // Handle like action
        print("Liked!");
      } else {
        // Handle dislike action
        print("Disliked!");
      }

      if (currentIndex < images.length - 1) {
        currentIndex++;
      } else {
        // Show a message or navigate to a different page
        print("No more images");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return appLib.createPage( context,
      appLib.createColumn([
        SizedBox(height: 30),

        //for loop that displays the photo then gets the replay and so on.
        appLib.createSwipingImageCard('images/superman.png', handleSwipe),
        
      ]),
    );
  }
}

class PriceRangePage extends StatefulWidget {
  @override
  PriceRangePageState createState() => PriceRangePageState();
}

class PriceRangePageState extends State<PriceRangePage> {
  String? _selectedPriceRange;

  final List<String> priceRanges = [
    '\$0 - \$10',
    '\$11 - \$25',
    '\$26 - \$50',
    '\$51 - \$100',
    '\$101+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Price Range'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected Price Range: ${_selectedPriceRange ?? "None"}', // Use null check
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Column(
              children: priceRanges.map((range) {
                return RadioListTile(
                  title: Text(range),
                  value: range,
                  groupValue: _selectedPriceRange,
                  onChanged: (value) {
                    setState(() {
                      _selectedPriceRange = value;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedPriceRange != null) {
                  // Perform action using the selected price range
                }
              },
              child: Text('Apply'),
            ),
          ],
        ),  
      ),
    );
  }
}