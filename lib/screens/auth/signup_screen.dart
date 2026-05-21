import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config/api_config.dart';
import '../../widgets/auth_widgets.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _classNameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _classNameController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
  var url = Uri.parse("${ApiConfig.baseUrl}/register.php");

  var response = await http.post(url, body: {
    "username": _usernameController.text,
    "password": _passwordController.text,
    "class_name": _classNameController.text,
  });

  var data = json.decode(response.body);

  if (data["status"] == "success") {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Registered successfully")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data["message"] ?? "Registration failed")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6FA8DC),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildLogoHeader(),
              const SizedBox(height: 25),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          buildTextField(
            label: 'Username',
            icon: Icons.person_outline,
            controller: _usernameController,
          ),
          const SizedBox(height: 16),
          buildTextField(
            label: 'Password',
            icon: Icons.lock_outline,
            isPassword: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 16),
          buildTextField(
            label: 'Class Name',
            icon: Icons.group_outlined,
            controller: _classNameController,
          ),
          const SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: registerUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Create',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Already have an account? Sign In"),
          )
        ],
      ),
    );
  }
}