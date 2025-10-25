import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:martfury/src/service/currency_service.dart';
import 'package:martfury/src/service/language_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:martfury/core/app_config.dart';
import 'package:martfury/src/service/token_service.dart';
import 'package:martfury/src/view/screen/start_screen.dart';
import 'package:get/get.dart';

class BaseService {
  static String get baseUrl => AppConfig.apiBaseUrl;

  Future<Map<String, String>> _getHeaders({bool includeAuth = true}) async {
    final prefs = await SharedPreferences.getInstance();
    final currency = json.decode(
      prefs.getString(CurrencyService.selectedCurrencyKey) ?? '{}',
    );
    final language = json.decode(
      prefs.getString(LanguageService.selectedLanguageKey) ?? '{}',
    );

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-CURRENCY': (currency?['title'] ?? '').toString(),
      'X-LANGUAGE': (language?['lang_locale'] ?? '').toString(),
      'X-API-KEY': AppConfig.apiKey,
    };

    if (includeAuth) {
      headers['Authorization'] =
          'Bearer ${await TokenService.getToken() ?? ''}';
    }

    return headers;
  }

  Future<dynamic> _handleResponse(http.Response response) async {
    if (kDebugMode) {
      print('🌐 BaseService Response Status: ${response.statusCode}');
      print('🌐 BaseService Response Body: ${response.body}');
    }

    if (response.statusCode == 401) {
      // Handle unauthorized - clear token and redirect to start screen
      await TokenService.deleteToken();
      Get.offAll(() => const StartScreen());
      throw Exception('Unauthorized');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      try {
        final errorBody = json.decode(response.body);
        final errorMessage = errorBody['error'] ?? 
                           errorBody['message'] ?? 
                           'HTTP ${response.statusCode}: ${response.body}';
        if (kDebugMode) {
          print('🌐 BaseService Error: $errorMessage');
        }
        throw Exception(errorMessage);
      } catch (e) {
        if (kDebugMode) {
          print('🌐 BaseService Parse Error: $e');
        }
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    }
  }

  Future<dynamic> get(String endpoint) async {
    final headers = await _getHeaders();
    final url = '$baseUrl$endpoint';

    if (kDebugMode) {
      print('🌐 BaseService GET: $url');
      print('🌐 BaseService Headers: $headers');
    }

    final response = await http.get(Uri.parse(url), headers: headers);

    if (kDebugMode) {
      print('🌐 BaseService Response Status: ${response.statusCode}');
      final bodyPreview = response.body.length > 500
          ? response.body.substring(0, 500) + '...'
          : response.body;
      print('🌐 BaseService Response Body: $bodyPreview');
    }

    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, Object> body) async {
    final headers = await _getHeaders();
    final url = '$baseUrl$endpoint';

    if (kDebugMode) {
      print('🌐 BaseService POST: $url');
      print('🌐 BaseService Headers: $headers');
      print('🌐 BaseService Body: ${json.encode(body)}');
    }

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    if (kDebugMode) {
      print('🌐 BaseService Response Status: ${response.statusCode}');
      print('🌐 BaseService Response Body: ${response.body}');
    }

    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, Object> body) async {
    final headers = await _getHeaders();
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: json.encode(body),
    );

    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint, Map<String, Object> body) async {
    final headers = await _getHeaders();
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: json.encode(body),
    );

    return _handleResponse(response);
  }

  /// POST method for authentication endpoints (without Authorization header)
  Future<dynamic> postAuth(String endpoint, Map<String, Object> body) async {
    final headers = await _getHeaders(includeAuth: false);
    final url = '$baseUrl$endpoint';

    if (kDebugMode) {
      print('🌐 BaseService POST Auth: $url');
      print('🌐 BaseService Headers: $headers');
      print('🌐 BaseService Body: ${json.encode(body)}');
    }

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    return _handleResponse(response);
  }
}
