import 'package:flutter/material.dart';
import 'auth/login_screen.dart';


class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6FA8DC),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 🔷 Logo
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.black12,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: const Column(
                children: [
                  Icon(Icons.calculate, color: Colors.orange),
                  SizedBox(height: 4),
                  Text(
                    "Adventures\nMathQuest",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔷 Text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Gain so much experience\nwhile learning and having fun\nat the same time!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A2A3A),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🔷 Grid (fixed sizing & spacing)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.9,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    FeatureCard(
                      title: "EXPERIENCE",
                      icon: Icons.trending_up,
                      color: Color(0xFF7E57C2),
                    ),
                    FeatureCard(
                      title: "ADVENTURE",
                      icon: Icons.flag,
                      color: Color(0xFF5C6BC0),
                    ),
                    FeatureCard(
                      title: "AWARDS",
                      icon: Icons.workspace_premium,
                      color: Color(0xFF8E24AA),
                    ),
                    FeatureCard(
                      title: "COINS",
                      icon: Icons.monetization_on,
                      color: Color(0xFFFFB300),
                    ),
                  ],
                )
              ),
            ),

            // 🔷 Button (better size + shape)
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: SizedBox(
                width: 260,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Get started",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 95,
          width: 95,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                blurRadius: 6,
                color: Colors.black12,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Icon(
            icon,
            size: 42,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 10),

        Container(
          width: 110,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD54F),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}