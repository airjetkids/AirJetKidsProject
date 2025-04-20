import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelgamekids/model/city.dart';
import 'package:travelgamekids/model/flightRoute.dart';
import 'package:travelgamekids/views/awartWidget.dart';
import 'package:travelgamekids/views/gameOnboard.dart';
import 'package:travelgamekids/views/gameScreen.dart';

class PuzzleStartScreen extends StatelessWidget {
  final City city;
  final FlightRoute route;
  
  const PuzzleStartScreen({Key? key, required this.city, required this.route}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.black87],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Üstte şehrin adı ile "Dereceleri" başlığı
                Text(
                  "${city.name} Dereceleri",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const SizedBox(
                  height: 150,
                  child: TopAwardsWidget(),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    // Oyuna Başla butonuna basılırsa oyun ekranına geçiş yapar.
                    Get.to(() => PuzzleGameScreen(city: city, route: route));
                  },
                  icon: const Icon(Icons.play_circle, color: Colors.white),
                  label: const Text("Oyuna Başla", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    // Öğren butonuna basılırsa bilgilendirme ekranına geçiş yapılır.
                    Get.to(() => PuzzleInfoScreen(city: city, route: route));
                  },
                  icon: const Icon(Icons.info, color: Colors.white),
                  label: const Text("Öğren", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
