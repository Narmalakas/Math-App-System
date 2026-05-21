import 'package:flutter/material.dart';

class Quarter3Screen extends StatelessWidget {
  const Quarter3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quarter 3"),
      ),
      body: const Center(
        child: Text(
          "Welcome to Quarter 3",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}