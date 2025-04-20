import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:travelgamekids/model/awart.dart';

class TopAwardsWidget extends StatefulWidget {
  const TopAwardsWidget({Key? key}) : super(key: key);

  @override
  State<TopAwardsWidget> createState() => _TopAwardsWidgetState();
}

class _TopAwardsWidgetState extends State<TopAwardsWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // Ödül bilgilerini içeren örnek liste; bu listeyi dilediğiniz gibi özelleştirebilirsiniz.
  final List<Award> awards = [
    Award(name: "Ahmet Öztürk", score: 95),
    Award(name: "Mehmet Çalık", score: 90),
    Award(name: "Ayşe Yılmaz", score: 88),
    Award(name: "Emre Demir", score: 85),
    Award(name: "Elif Kaya", score: 80),
  ];

  @override
  void initState() {
    super.initState();
    // Her 3 saniyede bir sayfayı otomatik olarak değiştir.
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < awards.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: awards.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ödül ikonu
            const Icon(
              Icons.emoji_events,
              size: 48,
              color: Colors.amber,
            ),
            const SizedBox(height: 8),
            // Ödül bilgisi: isim ve puan 100 üzerinden
            Text(
              "${awards[index].name} - ${awards[index].score}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
