import 'package:flutter/material.dart';

class Quarter2Screen extends StatelessWidget {
  const Quarter2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quarter 2"),
      ),
      body: const Center(
        child: Text(
          "Welcome to Quarter 2",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}