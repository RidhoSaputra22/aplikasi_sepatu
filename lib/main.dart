import 'package:aplikasi_sepatu/screen/login.dart';
import 'package:aplikasi_sepatu/screen/regist.dart';
import 'package:aplikasi_sepatu/screen/sepatu_management.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ShoeStoreApp());
}

const String baseUrl = 'http://localhost:3000';

class ShoeStoreApp extends StatelessWidget {
  const ShoeStoreApp({super.key});
  final isLogin = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoe Store',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: isLogin ? SepatuManagementScreen() : LoginScreen(),
    );
  }
}
