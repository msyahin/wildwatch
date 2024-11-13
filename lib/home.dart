import 'package:flutter/material.dart';
import 'scan.dart'; // Importing the ScanPage if needed

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white, // Changed background to white
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Welcome, Syafiy.',
                      style: TextStyle(
                        color: Colors.black, // Changed text color to black
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.black, // Changed background color for better visibility
                    child: Icon(
                      Icons.person,
                      color: Colors.white, // Changed icon color for better contrast
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Discover the wilderness today!',
                style: TextStyle(
                  color: Colors.black54, // Changed text color for better contrast
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black12, // Changed background color for contrast
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your History',
                      style: TextStyle(
                        color: Colors.black, // Changed text color to black
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Today, 13 August 2024',
                      style: TextStyle(
                        color: Colors.black54, // Changed text color for better contrast
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '3 new species discovered!',
                              style: TextStyle(color: Colors.black), // Changed text color to black
                            ),
                            Text(
                              '3 new different regions',
                              style: TextStyle(color: Colors.black), // Changed text color to black
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Saved'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Discover',
                    style: TextStyle(
                      color: Colors.black, // Changed text color to black
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See all',
                      style: TextStyle(color: Colors.blueAccent), // Changed color for visibility
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: GridView.count(
                  crossAxisCount: screenWidth > 360 ? 4 : 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                  children: [
                    _buildCategoryTile('Birds', Icons.filter_hdr),
                    _buildCategoryTile('Carnivore', Icons.category),
                    _buildCategoryTile('Herbivore', Icons.grass),
                    _buildCategoryTile('Sea Fish', Icons.water),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Recent Animals',
                style: TextStyle(
                  color: Colors.black, // Changed text color to black
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _buildAnimalCard('assets/placeholder.png'), // Replace with your image asset
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildAnimalCard('assets/placeholder.png'), // Replace with your image asset
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomNavItem(Icons.home, 'Home', () {
                    // Logic to go to HomePage or do nothing if already on it
                  }),
                  _buildBottomNavItem(Icons.camera_alt, 'Scan', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UploadPage()),
                    );
                  }),
                  _buildBottomNavItem(Icons.explore, 'Discover', () {
                    // Logic to go to DiscoverPage if you have one
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTile(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black12, // Changed color for contrast against white background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black, size: 30), // Changed icon color to black
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 12), // Changed text color to black
          ),
        ],
      ),
    );
  }

  Widget _buildAnimalCard(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.black, size: 30), // Changed icon color to black
          Text(
            label,
            style: const TextStyle(color: Colors.black, fontSize: 12), // Changed text color to black
          ),
        ],
      ),
    );
  }
}
