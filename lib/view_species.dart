import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewSpeciesPage extends StatefulWidget {
  final Map<String, dynamic> speciesData;

  const ViewSpeciesPage({
    super.key,
    required this.speciesData,
  });

  @override
  _ViewSpeciesPageState createState() => _ViewSpeciesPageState();
}

class _ViewSpeciesPageState extends State<ViewSpeciesPage> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // Check if the species is already saved
      CollectionReference savedSpecies = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('saved_species');

      QuerySnapshot query = await savedSpecies
          .where('name', isEqualTo: widget.speciesData['name'])
          .get();

      if (query.docs.isNotEmpty) {
        setState(() {
          isSaved = true;
        });
      }
    } catch (e) {
      print('Error checking if species is saved: $e');
    }
  }

  Future<void> _toggleSave() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User is not logged in.');
      return;
    }

    try {
      CollectionReference savedSpecies = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('saved_species');

      if (isSaved) {
        // Remove the species from saved list
        QuerySnapshot query = await savedSpecies
            .where('name', isEqualTo: widget.speciesData['name'])
            .get();

        for (var doc in query.docs) {
          await doc.reference.delete();
        }

        setState(() {
          isSaved = false;
        });
      } else {
        // Save the species to Firestore with seenDate
        await savedSpecies.add({
          ...widget.speciesData,
          'seenDate': DateTime.now().toLocal().toIso8601String(), // Adding seenDate
        });

        setState(() {
          isSaved = true;
        });
      }
    } catch (e) {
      print('Error toggling save status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.speciesData['name'];
    String scientificName = widget.speciesData['scientificName'];
    String description = widget.speciesData['description'];
    String location = widget.speciesData['location'];
    String diet = widget.speciesData['diet'];
    String status = widget.speciesData['status'];
    List<String> images = List<String>.from(widget.speciesData['images']);

    // Ensure at least 3 images in the gallery
    while (images.length < 3) {
      images.add('assets/placeholder.png');
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header image
            Image.asset(
              images[0],
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row with Name, Scientific Name, Status, Diet, and Location
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Scientific Name
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              scientificName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Status, Diet, and Location on the right
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: status == 'Endangered' ? const Color.fromARGB(255, 255, 0, 0) : Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              status,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.lightGreenAccent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              diet,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.lightGreen[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              location,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  // Gallery
                  const Text(
                    'Gallery',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: images.take(3).map((imgPath) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          imgPath,
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  // Toggle Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _toggleSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSaved ? const Color.fromARGB(255, 255, 214, 201) : const Color(0xFFCDEB45),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isSaved ? 'Saved' : 'Save',
                        style: const TextStyle(
                          fontFamily: 'Minecraft',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
