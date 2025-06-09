import 'package:aplikasi_sepatu/provider/auth_provider.dart';
import 'package:aplikasi_sepatu/screen/auth/login.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final alamatController = TextEditingController();
    final noTelpController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nama')),
              const SizedBox(height: 10),
              TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email')),
              const SizedBox(height: 10),
              TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true),
              const SizedBox(height: 10),
              TextField(
                  controller: alamatController,
                  decoration: const InputDecoration(labelText: 'Alamat')),
              const SizedBox(height: 10),
              TextField(
                  controller: noTelpController,
                  decoration: const InputDecoration(labelText: 'No Telepon')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final success = await AuthService().register(
                    nama: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    alamat: alamatController.text,
                    noTelp: noTelpController.text,
                  );

                  if (success) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gagal mendaftar')),
                    );
                  }
                },
                child: const Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
