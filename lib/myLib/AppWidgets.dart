// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:swipe_widget/swipe_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'LazyIndexedStack.dart';
import 'package:universal_html/html.dart' as html;
//import 'package:appinio_swiper/appinio_swiper.dart';

import 'AppRequestsLib.dart';
import 'TokenManager.dart';
import 'AuthProvider.dart';
import 'RegisterProvider.dart';
import 'AppWidgetsLib.dart';
import 'AppConstants.dart';

AppLib appLib = AppLib();
AppRequests appReq = AppRequests();
RegisterationProvider regProvider = RegisterationProvider();
KeepLogin kpLog = KeepLogin();

String appUrl = AppConstants.appUrl;

String token = TokenManager().token;
double entry_id = EntryManager().entryid;

ValueNotifier<bool> likedNotifier = ValueNotifier<bool>(false);

Map<String, dynamic> entryDic = {'entry_id': entry_id, 'answers': answersList};

List answersList = [];
List questionsList = [];

Map<String, String> giftsDic = {};
Map<String, String> MyGiftsDic = {};

class StartingPage extends StatefulWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  StartingPageState createState() => StartingPageState();
}

class StartingPageState extends State<StartingPage> {
  final String _buttonText = 'Get Started';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleStart() async {
    if (await kpLog.isUserAuthenticated()) {
      print('Usual user');
      appReq.createEntry(token, entryDic, entry_id);
    } else {
      print('New user');
      await _guestSignInAndNavigate(context);
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GifteePage()),
    );
  }

  Future<void> _guestSignInAndNavigate(BuildContext context) async {
    await AuthProvider().handleGuestSignIn(
      context,
      emailController,
      passwordController,
    );
  }

  Widget createStartButton(
    String text,
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
              handleStart();
            },
            child: appLib.createRichText(text, textColor: textColor)));
  }

  @override
  Widget build(BuildContext context) {
    return appLib.createPage(
        context,
        appLib.createColumn([
          SizedBox(
              width: 250,
              child: appLib.insertPhoto(
                  path:
                      "/Users/zaidaladarbi/Developer/wonder_wrap/images/starting.png")),
          SizedBox(height: 70),
          createStartButton(_buttonText, context),
          //appLib.createButton(_buttonText, SignInPage(), context),
        ]));
  }
}
/*
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final String _signInText = 'Hello there!';
  final String _notUserText = 'New Here? Explore Gifts the Smart Way';
  final String _signUpText = 'Sign Up';
  final String _guestText = 'Continue as a Guest';
  final String _logInText = 'Go!'; //'Log in';
  final String _emailLabel = 'Email';
  final String _passwordLabel = 'Password';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showErrorMessage = false;

  Future<void> _signInAndNavigate(BuildContext context) async {
    await AuthProvider().handleSignIn(
      context,
      emailController,
      passwordController,
    );
  }

  Widget createSignInVerificationButton(
    String text,
    var navigationdPage,
    BuildContext context, {
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
              await _signInAndNavigate(context);
            },
            child: appLib.createRichText(text, textColor: textColor)));
  }

  Future<void> _guestSignInAndNavigate(BuildContext context) async {
    await AuthProvider().handleGuestSignIn(
      context,
      emailController,
      passwordController,
    );
  }

  Widget createGuestVerificationButton(
    String text,
    var navigationdPage,
    BuildContext context, {
    double height = ButtonConstants.buttonHeight,
    double width = ButtonConstants.buttonWidth,
    Color buttonColor = ButtonConstants.secondaryButtonColor,
    Color textColor = AppColors.secondaryTextColor,
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
                  color:
                      ButtonConstants.primaryButtonColor, //Colors.pink[200]!,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              await _guestSignInAndNavigate(context);
            },
            child: appLib.createRichText(text, textColor: textColor)));
  }

  @override
  Widget build(BuildContext context) {
    return appLib.createPage(
        context,
        appLib.createColumn([
          SizedBox(
            width: 175,
            child: appLib.insertPhoto(),
          ),
          SizedBox(height: 25),
          appLib.createRichText(_signInText,
              fontSize: 22,
              bold: true,
              textColor: TextFieldConstants.textOfTextFieldColor),
          SizedBox(height: 7.5),
          appLib.createRichText("Unlock a World of Gift Inspiration with AI!",
              fontSize: 14, textColor: Colors.blueGrey),
          //if (showErrorMessage) appLib.createRichText('Incorrect username or password.', textColor: Colors.red,),
          SizedBox(height: 15),
          appLib.createTextField(emailController, _emailLabel),
          SizedBox(height: 7.5),
          appLib.createTextField(passwordController, _passwordLabel),
          SizedBox(height: 15),
          createSignInVerificationButton(_logInText, GifteePage(), context),
          SizedBox(height: 10),
          appLib.createRichText(_notUserText, textColor: Colors.blueGrey),
          SizedBox(height: 5),
          appLib.createGuestureText(_signUpText, SignUpPage(), context),
          SizedBox(height: 7.5),
          appLib.createDividerWithText('or'),
          SizedBox(height: 15),
          createGuestVerificationButton(_guestText, GifteePage(), context)
        ]));
  }
}

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final String _createText = 'Create Account';
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

  Future<void> _signUpAndNavigate(BuildContext context) async {
    await regProvider.handleSignUp(
      context,
      firstNameController,
      lastNameController,
      emailController,
      passwordController,
      confirmPasswordController,
    );
  }

  Widget createSignUpVerificationButton(
    String text,
    var navigationdPage,
    BuildContext context, {
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
              await _signUpAndNavigate(context);
            },
            child: appLib.createRichText(text, textColor: textColor)));
  }

  @override
  Widget build(BuildContext context) {
    return appLib.createPage(
        context,
        appLib.createColumn([
          appLib.createRichText(_createText,
              fontSize: AppConstants.subTitleFontSize),
          SizedBox(height: 25),
          appLib.createNameRow(firstNameController, lastNameController),
          SizedBox(height: 10),
          appLib.createTextField(emailController, _emailLabel),
          SizedBox(height: 10),
          appLib.createTextField(passwordController, _passwordLabel),
          SizedBox(height: 10),
          appLib.createTextField(
              confirmPasswordController, _confirmPasswordLabel),
          SizedBox(height: 20),
          createSignUpVerificationButton(_signUpText, SignInPage(), context),
          SizedBox(height: 10),
          appLib.createDividerWithText('or'),
          appLib.createRichText(_haveAccountText),
          SizedBox(height: 5),
          appLib.createButton(_signInText, SignInPage(), context,
              buttonColor: ButtonConstants.secondaryButtonColor,
              textColor: ButtonConstants.primaryButtonColor),
        ]));
  }
}
*/

class GifteePage extends StatefulWidget {
  const GifteePage({Key? key}) : super(key: key);

  @override
  GifteePageState createState() => GifteePageState();
}

class GifteePageState extends State<GifteePage> {
  final String _genderText = 'Giftee gender';
  final String _nextText = 'Next';

  String selectedGender = '';
  double selectedAge = 0;

  ValueNotifier<bool> pressedNotifier = ValueNotifier<bool>(false);

  void _handleButton() async {
    double entry_id = EntryManager().entryid;
    String token = TokenManager().token;

    if (selectedAge != 0 && selectedGender != '') {
      await appReq.postRequest('/set_age/', token,
          {'entry_id': entry_id, 'age': selectedAge.toInt()});
      await appReq.postRequest('/set_gender/', token,
          {'entry_id': entry_id, 'gender': selectedGender});

      print('giftee button handled');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RelationAndOcassionPage()),
      );
      print('navigated to relation and occassions page');
    } else {
      pressedNotifier.value = true;

      print('Select values');
    }
  }

  @override
  Widget build(BuildContext context) {
    return appLib.createPage(
        context,
        appLib.createColumn([
          appLib.createRichText(_genderText,
              fontSize: AppConstants.subTitleFontSize),
          SizedBox(height: 50),
          appLib.createMultiButton('Male', selectedGender, (newGender) {
            setState(() {
              selectedGender = newGender;
            });
          }),
          SizedBox(height: 10),
          appLib.createMultiButton('Female', selectedGender, (newGender) {
            setState(() {
              selectedGender = newGender;
            });
          }),
          SizedBox(height: 10),
          appLib.createMultiButton('Prefer not to answer', selectedGender,
              (newGender) {
            setState(() {
              selectedGender = newGender;
            });
          }),
          SizedBox(height: 30),
          appLib.createRichText('Select age'),
          SizedBox(height: 2),
          appLib.createRichText('${selectedAge.toInt()}',
              textColor: AppColors.secondaryTextColor,
              fontSize: AppConstants.textFontSize),
          SizedBox(height: 30),
          appLib.createAgeSlider(selectedAge, (value) {
            setState(() {
              selectedAge = value;
            });
          }),
          SizedBox(height: 30),
          ValueListenableBuilder<bool>(
            valueListenable: pressedNotifier,
            builder: (context, isPressed, child) {
              return isPressed && (selectedAge == 0 || selectedGender == '')
                  ? SizedBox(
                      width: ButtonConstants.buttonWidth,
                      child: Row(
                        children: [
                          appLib.createRichText(
                            'Select Age and Gender values',
                            textColor: Colors.red,
                            fontSize: 10,
                          ),
                        ],
                      ),
                    )
                  : SizedBox
                      .shrink(); // Hide the widget if conditions are not met
            },
          ),
          appLib.createFunctionButton(_nextText, context, _handleButton),
        ]));
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

  ValueNotifier<bool> pressedNotifier = ValueNotifier<bool>(false);

  void handleButton() {
    String token = TokenManager().token;
    double entry_id = EntryManager().entryid;

    if (selectedRelation != '' && selectedOcassion != '') {
      appReq.postRequest('/set_relationship_occasion/', token, {
        'entry_id': entry_id,
        'relationship': selectedRelation,
        'occasion': selectedOcassion
      });
      print('relation and occasion button handled');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmotionFeelingPage()),
      );
      print('navidated to feeling page');
    } else {
      pressedNotifier.value = true;

      print('Select values');
    }
  }

  @override
  Widget build(BuildContext context) {
    return appLib.createPage(
        context,
        appLib.createColumn([
          SizedBox(
            height: 30,
          ),
          appLib.createSelectOption(
              _relationshipText,
              [
                'Parent',
                'Soulmate',
                'Son/Daughter',
                'Family',
                'Friend',
                'Other'
              ],
              selectedRelation, (newOption) {
            setState(() {
              selectedRelation = newOption;
            });
          }),
          SizedBox(height: 40),
          appLib.createSelectOption(
              _ocassionText,
              [
                'Holiday',
                'Birthday',
                'Love YOU Gift',
                'Thank YOU Gift',
                'Graduation',
                'Other'
              ],
              selectedOcassion, (newOption) {
            setState(() {
              selectedOcassion = newOption;
            });
          }),
          SizedBox(height: 30),
          ValueListenableBuilder<bool>(
            valueListenable: pressedNotifier,
            builder: (context, isPressed, child) {
              return isPressed &&
                      (selectedRelation == '' || selectedOcassion == '')
                  ? SizedBox(
                      width: ButtonConstants.buttonWidth,
                      child: Row(
                        children: [
                          appLib.createRichText(
                            'Select Relation and Occasion Values',
                            textColor: Colors.red,
                            fontSize: 10,
                          ),
                        ],
                      ),
                    )
                  : SizedBox
                      .shrink(); // Hide the widget if conditions are not met
            },
          ),
          appLib.createFunctionButton(_continueText, context, handleButton),
        ]));
  }
}

class EmotionFeelingPage extends StatefulWidget {
  const EmotionFeelingPage({Key? key}) : super(key: key);

  @override
  EmotionFeelingPageState createState() => EmotionFeelingPageState();
}

class EmotionFeelingPageState extends State<EmotionFeelingPage> {
  final String _feelingText = 'How do you want the gift to feel?';
  final String _continueText = 'Continue';

  String selectedFeeling = '';

  ValueNotifier<bool> pressedNotifier = ValueNotifier<bool>(false);

  void handleButton() {
    String token = TokenManager().token;
    double entry_id = EntryManager().entryid;

    if (selectedFeeling != '') {
      /*appReq.postRequest('/set_feeling/', token, {
        'entry_id': entry_id,
        'feeling': selectedFeeling,
      })
      print('Feeling button handled');
      */
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PriceRangePage()),
      );
      print('navidated to price range page');
    } else {
      pressedNotifier.value = true;

      print('Select values');
    }
  }

  @override
  Widget build(BuildContext context) {
    return appLib.createPage(
        context,
        appLib.createColumn([
          SizedBox(
            height: 20,
          ),
          appLib.createSelectOption(
              _feelingText,
              [
                'Emotional',
                'Funny',
                'Cute',
                'Surprising',
                'Uplifting',
                'Anything'
              ],
              selectedFeeling, (newOption) {
            setState(() {
              selectedFeeling = newOption;
            });
          }),
          SizedBox(height: 100),
          ValueListenableBuilder<bool>(
            valueListenable: pressedNotifier,
            builder: (context, isPressed, child) {
              return isPressed && (selectedFeeling == '')
                  ? SizedBox(
                      width: ButtonConstants.buttonWidth,
                      child: Row(
                        children: [
                          appLib.createRichText(
                            'Select Feeling Values',
                            textColor: Colors.red,
                            fontSize: 10,
                          ),
                        ],
                      ),
                    )
                  : SizedBox
                      .shrink(); // Hide the widget if conditions are not met
            },
          ),
          appLib.createFunctionButton(_continueText, context, handleButton),
        ]));
  }
}

class PriceRangePage extends StatefulWidget {
  @override
  PriceRangePageState createState() => PriceRangePageState();
}

class PriceRangePageState extends State<PriceRangePage> {
  List<String> priceRanges = [
    "\$10 - \$25",
    "\$25 - \$50",
    "\$50 - \$100",
    "\$100 - \$250",
    "\$250 - \$500",
    "\$500 - \$1000",
  ];

  double min_price = 0;
  double max_price = 0;

  String selectedPriceRange = "\$0 - \$0";

  ValueNotifier<bool> pressedNotifier = ValueNotifier<bool>(false);

  void onTap(index) {
    setState(() {
      selectedPriceRange = priceRanges[index];
    });
  }

  void createMultiRange() {
    for (var i = 0; i < priceRanges.length; i++) {
      appLib.createMultiButton(priceRanges[i], selectedPriceRange,
          (priceRange) {
        setState(() {
          selectedPriceRange = priceRange;
        });
      });
    }
  }

  List min_max_price(
      String selectedPriceRange, double min_price, double max_price) {
    List priceList =
        selectedPriceRange.replaceAll(RegExp(r'\$'), '').split(' - ');
    if (priceList[0] != 0 && priceList[1] != 0) {
      min_price = double.parse(priceList[0]);
      max_price = double.parse(priceList[1]);
      return [min_price, max_price];
    } else {
      return [0, 0];
    }
  }

  void handleButton() {
    String token = TokenManager().token;
    double entry_id = EntryManager().entryid;

    List price = min_max_price(selectedPriceRange, min_price, max_price);
    if (price[0] != 0 && price[1] != 0) {
      appReq.postRequest('/set_min_max_price/', token,
          {'entry_id': entry_id, 'min_price': price[0], 'max_price': price[1]});
      print('price button handled');
      Navigator.push(
        context,
        //MaterialPageRoute(builder: (context) => QuestionPage()),
        MaterialPageRoute(
            builder: (context) => QuestionPage()), //EditedQuestionPage()),
      );
      print('navigated to questions page');
    } else {
      pressedNotifier.value = true;

      print('Select values');
    }
  }

  @override
  Widget build(BuildContext context) {
    return appLib.createPage(
      context,
      appLib.createColumn([
        appLib.createRichText(
          'Select a Price Range:',
          fontSize: AppConstants.subTitleFontSize,
        ),
        SizedBox(height: 20),
        appLib.createMultiButton(priceRanges[0], selectedPriceRange,
            borderColor: Colors.pink[200]!, (priceRange) {
          setState(() {
            selectedPriceRange = priceRange;
          });
        }),
        SizedBox(
          height: 15,
        ),
        appLib.createMultiButton(priceRanges[1], selectedPriceRange,
            borderColor: Colors.pink[200]!, (priceRange) {
          setState(() {
            selectedPriceRange = priceRange;
          });
        }),
        SizedBox(
          height: 15,
        ),
        appLib.createMultiButton(priceRanges[2], selectedPriceRange,
            borderColor: Colors.pink[200]!, (priceRange) {
          setState(() {
            selectedPriceRange = priceRange;
          });
        }),
        SizedBox(
          height: 15,
        ),
        appLib.createMultiButton(priceRanges[3], selectedPriceRange,
            borderColor: Colors.pink[200]!, (priceRange) {
          setState(() {
            selectedPriceRange = priceRange;
          });
        }),
        SizedBox(
          height: 10,
        ),
        appLib.createMultiButton(priceRanges[4], selectedPriceRange,
            borderColor: Colors.pink[200]!, (priceRange) {
          setState(() {
            selectedPriceRange = priceRange;
          });
        }),
        SizedBox(
          height: 10,
        ),
        appLib.createMultiButton(priceRanges[5], selectedPriceRange,
            borderColor: Colors.pink[200]!, (priceRange) {
          setState(() {
            selectedPriceRange = priceRange;
          });
        }),
        SizedBox(height: 30),
        ValueListenableBuilder<bool>(
          valueListenable: pressedNotifier,
          builder: (context, isPressed, child) {
            return isPressed && (selectedPriceRange == "\$0 - \$0")
                ? SizedBox(
                    width: ButtonConstants.buttonWidth,
                    child: Row(
                      children: [
                        appLib.createRichText(
                          'Select Price Values',
                          textColor: Colors.red,
                          fontSize: 10,
                        ),
                      ],
                    ),
                  )
                : SizedBox
                    .shrink(); // Hide the widget if conditions are not met
          },
        ),
        appLib.createFunctionButton('Apply', context, handleButton)
      ]),
    );
  }
}

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  QuestionPageState createState() => QuestionPageState();
}

class QuestionPageState extends State<QuestionPage> {
  int stackIndex = 0;
  int n_questions = 15;
  bool liked = false;

  String token = TokenManager().token;
  double entry_id = EntryManager().entryid;
  Map<String, String> getQuestionsDic = {};
  late final Future myFuture;

  @override
  void initState() {
    super.initState();
    myFuture = fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    print('question request started');
    var fetchedQuestionsList =
        await appReq.getQuestions(token, entry_id, n_questions);
    setState(() {
      questionsList = fetchedQuestionsList;
    });

    print('${questionsList.length}:question list');
    print('${fetchedQuestionsList.length}:question list');

    print('questions saved');
  }

  Widget insertLikedState(bool liked) {
    return Center(
      child: SizedBox(
        height: 300,
        child: Image.asset(
          liked ? "images/Liked.png" : "images/unLiked.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  dynamic handleSwipe(bool like) {
    setState(() {
      String questionId = questionsList[stackIndex]['id'].toString();
      String answer = like ? 'yes' : 'no';
      liked = like;
      answersList.add({'question_id': questionId, 'value': answer});

      if (like) {
        //print("Liked!");
        getQuestionsDic[questionsList[stackIndex]['id'].toString()] = 'yes';
      } else {
        //print("Disliked!");
        getQuestionsDic[questionsList[stackIndex]['id'].toString()] = 'no';
      }

      if (stackIndex < n_questions - 1) {
        stackIndex++;
      } else {
        setState(() {
          answersList = answersList;
        });
        print('answers saved');

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GiftsPage()),
        );
        print('navigated to gifts page');
      }
    });
    //print('swipeHandeled');
  }

  Widget createSwipingImageCard(
      String imageUrl, int i, Function(bool) handleSwipe) {
    return Container(
        color: AppColors.backgroundColor,
        width: SwipingCardsConstants.photoWidth,
        height: SwipingCardsConstants.photoHeight,
        child: ValueListenableBuilder<bool>(
            valueListenable: likedNotifier,
            builder: (context, isLiked, child) {
              return SwipeWidget(
                //onSwipe: () {print('Swiped!');},
                onSwipeRight: () {
                  print('swiped right');
                  setState(() {
                    liked = true;
                  });
                  handleSwipe(liked);
                },
                onSwipeLeft: () {
                  print('swiped left');
                  setState(() {
                    liked = false;
                  });
                  handleSwipe(liked);
                },
                //onSwipe:(){},
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.transparent,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                        ),
                      ),
                    ),
                    placeholder: (context, url) {
                      if (i == 0) {
                        return Center(
                          child: appLib.createColumn(
                            [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: appLib.insertPhoto(
                                          path:
                                              "/Users/zaidaladarbi/Developer/wonder_wrap/images/swipeRight.png"),
                                    ),
                                  ]),
                              SizedBox(
                                height: 70,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: appLib.insertPhoto(
                                          path:
                                              "/Users/zaidaladarbi/Developer/wonder_wrap/images/swipeLeft.png"),
                                    ),
                                  ]),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: ButtonConstants.primaryButtonColor,
                          ),
                        );
                      }
                    },
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return appLib.createPage(
        context,
        Center(
            child: FutureBuilder<void>(
                future: myFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: 200,
                      child: Center(
                        child: appLib.insertPhoto(
                            path:
                                "/Users/zaidaladarbi/Developer/wonder_wrap/images/logo.png"),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 230,
                            height: 20,
                            child: Column(children: [
                              LinearProgressIndicator(
                                  value: (stackIndex + 1) / n_questions,
                                  backgroundColor: Colors.deepOrange[50],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      SliderConstants.sliderActiveColor)),
                            ]),
                          ),
                          LazyIndexedStack(
                            index: stackIndex,
                            children: [
                              for (int i = 0; i < questionsList.length; i++)
                                IgnorePointer(
                                  ignoring: i != stackIndex,
                                  child: Opacity(
                                    opacity: i == stackIndex ? 1.0 : 0.0,
                                    child: SizedBox(
                                      width: 300,
                                      height: 600,
                                      child: createSwipingImageCard(
                                        questionsList[i]['image'],
                                        i,
                                        handleSwipe,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          )
                        ]);
                  }
                })));
  }
}

class GiftsPage extends StatefulWidget {
  @override
  GiftsPageState createState() => GiftsPageState();
}

class GiftsPageState extends State<GiftsPage> {
  String token = TokenManager().token;
  double entry_id = EntryManager().entryid;
  final _pageController = PageController(
    initialPage: 0,
  );
  List recommendationsList = [];
  List<String> giftNames = [];
  List<String> giftUrls = [];
  List<String> giftImages = [];
  late final Future myFuture;

  @override
  void initState() {
    super.initState();
    myFuture = fetchRecommendations();
  }

  Future<void> fetchRecommendations() async {
    Map<String, dynamic> entryDic = {
      'entry_id': entry_id,
      'answers': answersList
    };
    var fetchedRecommendationsList = await appReq.getRecommendations(entryDic);
    setState(() {
      List recommendationsListOrginal = fetchedRecommendationsList;
      recommendationsList = recommendationsListOrginal.getRange(0, 4).toList();
    });

    print(recommendationsList.length);

    var dic = tideNamesUrls(recommendationsList);
    setState(() {
      giftNames = dic['giftNames'];
      giftUrls = dic['giftUrls'];
      giftImages = dic['giftImage'];
    });
  }

  dynamic tideNamesUrls(var recommendationsList) {
    for (int i = 0; i < recommendationsList.length; i++) {
      giftNames.add(recommendationsList[i]['name']);
      giftUrls.add(recommendationsList[i]['url']);
      giftImages.add(recommendationsList[i]['img_url']);
    }
    return {
      'giftNames': giftNames,
      'giftUrls': giftUrls,
      'giftImage': giftImages
    };
  }

  Future<void> shareLink(Map data) async {
    try {
      await html.window.navigator.share(data);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return appLib.createPage(
        context,
        Center(
          child: FutureBuilder<void>(
              future: myFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    width: 275,
                    child: Center(
                      child: appLib.insertPhoto(
                          path:
                              "/Users/zaidaladarbi/Developer/wonder_wrap/images/AiisChoosing.png"),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return SizedBox(
                      width: AppConstants.pageWidth,
                      height: AppConstants.pageHeight,
                      child: Column(children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StartingPage()),
                            );
                          },
                          child: Column(children: [
                            SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              width: 120,
                              child: appLib.insertPhoto(
                                  path:
                                      "/Users/zaidaladarbi/Developer/wonder_wrap/images/LogoTheAIHasChosenYourGift.png"),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: 275,
                              child: appLib.insertPhoto(
                                  path:
                                      "/Users/zaidaladarbi/Developer/wonder_wrap/images/TextTheAIHasChosenYourGift.png"),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ]),
                        ),
                        SizedBox(
                            width: 300,
                            height: 300,
                            child: PageView.builder(
                                controller: _pageController,
                                itemCount: giftNames.length,
                                itemBuilder: (context, index) {
                                  //final giftName = giftNames[index];
                                  final giftUrl = giftUrls[index];
                                  final giftImage = giftImages[index];

                                  return GestureDetector(
                                      onTap: () async {
                                        if (await canLaunchUrl(
                                            Uri.parse(giftUrl))) {
                                          await launchUrl(Uri.parse(giftUrl));
                                        } else {
                                          print('Could not launch gift $index');
                                        }
                                      },
                                      child: Card(
                                        elevation: 5,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: giftImage,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                              color: ButtonConstants
                                                  .primaryButtonColor,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ));
                                })),
                        SizedBox(
                          height: 10,
                        ),
                        SmoothPageIndicator(
                            controller: _pageController,
                            count: giftImages.length,
                            effect: WormEffect(
                                activeDotColor:
                                    ButtonConstants.primaryButtonColor),
                            onDotClicked: (index) {}),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(child: SizedBox()),
                        appLib.createButton(
                            'Refer a friend', ReferralPage(), context),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              appLib.createButton(
                                  'My Gifts', MyGiftsPage(), context,
                                  width: ButtonConstants.buttonWidth * 0.75),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  int pageNum = _pageController.page!.round();
                                  String giftUrl = giftUrls[pageNum];
                                  String giftName = giftNames[pageNum];

                                  var data = {
                                    'title': giftName,
                                    'Text': 'Your gift link',
                                    'url': giftUrl,
                                  };
                                  shareLink(data);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: ButtonConstants.primaryButtonColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.share,
                                      color:
                                          ButtonConstants.secondaryButtonColor,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: 20,
                        ),
                      ]));
                }
              }),
        ));
  }
}

class MyGiftsPage extends StatefulWidget {
  @override
  MyGiftsPageState createState() => MyGiftsPageState();
}

class MyGiftsPageState extends State<MyGiftsPage> {
  String token = TokenManager().token;
  double entry_id = EntryManager().entryid;
  List MyGiftsList = [];
  List<String> giftNames = [];
  List<String> giftsCreated = [];
  List<String> giftUrls = [];
  List<String> giftImages = [];
  List<int> giftsListLength = [];
  List<PageController> _pageControllers = [];

  late final Future myFuture;

  @override
  void initState() {
    super.initState();
    myFuture = fetchMyGifts();
  }

  @override
  void dispose() {
    for (var controller in _pageControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> fetchMyGifts() async {
    print('MyGifts started');
    List fetchedMyGiftsList = await appReq.getMyGifts();
    setState(() {
      MyGiftsList = fetchedMyGiftsList;
    });

    var dic = tideNamesUrls(MyGiftsList);
    setState(() {
      giftNames = dic['giftNames'];
      giftUrls = dic['giftUrls'];
      giftsCreated = dic['giftsCreated'];
      giftImages = dic['giftImages'];
    });
  }

  dynamic tideNamesUrls(var MyGiftsList) {
    print('tiding started');
    List<String> _giftsCreated = [];
    List<String> _giftNames = [];
    List<String> _giftUrls = [];
    List<String> _giftImages = [];
    for (int i = 0; i < MyGiftsList.length; i++) {
      _giftsCreated.add(MyGiftsList[i]['created'].substring(0, 10));
      giftsListLength.add(MyGiftsList[i]['gifts'].length);
      for (int j = 0; j < MyGiftsList[i]['gifts'].length; j++) {
        _giftNames.add(MyGiftsList[i]['gifts'][j]['name']);
        _giftUrls.add(MyGiftsList[i]['gifts'][j]['url']);
        _giftImages.add(MyGiftsList[i]['gifts'][j]['img_url']);
      }
    }

    List giftNamesReversed = _giftNames.reversed.toList();
    List giftUrlsReversed = _giftUrls.reversed.toList();
    List giftsCreatedReversed = _giftsCreated.reversed.toList();
    List giftImagesReversed = _giftImages.reversed.toList();

    print('done tiding');
    return {
      'giftNames': giftNamesReversed,
      'giftUrls': giftUrlsReversed,
      'giftsCreated': giftsCreatedReversed,
      'giftImages': giftImagesReversed,
    };
  }

  @override
  Widget build(BuildContext context) {
    return appLib.createPage(
        context,
        FutureBuilder<void>(
            future: myFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  width: 150,
                  child: Center(
                    child: appLib.insertPhoto(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                _pageControllers = List.generate(
                  giftsListLength.length,
                  (index) => PageController(initialPage: 0),
                );
                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 175,
                      child: appLib.insertPhoto(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: giftsListLength.length,
                        itemBuilder: (context, index) {
                          final giftCreated = giftsCreated[index];
                          int giftListLength = giftsListLength[index];
                          return SizedBox(
                            height: 325,
                            child: Column(children: [
                              if (index == 0 ||
                                  giftCreated != giftsCreated[index - 1])
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 2.2,
                                      ),
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: 200,
                                    child: Row(children: [
                                      appLib.createRichText(giftCreated),
                                    ]),
                                  ),
                                ),
                              SizedBox(
                                height: 275,
                                child: Column(children: [
                                  SizedBox(
                                      width: 250,
                                      height: 250,
                                      child: PageView.builder(
                                          controller: _pageControllers[index],
                                          itemCount: giftListLength,
                                          itemBuilder: (context, indexPage) {
                                            final giftUrl =
                                                giftUrls[index * 4 + indexPage];
                                            final giftImage = giftImages[
                                                index * 4 + indexPage];

                                            return GestureDetector(
                                                onTap: () async {
                                                  if (await canLaunchUrl(
                                                      Uri.parse(giftUrl))) {
                                                    await launchUrl(
                                                        Uri.parse(giftUrl));
                                                  } else {
                                                    int en =
                                                        index * 4 + indexPage;
                                                    print(
                                                        'Could not launch gift $en');
                                                  }
                                                },
                                                child: Card(
                                                  elevation: 5,
                                                  shadowColor:
                                                      Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: giftImage,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: ButtonConstants
                                                            .primaryButtonColor,
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                ));
                                          })),
                                  SmoothPageIndicator(
                                      controller: _pageControllers[index],
                                      count: giftListLength,
                                      effect: WormEffect(
                                          activeDotColor: ButtonConstants
                                              .primaryButtonColor),
                                      onDotClicked: (indexPage) {}),
                                ]),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ]),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }));
  }
}

class ReferralPage extends StatefulWidget {
  @override
  ReferralPageState createState() => ReferralPageState();
}

class ReferralPageState extends State<ReferralPage> {
  String token = TokenManager().token;
  double entry_id = EntryManager().entryid;
  final String referralCode = 'http/:www.giftapp.com/alkdjflak';

  Future<void> shareLink(Map data) async {
    try {
      await html.window.navigator.share(data);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return appLib.createPage(
        context,
        appLib.createColumn([
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 175,
            child: appLib.insertPhoto(),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'Refer your\nfriends',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
              fontFamily: 'Roboto',
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    height: ButtonConstants.buttonHeight,
                    width: ButtonConstants.buttonWidth,
                    decoration: BoxDecoration(
                      color: ButtonConstants.primaryButtonColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(children: [
                      Text(
                        referralCode,
                        //referralCode.length > 10 ? referralCode.substring(0, 10): referralCode, //referralCode.substring(referralCode.length),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                        child: GestureDetector(
                          onTap: () async {
                            var data = {
                              'title': 'Referral Code',
                              'Text': 'Your Referral Code',
                              'url': referralCode,
                            };
                            shareLink(data);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: ButtonConstants.primaryButtonColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.share,
                                color: ButtonConstants.secondaryButtonColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
          appLib.createButton('Back', GiftsPage(), context),
        ]));
  }
}

class TestPage extends StatefulWidget {
  @override
  TestPageState createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  String token = TokenManager().token;
  double entry_id = EntryManager().entryid;

  @override
  Widget build(BuildContext context) {
    return appLib.createPage(
      context,
      appLib.createColumn([
        Material(
          color: Colors.white,
          child: Center(
            child: Ink(
              decoration: const ShapeDecoration(
                color: ButtonConstants.primaryButtonColor,
                shape: CircleBorder(),
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.share),
                  color: ButtonConstants.secondaryButtonColor,
                  onPressed: () {
                    //int pageNum = _pageController.page!.round();
                    //Share.share(giftUrls[pageNum]);
                  },
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

//-----------------------------------------------------------------------------
/*class EditedQuestionPage extends StatefulWidget {
  const EditedQuestionPage({Key? key}) : super(key: key);

  @override
  EditedQuestionPageState createState() => EditedQuestionPageState();
}

class EditedQuestionPageState extends State<EditedQuestionPage> {
  int stackIndex = 0;
  int n_questions = 15;
  String liked = '';

  String token = TokenManager().token;
  double entry_id = EntryManager().entryid;
  Map<String, String> getQuestionsDic = {};
  late final Future myFuture;

  @override
  void initState() {
    super.initState();
    myFuture = fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    print('question request started');
    var fetchedQuestionsList =
        await appReq.getQuestions(token, entry_id, n_questions);
    setState(() {
      questionsList = fetchedQuestionsList;
    });

    print('questions saved');
  }

  Widget insertLikedState(bool liked) {
    return Center(
      child: SizedBox(
        height: 300,
        child: Image.asset(
          liked ? "images/Liked.png" : "images/unLiked.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void handleSwipeEnd(SwiperActivity activity) {
    setState(() {
      if (activity.direction == AxisDirection.right) {
        liked = 'true';
      } else if (activity.direction == AxisDirection.left) {
        liked = 'false';
      } else if (activity.direction == AxisDirection.up) {
        liked = 'null';
      }
    });
  }

  dynamic handleSwipe(bool like) {
    setState(() {
      String questionId = questionsList[stackIndex]['id'].toString();
      String answer = like ? 'yes' : 'no';
      //liked = like;
      answersList.add({'question_id': questionId, 'value': answer});

      if (like) {
        //print("Liked!");
        getQuestionsDic[questionsList[stackIndex]['id'].toString()] = 'yes';
      } else {
        //print("Disliked!");
        getQuestionsDic[questionsList[stackIndex]['id'].toString()] = 'no';
      }

      if (stackIndex < n_questions - 1) {
        stackIndex++;
        print('stackIndex: $stackIndex');
      } else {
        print('estackIndex: $stackIndex');

        setState(() {
          answersList = answersList;
        });
        print('answers saved');

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GiftsPage()),
        );
        print('navigated to gifts page');
      }
    });
    //print('swipeHandeled');
  }

  @override
  Widget build(BuildContext context) {
    return appLib.createPage(
        context,
        Center(
            child: FutureBuilder<void>(
                future: myFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: 200,
                      child: Center(
                        child: appLib.insertPhoto(
                            path:
                                "/Users/zaidaladarbi/Developer/wonder_wrap/images/logo.png"),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 230,
                            height: 20,
                            child: Column(children: [
                              LinearProgressIndicator(
                                  value: (stackIndex + 1) / n_questions,
                                  backgroundColor: Colors.deepOrange[50],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      SliderConstants.sliderActiveColor)),
                            ]),
                          ),
                          SizedBox(
                            height: 600,
                            width: 300,
                            child: AppinioSwiper(
                              cardCount: questionsList.length,
                              backgroundCardScale: 0.75,
                              swipeOptions: SwipeOptions.only(
                                  up: true,
                                  down: false,
                                  left: true,
                                  right: true),
                              //onSwipeEnd:handleSwipeEnd,
                              cardBuilder: (BuildContext context, int index) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Card(
                                    elevation: 5,
                                    shadowColor: ButtonConstants
                                        .primaryButtonColor, //Colors.transparent,
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Container(
                                        child: Center(
                                      child: CachedNetworkImage(
                                        imageUrl: questionsList[index]['image'],
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) {
                                          if (index == 0) {
                                            return Center(
                                              child: appLib.createColumn(
                                                [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        SizedBox(
                                                          width: 150,
                                                          child: appLib.insertPhoto(
                                                              path:
                                                                  '/Users/zaidaladarbi/Developer/wonder_wrap/images/swipeRight.png'),
                                                        ),
                                                      ]),
                                                  SizedBox(
                                                    height: 70,
                                                  ),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 150,
                                                          child: appLib.insertPhoto(
                                                              path:
                                                                  '/Users/zaidaladarbi/Developer/wonder_wrap/images/swipeLeft.png'),
                                                        ),
                                                      ]),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: ButtonConstants
                                                    .primaryButtonColor,
                                              ),
                                            );
                                          }
                                        },
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    )),
                                  ),
                                );
                              },
                            ),
                          ),
                          /*LazyIndexedStack(
                            index: stackIndex,
                            children: [
                              for (int i = 0; i < questionsList.length; i++)
                                IgnorePointer(
                                  ignoring: i != stackIndex,
                                  child: Opacity(
                                    opacity: i == stackIndex ? 1.0 : 0.0,
                                    child: SizedBox(
                                      width: 300,
                                      height: 600,
                                      child: createSwipingImageCard(
                                        questionsList[i]['image'],
                                        i,
                                        handleSwipe,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          )*/
                        ]);
                  }
                })));
  }
}*/
