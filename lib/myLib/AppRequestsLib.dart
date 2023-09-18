// ignore_for_file: file_names, non_constant_identifier_names, unused_local_variable

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppConstants.dart';
import 'TokenManager.dart';

class AppRequests {
  String appUrl = AppConstants.appUrl;

  Future<http.Response> getRequest(String token, String path) {
    return http.get(
      Uri.parse('$appUrl$path'),
      headers: {
        'Authorization': "Token $token",
      },
    );
  }

  Future<void> postRequest(String path, String token, var body) async {
    final url = '$appUrl$path';
    token = TokenManager().token;

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': "Token $token",
        "Content-type": "application/json",
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('request Posted successfully');
    } else {
      print('Failed to Post request. Status code: ${response.statusCode}');
    }
  }

  Future<void> createEntry(String token, var entryData, double entry_id) async {
    final url = '$appUrl/create_entry/';

    token = TokenManager().token;
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': "Token $token",
        "Content-type": "application/json",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Entry created successfully');
      final entryData = jsonDecode(response.body);
      EntryManager().entryid = entryData['id'];
      print(EntryManager().entryid);
    } else {
      print('Failed to create entry. Status code: ${response.statusCode}');
    }
  }

  Future<dynamic> getQuestions(
      String token, double entry_id, int n_questions) async {
    final url = '$appUrl/get_questions/';

    token = TokenManager().token;
    final response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': "Token $token",
          "Content-type": "application/json",
        },
        body: jsonEncode({'entry_id': entry_id, 'n_questions': n_questions}));
    final responseDic = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Questions got successfully');
    } else {
      print('Failed to get questions. Status code: ${response.statusCode}');
    }
    return responseDic['questions'];
  }

  Future<dynamic> getRecommendations(var entryDic) async {
    final url = '$appUrl/get_recommendation/';

    String token = TokenManager().token;
    double entry_id = EntryManager().entryid;

    final response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': "Token $token",
          "Content-type": "application/json",
        },
        body: jsonEncode(entryDic));
    final responseDic = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Recommendations got successfully');
    } else {
      print(
          'Failed to get recommendations. Status code: ${response.statusCode}');
    }
    return responseDic;
  }

  Future<dynamic> getMyGifts() async {
    final url = '$appUrl/get_entries/';

    String token = TokenManager().token;

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': "Token $token",
        "Content-type": "application/json",
      },
    );
    final responseDic = jsonDecode(response.body);
    //print(responseDic);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('History got successfully');
    } else {
      print('Failed to get history. Status code: ${response.statusCode}');
    }
    return responseDic;
  }
}

class KeepLogin {
  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
    print('This token stored: $token');
  }

  Future<bool> isUserAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('authToken');
    print('The stored Token is:$authToken');

    if (authToken != null) {
      TokenManager().token = authToken;
    }
    return authToken != null;
  }
}
