import 'dart:convert';

import 'package:flutter_http/constant/api_url.dart';
import 'package:flutter_http/model/User_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String getUserUrl = "$apiUrl/users?page=2";

  Future<UserModel?> getUserMethod() async {
    var userResponse = await http.get(Uri.parse(getUserUrl));

    try {
      if (userResponse.statusCode == 200) {
        var userResult = userModelFromJson(userResponse.body);
        return userResult;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
