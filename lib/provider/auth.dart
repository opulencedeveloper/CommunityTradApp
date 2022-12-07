import "dart:convert";
import "dart:async";

import "package:flutter/widgets.dart";
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _myFirstName;
  String? _mySurName;
  String? _myPhoneNumber;
  String? _myEmail;
  String? _myMemType;
  Future<void> signUpWithEmail(
      {required String firstName,
      required String surName,
      required String membershipType,
      required String email,
      required String phoneNo,
      required String password}) async {
    final url =
        Uri.parse("https://promensil.com.ng/victor/ndienuani/api/register");

    try {
      final response = await http.post(
        url,
        body: {
          "first_name": firstName,
          "sur_name": surName,
          "membership_type": membershipType,
          "email": email,
          "phone_no": phoneNo,
          "password": password,
        },
      );
      print(response.body);
      _myFirstName = firstName;
      _mySurName = surName;
      _myPhoneNumber = phoneNo;
      _myEmail = email;
      _myMemType = membershipType;

      if (json.decode(response.body)["error"] != null) {
        print(json.decode(response.body)["error"]);
        throw HttpException(json.decode(response.body)["error"]);
      }
    } catch (error) {
      print(error.toString());
      rethrow;
    }

    notifyListeners();
  }

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    final url =
        Uri.parse("https://promensil.com.ng/victor/ndienuani/api/login");

    try {
      final response = await http.post(
        url,
        body: {
          "email": email,
          "password": password,
        },
      );

      final extractedUser = (json.decode(response.body))["user"];
      if (extractedUser == null || extractedUser.isEmpty) {
        throw HttpException(json.decode(response.body)["error"]);
      }
      // print(response.body);
      //print(extractedUser);
      _myFirstName = extractedUser["first_name"];
      _mySurName = extractedUser["sur_name"];
      _myPhoneNumber = extractedUser["phone_no"];
      _myEmail = extractedUser["email"];
      _myMemType = extractedUser["membership_type"];
      if (json.decode(response.body)["error"] != null) {
        // print(json.decode(response.body)["error"]);
        throw HttpException(json.decode(response.body)["error"]);
      }
    } catch (error) {
      print(error.toString());
      rethrow;
    }

    notifyListeners();
  }

  String? get firstNameValue {
    return _myFirstName;
  }

  String? get surNameValue {
    return _mySurName;
  }

  String? get phoneNoValue {
    return _myPhoneNumber;
  }

  String? get emailValue {
    return _myEmail;
  }

  String? get memTypeValue {
    return _myMemType;
  }
}
