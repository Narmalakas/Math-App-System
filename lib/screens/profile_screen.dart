import 'package:flutter/material.dart';

import '../widgets/top_bar.dart';

class ProfileScreen extends StatelessWidget {
  final String username;

  const ProfileScreen({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5A9CF8),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // TOP BAR
                TopBar(username: username),

                const SizedBox(height: 20),

                // TITLE
                const Text(
                  "PROFILE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 15),

                // PROFILE INFO
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // AVATAR
                    Column(
                      children: [
                        Container(
                          width: 95,
                          height: 95,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.orange,
                          ),
                        ),

                        const SizedBox(height: 8),

                        _yellowButton("CHANGE"),
                      ],
                    ),

                    const SizedBox(width: 15),

                    // NICKNAME
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "NICKNAME",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Container(
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              username,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          _yellowButton("CHANGE"),
                        ],
                      ),
                    ),

                    const SizedBox(width: 15),

                    // RANK
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "RANKED",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          "CURRENT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 3),

                        _rankBox(),

                        const SizedBox(height: 8),

                        const Text(
                          "HIGHEST",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 3),

                        _rankBox(),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // COLLECTIONS
                _collectionSection(),

                const SizedBox(height: 20),

                _collectionSection(),

                const SizedBox(height: 20),

                // POWER UPS
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8E5BD9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [

                      _sectionTitle("POWER UP INVENTORY"),

                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          4,
                          (index) => _lockedBox(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= WIDGETS =================

  static Widget _yellowButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }

  static Widget _rankBox() {
    return Container(
      width: 80,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  static Widget _sectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  static Widget _avatarBox() {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: const Icon(
        Icons.person,
        color: Colors.orange,
      ),
    );
  }

  static Widget _lockedBox() {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: const Text(
        "?",
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget _collectionSection() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF8E5BD9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [

          _sectionTitle("AVATAR COLLECTIONS"),

          const SizedBox(height: 15),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => _avatarBox(),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => _lockedBox(),
            ),
          ),
        ],
      ),
    );
  }
}