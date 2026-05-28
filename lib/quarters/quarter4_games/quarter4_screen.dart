import 'package:flutter/material.dart';

import '../../widgets/top_bar.dart';

class Quarter4Screen extends StatelessWidget {
  final String username;

  const Quarter4Screen({
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
              children: [

                TopBar(username: username),

                const SizedBox(height: 18),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [

                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              bottomLeft: Radius.circular(14),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "MATHQUEST",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFF8E5BD9),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(14),
                              bottomRight: Radius.circular(14),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "ADVENTURES",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "QUARTER 4",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                LayoutBuilder(
                  builder: (context, constraints) {

                    double screenWidth = constraints.maxWidth;

                    double cardWidth =
                        (screenWidth - 12) / 2;

                    return Wrap(
                      spacing: 12,
                      runSpacing: 14,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        9,
                        (index) => SizedBox(
                          width: cardWidth,
                          child: _levelCard(
                            level: index + 1,
                            lessonTitle: "LESSON TITLE",
                            onPlay: () {},
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _levelCard({
    required int level,
    required String lessonTitle,
    required VoidCallback onPlay,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFDF3D),
        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          FittedBox(
            child: Text(
              "LEVEL $level",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            lessonTitle,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 10),

          GestureDetector(
            onTap: onPlay,
            child: Container(
              width: double.infinity,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text(
                "PLAY",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}