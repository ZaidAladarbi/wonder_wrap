// ignore_for_file: file_names, use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wonder_wrap/myLib/TokenManager.dart';
import 'dart:convert';
import 'AppRequestsLib.dart';
import 'AppWidgets.dart';
import 'AppConstants.dart';

AppRequests appReq = AppRequests();
KeepLogin kpLog = KeepLogin();

class RegisterationProvider extends ChangeNotifier {
  String appUrl = AppConstants.appUrl;

  Future<void> signUp(BuildContext context, String firstName, String lastName,
      String email, String password, String token) async {
    try {
      Response response = await post(Uri.parse('$appUrl/signup/'), body: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        TokenManager().token = responseData["token"];
        //print(token);

        if (TokenManager().token != '') {
          await kpLog.storeToken(TokenManager().token);
        }

        print('Registration successful');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GifteePage()));
        print('Navigated to GifteePage Successfully');
        appReq.createEntry(token, entryDic, entry_id);
      } else {
        print('Failed to register user.');
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> handleSignUp(
    BuildContext context,
    TextEditingController firstNameController,
    TextEditingController lastNameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
  ) async {
    String firstName = firstNameController.text.toString();
    String lastName = lastNameController.text.toString();
    String email = emailController.text.toString();
    String password = passwordController.text.toString();
    String confirmPassword = confirmPasswordController.text.toString();

    if (password == confirmPassword) {
      await signUp(context, firstName, lastName, email, password, token);
      print('Sign up handeled');
    } else {
      print('Password and Confirmed Password are not the same');
    }
  }
}
