import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'view_species.dart';
import 'package:intl/intl.dart';

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
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now().toLocal());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFCDEB45), // Top color
              Color(0xFFF4FFE9), // Middle color
              Color(0xFFFAFFF5), // Bottom color
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Classification Result Title
              const Text(
                "Classification Result",
                style: TextStyle(
                  fontFamily: 'Minecraft',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Display the image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  image,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // "You've caught a species!" Text
              const Text(
                "You've caught a species!",
                style: TextStyle(
                  fontFamily: 'Minecraft',
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.purpleAccent,
                ),
              ),
              const SizedBox(height: 12),

              // Display species result and status
              Text(
                result,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Minecraft',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              // Probability and Observation Details
              Text(
                "Probability: ${(probability * 100).toStringAsFixed(2)}%\nYou observed it on:\n$formattedDate",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Minecraft',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),

              // Buttons Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Species data not found!')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCDEB45),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'View Species',
                          style: TextStyle(
                            fontFamily: 'Minecraft',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Navigate back to camera
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Back to Camera',
                          style: TextStyle(
                            fontFamily: 'Minecraft',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
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
      ),
    );
  }
}
