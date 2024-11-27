import 'package:flutter/material.dart';
import 'discover.dart';
import 'home.dart'; // Import HomePage
import 'scan.dart'; // Import ScanScreen

class BirdsScreen extends StatelessWidget {
  const BirdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of bird images and their corresponding names
    final List<Map<String, String>> birdData = [
      {"image": "assets/redcrestedturaco.png", "name": "Red-crested Turaco"},
      {"image": "assets/shoebill.png", "name": "Shoebill"},
      {"image": "assets/whitestork.png", "name": "White Stork"},
      {"image": "assets/casuarius.png", "name": "Casuarius"},
      {"image": "assets/sunbittern.png", "name": "Sunbittern"},
      {"image": "assets/kingpenguin.png", "name": "King Penguin"},
      {"image": "assets/hamerkop.png", "name": "Hamerkop"},
      {"image": "assets/indianpeafowl.png", "name": "Indian Peafowl"},
      {"image": "assets/americanflamingo.png", "name": "American Flamingo"},
      {"image": "assets/annashummingbird.png", "name": "Anna's Hummingbird"},
      {"image": "assets/rainbowlorikeet.png", "name": "Rainbow Lorikeet"},
      {"image": "assets/kingfisher.png", "name": "Kingfisher"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Birds",
          style: TextStyle(
            fontFamily: 'Minecraft',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Scrollable GridView for bird images
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two columns
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1, // Square cards
                  ),
                  itemCount: birdData.length, // Number of bird items
                  itemBuilder: (context, index) {
                    final bird = birdData[index];
                    return Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              bird["image"]!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          bird["name"]!,
                          style: const TextStyle(
                            fontFamily: 'Minecraft',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          // Bottom Navigation Bar
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                height: 65,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  currentIndex: 1, // Highlight Birds tab
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: Colors.redAccent.withOpacity(0.9),
                  unselectedItemColor: Colors.white.withOpacity(0.9),
                  selectedFontSize: 14,
                  unselectedFontSize: 12,
                  iconSize: 24,
                  type: BottomNavigationBarType.fixed,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_filled),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.camera_alt),
                      label: 'Scan',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.manage_search_rounded),
                      label: 'Discover',
                    ),
                  ],
                  onTap: (index) {
                    if (index == 0) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const HomePage(),
                          transitionsBuilder: (_, anim, __, child) => FadeTransition(
                            opacity: anim,
                            child: child,
                          ),
                        ),
                      );
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const ScanPage(),
                          transitionsBuilder: (_, anim, __, child) => FadeTransition(
                            opacity: anim,
                            child: child,
                          ),
                        ),
                      );
                    } else if (index == 2) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const DiscoverScreen(),
                          transitionsBuilder: (_, anim, __, child) => FadeTransition(
                            opacity: anim,
                            child: child,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
