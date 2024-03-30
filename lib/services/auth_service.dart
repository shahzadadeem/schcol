import 'package:flutter/foundation.dart';
import 'package:schcol/models/user.dart';
import 'package:schcol/services/http_service.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();
  final _httpService = HttpService();

  User? user;

  factory AuthService() {
    return _singleton;
  }

  AuthService._internal();

  Future<bool> login(String username, String password) async {
    try {
      var responce = await _httpService.post("auth/login", {
        "username": username,
        "password": password,
      });

      if (responce!.statusCode == 200 && responce.data != null) {
        user = User.fromJson(responce.data);
        HttpService().setup(bToken: user!.token);
        return true;
      }

      // print(user!.email);
    } catch (e) {}

    return false;
  }
}
