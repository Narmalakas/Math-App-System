import 'package:flutter/material.dart';

class Quarter4Screen extends StatelessWidget {
  const Quarter4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quarter 4"),
      ),
      body: const Center(
        child: Text(
          "Welcome to Quarter 4",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}