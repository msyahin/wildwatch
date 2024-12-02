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
        // Remove the species from the saved list
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
          'seenDate': DateTime.now().toLocal().toIso8601String(),
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
    String headerImage = widget.speciesData['headerImage'];
    List<String> images = List<String>.from(widget.speciesData['images']);

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
              headerImage,
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
                  // Name and details
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: status == 'Endangered' ? Colors.red : Colors.green,
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
                  const Text(
                    'Gallery',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: images.map((imgPath) {
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _toggleSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSaved ? Colors.redAccent : Colors.greenAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isSaved ? 'Saved' : 'Save',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
