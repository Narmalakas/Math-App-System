import 'package:flutter/material.dart';

import '../screens/homepage_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/shop_screen.dart';
import '../screens/stats_screen.dart';

class TopBar extends StatelessWidget {
  final String username;

  const TopBar({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        // HOME BUTTON
        _topCircleButton(
          icon: Icons.home,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomepageScreen(
                  username: username,
                ),
              ),
            );
          },
        ),

        // STATS BUTTON
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StatsScreen(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.school,
                  color: Colors.green,
                  size: 18,
                ),
                SizedBox(width: 5),
                Text(
                  "stats",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        // PROFILE BUTTON
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  username: username,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.person,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        // SHOP BUTTON
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShopScreen(
                  username: username,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.teal,
                  child: Icon(
                    Icons.monetization_on,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  "6767",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        // SETTINGS
        _topCircleButton(
          icon: Icons.settings,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _topCircleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.white,
        child: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }
}