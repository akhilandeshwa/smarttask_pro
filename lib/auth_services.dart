import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://swlab.com/assignment/';

  static Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    String? name,
    String? phone,
  }) async {
    final url = Uri.parse('$baseUrl/user/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        if (name != null) 'name': name,
        if (phone != null) 'phone': phone,
      }),
    );

    final data = jsonDecode(response.body);
    print('REGISTER RESPONSE: ${response.body}');  // Debug
    if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
    }
    throw Exception(data['msg'] ?? 'Register failed');
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/user/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final data = jsonDecode(response.body);
    print('LOGIN RESPONSE: ${response.body}');  // Debug
    if (response.statusCode == 200) {
      return data;  // No token storage for now
    }
    throw Exception(data['msg'] ?? 'Login failed');
  }
}


