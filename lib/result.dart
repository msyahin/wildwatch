import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'view_species.dart';

class ResultPage extends StatelessWidget {
  final File image;
  final String result;
  final dynamic probability;

  const ResultPage({
    super.key,
    required this.image,
    required this.result,
    required this.probability,
  });

  Future<Map<String, dynamic>?> fetchSpeciesData(BuildContext context, String result) async {
  final String response = await DefaultAssetBundle.of(context).loadString('assets/species_data.json');
  List<dynamic> data = jsonDecode(response);

  // Extract species name (e.g., "Tiger") from result
  final speciesName = result.split(' ')[1]; // This will get the second word (assumes consistent format)

  return data.firstWhere(
    (species) => species["name"] == speciesName,
    orElse: () => null,
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Classification Result',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.4,
            fontFamily: 'SofiaSans',
            fontSize: 30,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300.0,
                height: 300.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'YOU SIGHTED A SPECIES!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green[800],
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              result,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Probability: ${(probability * 100).toStringAsFixed(2)}%',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'You first observed it on:\n${DateTime.now().toLocal()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final speciesData = await fetchSpeciesData(context, result);
                if (speciesData != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewSpeciesPage(speciesData: speciesData),
                    ),
                  );
                } else {
                  // Show error if species not found
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Species data not found!')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('VIEW SPECIES'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Handle navigation back to camera
              },
              child: const Text(
                'Back to Camera',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
