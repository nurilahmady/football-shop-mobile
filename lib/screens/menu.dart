import 'package:flutter/material.dart';
import 'package:football_shop/widgets/left_drawer.dart';
import 'package:football_shop/widgets/right_drawer.dart';
import 'package:football_shop/widgets/products_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, this.username});

  final String? username;
  final String npm = "2406424814";
  final String kelas = "B";

  final List<ItemHomepage> items = [
    ItemHomepage("All Products", Icons.shopping_cart),
    ItemHomepage("My Products", Icons.inventory),
    ItemHomepage("Create Products", Icons.add),
    ItemHomepage("Logout", Icons.logout),
  ];

  final List<Color> colors = [
    const Color(0xFF2563EB),
    const Color(0xFF22C55E),
    const Color(0xFFEF4444),
    const Color(0xFFF59E0B),
  ];

  @override
  Widget build(BuildContext context) {
    final String displayName = username ?? "Pengguna";
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0F),
      appBar: AppBar(
        title: const Text(
          'Mysterious Football Store',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        iconTheme:  const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      endDrawer: const EndDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0B0B0F), Color(0xFF06060A)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: const [
                    Text(
                      '🧙🏻‍♀️ Mysterious Football Store',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Where luck decides your next football treasure ✨',
                      style: TextStyle(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Informasi(
                title: 'Data Diri',
                nama: displayName,
                npm: npm,
                kelas: kelas,
              ),
              const SizedBox(height: 20),
              GridView.count(
                padding: EdgeInsets.zero,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                shrinkWrap: true,
                children: colors.asMap().entries.map((entry) {
                  final index = entry.key;
                  final color = entry.value;
                  final item = items[index];
                  return ItemCard(item: item, color: color);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Informasi extends StatelessWidget {
  final String title;
  final String nama;
  final String npm;
  final String kelas;

  const Informasi({
    super.key,
    required this.title,
    required this.nama,
    required this.npm,
    required this.kelas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF12121A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.pinkAccent.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.account_circle,
            size: 70,
            color: Colors.pinkAccent,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text('Nama: $nama', style: const TextStyle(color: Colors.white70)),
              Text('NPM: $npm', style: const TextStyle(color: Colors.white70)),
              Text('Kelas: $kelas', style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  ItemHomepage(this.name, this.icon);
}
