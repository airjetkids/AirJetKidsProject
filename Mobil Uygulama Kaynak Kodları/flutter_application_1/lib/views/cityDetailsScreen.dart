import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelgamekids/R/r.dart';
import 'package:travelgamekids/log/views/logScreen.dart';
import 'package:travelgamekids/model/city.dart';
import 'package:travelgamekids/model/flightRoute.dart';
import 'package:travelgamekids/views/awartWidget.dart';
import 'package:travelgamekids/views/gameOnboard.dart';
import 'package:travelgamekids/views/gameScreen.dart';
import 'package:travelgamekids/views/gameStartScreen.dart';

// Şehir Detay Ekranı: Seçilen şehir için 3D AR placeholder ve "Oyunu Oyna" butonu.
class CityDetailScreen extends StatelessWidget {
  final City city;
  final FlightRoute route;
  const CityDetailScreen({Key? key, required this.city, required this.route}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.black87],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
              Text(city.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
              SizedBox(height: 10,),
                Expanded(
                  child: Container(
                    width: 400,
                    color: Colors.black12,
                    child: Text("Sanal Gerçeklik (${city.name})"), //CityARDisplay(modelPath: "assets/galata.gltf"), 
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: const Text("Oyunu Oyna",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                    onPressed: () {
                      Get.to(() =>PuzzleStartScreen(city: city, route: route));
                    },
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

