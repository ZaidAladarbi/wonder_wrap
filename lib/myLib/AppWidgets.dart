// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import 'package:wonder_wrap/myLib/AppRequestsLib.dart';
import 'TokenManager.dart';
import 'AuthProvider.dart';
import 'RegisterProvider.dart';
import 'AppWidgetsLib.dart';
import 'AppConstants.dart';

AppLib appLib = AppLib();
AppRequests appReq = AppRequests();
RegisterationProvider regProvider = RegisterationProvider();

String appUrl = AppConstants.appUrl;

String token = TokenManager().token;
double entry_id = EntryManager().entryid;

Map<String, dynamic> entryDic = {'entry_id': entry_id, 'answers': answersList};

List answersList = [];
List questionsList = [];

Map<String, String> giftsDic = {};
Map<String, String> historyDic = {};

class StartingPage extends StatefulWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  StartingPageState createState() => StartingPageState();
}

class StartingPageState extends State<StartingPage> {
  final String _buttonText = 'Get Started';

  @override
  Widget build(BuildContext context) {
    return appLib.createPage(
        context,
        appLib.createColumn([
          SizedBox(
              width: 250,
              child: appLib.insertPhoto(path: '/Users/admin/Desktop/Development/wonder_wrap/images/Starting.png')),
          SizedBox(height: 70),
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
          //appLib.createButton(_guestText, GifteePage(), context, buttonColor: ButtonConstants.primaryButtonColor, textColor: AppColors.primaryTextColor),
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

  void _handleButton() async {
    double entry_id = EntryManager().entryid;
    String token = TokenManager().token;
    print(entry_id);
    print(token);
    await appReq.postRequest(
        '/set_age/', token, {'entry_id': entry_id, 'age': selectedAge});
    await appReq.postRequest('/set_gender/', token,
        {'entry_id': entry_id, 'gender': selectedGender});
    print('giftee button handled');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RelationAndOcassionPage()),
    );
    print('navigated to relation and occassions page');
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
          appLib.createMultiButton('Prefare not to answer', selectedGender,
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

  void handleButton() {
    String token = TokenManager().token;
    double entry_id = EntryManager().entryid;
    appReq.postRequest('/set_relationship_occasion/', token, {
      'entry_id': entry_id,
      'relationship': selectedRelation,
      'occasion': selectedOcassion
    });
    // Do something
    print('relation and occasion button handled');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PriceRangePage()),
    );
    print('navidated to price range page');
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
                'Parents',
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
                'Holidays',
                'BirthDay',
                'Love YOU Gift',
                'Thank YOU Gift',
                'Graduations',
                'Other'
              ],
              selectedOcassion, (newOption) {
            setState(() {
              selectedOcassion = newOption;
            });
          }),
          SizedBox(height: 30),
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

  String selectedPriceRange = "";

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
    min_price = double.parse(priceList[0]);
    max_price = double.parse(priceList[1]);
    return [min_price, max_price];
  }

  void handleButton() {
    String token = TokenManager().token;
    double entry_id = EntryManager().entryid;
    List price = min_max_price(selectedPriceRange, min_price, max_price);
    appReq.postRequest('/set_min_max_price/', token,
        {'entry_id': entry_id, 'min_price': price[0], 'max_price': price[1]});
    print('price button handled');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionPage()),
    );
    print('navigated to questions page');
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
  final double n_questions = 4;
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
    var fetchedQuestionsList =
        await appReq.getQuestions(token, entry_id, n_questions);
    setState(() {
      questionsList = fetchedQuestionsList;
    });
  }

  void handleSwipe(bool like) {
    setState(() {
      String questionId = questionsList[stackIndex]['id'].toString();
      String answer = like ? 'yes' : 'no';
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
  }

  @override
  Widget build(BuildContext context) {
    return appLib.createPage(
        context,
        appLib.createColumn([
          SizedBox(height: 20),
          Center(
            child: stackIndex < questionsList.length
                ? Stack(
                    children: [
                      for (int i = stackIndex; i < questionsList.length; i++)
                        IgnorePointer(
                          ignoring: i != stackIndex,
                          child: Opacity(
                            opacity: i == stackIndex ? 1.0 : 0.0,
                            child: SizedBox(
                              width: 300,
                              height: 600,
                              child: appLib.createSwipingImageCard(
                                questionsList[i]['image'],
                                handleSwipe,
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                : SizedBox(),
          )
        ]));
  }
}

class GiftsPage extends StatefulWidget {
  @override
  GiftsPageState createState() => GiftsPageState();
}

class GiftsPageState extends State<GiftsPage> {
  String token = TokenManager().token;
  double entry_id = EntryManager().entryid;
  List recommendationsList = [];
  List<String> giftNames = [];
  List<String> giftUrls = [];
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
      recommendationsList = fetchedRecommendationsList;
    });

    print(recommendationsList.length);

    var dic = tideNamesUrls(recommendationsList);
    setState(() {
      giftNames = dic['giftNames'];
      giftUrls = dic['giftUrls'];
    });
  }

  dynamic tideNamesUrls(var recommendationsList) {
    for (int i = 0; i < recommendationsList.length; i++) {
      giftNames.add(recommendationsList[i]['name']);
      giftUrls.add(recommendationsList[i]['url']);
    }
    return {'giftNames': giftNames, 'giftUrls': giftUrls};
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
                    child: Center(
                      child: appLib.insertPhoto(
                          path:
                              "/Users/admin/Desktop/Development/wonder_wrap/images/AiisChoosing.png"),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return SizedBox(
                      width: AppConstants.pageWidth,
                      height: AppConstants.pageHeight,
                      child: Column(children: [
                        SizedBox(
                          height: 30,
                        ),
                        appLib.insertPhoto(
                            path:
                                '/Users/admin/Desktop/Development/wonder_wrap/images/TheAIHasChosenYourGift.png'),
                        SizedBox(
                          height: 30,
                        ),
                        Expanded(
                            child: ListView.builder(
                          itemCount: giftNames.length,
                          itemBuilder: (context, index) {
                            final giftName = giftNames[index];
                            final giftUrl = giftUrls[index];

                            return Card(
                                child: ListTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: ButtonConstants.primaryButtonColor,
                                    width: 3),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              leading: CircleAvatar(
                                backgroundColor:
                                    ButtonConstants.primaryButtonColor,
                              ),
                              title: appLib.createRichText(giftName,
                                  bold: true, fontFamily: 'cabin'),
                              onTap: () async {
                                if (await canLaunchUrl(Uri.parse(giftUrl))) {
                                  await launchUrl(Uri.parse(giftUrl));
                                } else {
                                  print('Could not launch gift $index');
                                }
                              },
                            ));
                          },
                        )),
                        appLib.createButton(
                            'Go to Cart', HistoryPage(), context),
                        SizedBox(
                          height: 20,
                        ),
                      ]));
                }
              }),
        ));
  }
}

class HistoryPage extends StatefulWidget {
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  String token = TokenManager().token;
  double entry_id = EntryManager().entryid;
  List historyList = [];
  List<String> giftNames = [];
  List<String> giftCreated = [];
  List<String> giftUrls = [];
  late final Future myFuture;

  @override
  void initState() {
    super.initState();
    myFuture = fetchHistory();
  }

  Future<void> fetchHistory() async {
    print('history started');
    List fetchedHistoryList = await appReq.getHistory();
    setState(() {
      historyList = fetchedHistoryList;
    });

    var dic = tideNamesUrls(historyList);
    setState(() {
      giftNames = dic['giftNames'];
      giftUrls = dic['giftUrls'];
      //giftCreated = dic['giftCreated'];
    });

    print(giftNames.length);
    print(giftUrls.length);
    //print(giftCreated.length);
  }

  dynamic tideNamesUrls(var historyList) {
    print('tiding started');
    for (int i = 0; i < historyList.length; i++) {
      //giftCreated.add(historyList[i]['created']);
      for (int j = 0; j < historyList[i]['gifts'].length; j++) {
        giftNames.add(historyList[i]['gifts'][j]['name']);
        giftUrls.add(historyList[i]['gifts'][j]['url']);
      }
    }

    List giftNamesReversed = giftNames.reversed.toList();
    List giftUrlsReversed = giftUrls.reversed.toList();
    //List giftCreatedReversed = giftCreated.reversed.toList();

    print('done tiding');
    return {
      'giftNames': giftNamesReversed,
      'giftUrls': giftUrlsReversed,
      //'giftCreated': giftCreatedReversed
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
                        itemCount: giftNames.length,
                        itemBuilder: (context, index) {
                          final giftName = giftNames[index];
                          final giftUrl = giftUrls[index];

                          return Column(children: [
                            //if (index % 2 == 0) appLib.createRichText(giftCreated[(index ~/ 2)],bold: true),
                            Card(
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: ButtonConstants.primaryButtonColor,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor:
                                      ButtonConstants.primaryButtonColor,
                                ),
                                title: appLib.createRichText(giftName,
                                    fontFamily: 'cabin', bold: true),
                                onTap: () async {
                                  if (await canLaunchUrl(Uri.parse(giftUrl))) {
                                    await launchUrl(Uri.parse(giftUrl));
                                  } else {
                                    print('Could not launch gift $index');
                                  }
                                },
                              ),
                            ),
                          ]);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                );
              }
            }));
  }
}
