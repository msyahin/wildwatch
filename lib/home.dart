import 'package:flutter/material.dart';
import 'scan.dart'; // Import the ScanScreen file

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const HomeScreen(),
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
                    currentIndex: 0,
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
                      if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ScanPage()),
                        );
                      } else if (index == 0) {
                        // Navigate back to HomeScreen (or handle Home tap if needed)
                      } else if (index == 2) {
                        // Add logic for Discover button if necessary
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(height: 32),
          WelcomeBanner(),
          SizedBox(height: 16),
          DiscoverSection(),
          SizedBox(height: 16),
          Expanded(
            child: RecentAnimalsSection(),
          ),
        ],
      ),
    );
  }
}

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            text: 'Welcome, ',
            style: TextStyle(
              fontFamily: 'Minecraft',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: 'Syafiy!',
                style: TextStyle(
                  fontFamily: 'Minecraft',
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const Text(
          'Discover the wilderness today!',
          style: TextStyle(
            fontFamily: 'Minecraft',
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        const YourHistoryCard(),
      ],
    );
  }
}

class YourHistoryCard extends StatelessWidget {
  const YourHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE3FF63),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your History',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  '3 new species discovered!',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  '3 new different regions',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
              ),
              child: const Text('Check'),
            ),
          ],
        ),
      ),
    );
  }
}

class DiscoverSection extends StatelessWidget {
  const DiscoverSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Discover',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('See all'),
          ],
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DiscoverCard(label: 'Birds', iconPath: 'assets/birds.png', backgroundColor: Color(0xFFFF2257)),
              DiscoverCard(label: 'Carnivore', iconPath: 'assets/carnivore.png', backgroundColor: Color(0xFFFFCF23)),
              DiscoverCard(label: 'Herbivore', iconPath: 'assets/herbivore.png', backgroundColor: Color(0xFFA3EE89)),
              DiscoverCard(label: 'Sea Fish', iconPath: 'assets/seafish.png', backgroundColor: Color(0xFF1AACFF)),
            ],
          ),
        ),
      ],
    );
  }
}

class DiscoverCard extends StatelessWidget {
  final String label;
  final String iconPath;
  final Color backgroundColor;

  const DiscoverCard({
    super.key,
    required this.label,
    required this.iconPath,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: Image.asset(iconPath, width: 50, height: 50),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

class RecentAnimalsSection extends StatelessWidget {
  const RecentAnimalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Animals',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1, // Ensures consistent aspect ratio for all grid items
            ),
            itemCount: animalImages.length,
            itemBuilder: (context, index) {
              return AnimalCard(imagePath: animalImages[index]);
            },
          ),
        ),
      ],
    );
  }
}

const List<String> animalImages = [
  'assets/lion.jpg',
  'assets/placeholder.png',
  'assets/tiger.jpg',
  'assets/panda.jpg',
  'assets/elephant.jpg',
  'assets/cheetah.jpg',
];

class AnimalCard extends StatelessWidget {
  final String imagePath;

  const AnimalCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover, // Ensures the image covers the container without distortion
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
