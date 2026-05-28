import 'package:flutter/material.dart';

import '../widgets/top_bar.dart';

class ShopScreen extends StatelessWidget {
  final String username;

  const ShopScreen({
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

                const SizedBox(height: 20),

                // ================= AVATARS =================
                _shopSection(
                  title: "AVATARS",
                  items: [
                    ShopItemData(
                      borderColor: Colors.grey,
                      price: "6767",
                    ),
                    ShopItemData(
                      borderColor: Colors.pinkAccent,
                      price: "6161",
                    ),
                    ShopItemData(
                      borderColor: Colors.red,
                      price: "6969",
                    ),
                    ShopItemData(
                      borderColor: Colors.yellow,
                      price: "911",
                    ),
                    ShopItemData(
                      borderColor: Colors.deepOrange,
                      price: "6967",
                    ),
                    ShopItemData(
                      borderColor: Colors.green,
                      price: "1432",
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ================= BORDERS =================
                _shopSection(
                  title: "AVATAR BORDERS",
                  items: [
                    ShopItemData(
                      borderColor: Colors.grey,
                      price: "6767",
                    ),
                    ShopItemData(
                      borderColor: Colors.pinkAccent,
                      price: "6161",
                    ),
                    ShopItemData(
                      borderColor: Colors.red,
                      price: "6969",
                    ),
                    ShopItemData(
                      borderColor: Colors.yellow,
                      price: "911",
                    ),
                    ShopItemData(
                      borderColor: Colors.deepOrange,
                      price: "6967",
                    ),
                    ShopItemData(
                      borderColor: Colors.green,
                      price: "1432",
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ================= POWER UPS =================
                _shopSection(
                  title: "POWER UPS",
                  items: [
                    ShopItemData(
                      borderColor: Colors.grey,
                      price: "6767",
                    ),
                    ShopItemData(
                      borderColor: Colors.pinkAccent,
                      price: "6161",
                    ),
                    ShopItemData(
                      borderColor: Colors.red,
                      price: "6969",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= SHOP SECTION =================

  Widget _shopSection({
    required String title,
    required List<ShopItemData> items,
  }) {
    return Column(
      children: [

        // TITLE
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF8E5BD9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),

        const SizedBox(height: 14),

        // ITEMS GRID
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final item = items[index];

            return Column(
              children: [

                // ITEM BOX
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: item.borderColor,
                        width: 3,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                // PRICE
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      const CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.teal,
                        child: Icon(
                          Icons.monetization_on,
                          size: 10,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 4),

                      Text(
                        item.price,
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

// ================= MODEL =================

class ShopItemData {
  final Color borderColor;
  final String price;

  ShopItemData({
    required this.borderColor,
    required this.price,
  });
}