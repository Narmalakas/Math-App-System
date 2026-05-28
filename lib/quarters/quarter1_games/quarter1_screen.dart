import 'package:flutter/material.dart';
import 'Levels/lvl1_Adding _Simple_Fractions.dart';
import '../../widgets/top_bar.dart';

class Quarter1Screen extends StatelessWidget {
  final String username;

  const Quarter1Screen({
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

                // ================= TOP BAR =================
                TopBar(username: username),

                const SizedBox(height: 18),

                // ================= TITLE =================
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [

                      // MATHQUEST
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

                      // ADVENTURES
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
                          child: Center(
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

                // ================= QUARTER TITLE =================
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "QUARTER 1",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // ================= LEVELS =================
                LayoutBuilder(
                builder: (context, constraints) {

                  double screenWidth = constraints.maxWidth;

                  double cardWidth = (screenWidth - 12) / 2;

                  return Wrap(
                    spacing: 12,
                    runSpacing: 14,
                    alignment: WrapAlignment.center,
                    children: List.generate(
                    9,
                    (index) {

                      // LEVEL 1
                      if (index == 0) {
                        return SizedBox(
                          width: cardWidth,
                          child: _levelCard(
                            level: 1,
                            lessonTitle:
                                "Adding Simple Fractions\nwithout regrouping",
                            onPlay: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const Lvl1AddingSimpleFractions(),
                                ),
                              );
                            },
                          ),
                        );
                      }

                      // OTHER LEVELS
                      return SizedBox(
                        width: cardWidth,
                        child: _levelCard(
                          level: index + 1,
                          lessonTitle: "COMING SOON",
                          onPlay: () {},
                        ),
                      );
                    },
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

  // ================= LEVEL CARD =================

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

          // LEVEL
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

          // LESSON TITLE
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

          // PLAY BUTTON INSIDE BOX
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
              child: const FittedBox(
                child: Text(
                  "PLAY",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}