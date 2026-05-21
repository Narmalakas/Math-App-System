import 'package:flutter/material.dart';

class Quarter1Screen extends StatelessWidget {
  const Quarter1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quarter 1"),
      ),
      body: const Center(
        child: Text(
          "Welcome to Quarter 1",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}