// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wonder_wrap/myLib/AppRequestsLib.dart';
import 'dart:convert';

import 'TokenManager.dart';
import 'AppWidgets.dart';
import 'AppConstants.dart';

AppRequests appReq = AppRequests();

class AuthProvider extends ChangeNotifier {
  String appUrl = AppConstants.appUrl;

  Future<void> signIn(
      BuildContext context, String email, String password, String token) async {
    try {
      Response response = await post(Uri.parse('$appUrl/login/'),
          body: {'email': email, 'password': password});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        TokenManager().token = responseData['token'];
        print(token);
        print('Login successfully');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GifteePage()));
        print('navigated to GifteePage Successfully');
        appReq.createEntry(token, entryDic, entry_id);
      } else {
        print('Failed to login');
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> handleSignIn(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    String email = emailController.text.toString();
    String password = passwordController.text.toString();

    await signIn(context, email, password, token);
    print('Sign in handeled');
  }
  
  Future<void> handleGuestSignIn(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    String email = 'guest1@example.com';
    String password = 'ImGuest';

    await signIn(context, email, password, token);
    print('Guest Sign in handeled');
  }
}
