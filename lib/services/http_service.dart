import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
import 'package:schcol/consts.dart';

class HttpService {
  static final HttpService _singleton = HttpService._internal();

  final _dio = Dio();

  factory HttpService() {
    return _singleton;
  }

  HttpService._internal() {
    setup();
  }

  Future<void> setup({String? bToken}) async {
    final headers = {'Content-Type': 'application/json'};

    if (bToken != null) {
      headers["Authorization"] = "Bearer $bToken";
    }

    final options = BaseOptions(
        baseUrl: API_BASE_URL,
        headers: headers,
        validateStatus: (status) {
          if (status == null) return false;
          return status < 500;
        });

    _dio.options = options;
  }

  Future<Response?> post(String path, Map data) async {
    try {
      final responce = await _dio.post(path, data: data);
      return responce;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<Response?> get(String path) async {
    try {
      final responce = await _dio.get(path);
      return responce;
    } catch (e) {
      print(e);
    }

    return null;
  }
}
