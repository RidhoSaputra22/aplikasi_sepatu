import 'dart:convert';
import 'package:aplikasi_sepatu/config/api.dart';
import 'package:http/http.dart' as http;

const String baseUrl = ApiServices.baseUrl;

class AuthService {
  Future<bool> register({
    required String nama,
    required String email,
    required String password,
    required String alamat,
    required String noTelp,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nama': nama,
        'email': email,
        'password': password,
        'alamat': alamat,
        'no_telp': noTelp,
      }),
    );

    return response.statusCode == 201;
  }

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    return response.statusCode == 200;
  }
}
