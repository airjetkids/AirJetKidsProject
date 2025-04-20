import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelgamekids/model/flightRoute.dart';
import 'package:travelgamekids/views/gameScreen.dart';
import 'package:travelgamekids/model/city.dart';

class PuzzleInfoScreen extends StatefulWidget {
  final City city;
  final FlightRoute route;
  const PuzzleInfoScreen({Key? key, required this.city, required this.route}) : super(key: key);

  @override
  State<PuzzleInfoScreen> createState() => _PuzzleInfoScreenState();
}

class _PuzzleInfoScreenState extends State<PuzzleInfoScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<InstructionModel> instructions = [
    InstructionModel(
      title: "Amaç",
      description:
          "Her şehrin gizli anahtar kelimesini az ipucu kullanarak doğru tahmin edin. Doğru tahmin, açılan harf oranına göre 20 puan üzerinden değerlendirilir. Pas geçme seçeneğiyle ceza puanları birikir.",
      icon: Icons.flag,
    ),
    InstructionModel(
      title: "Harf Al",
      description:
          "Mevcut kelimenin henüz açılmamış harflerinden rastgele bir tanesi açılır. Açılan harf oranı puandan kesinti yapar. Örneğin, 10 harflik bir kelime %50 açılırsa 10 puan kesinti uygulanır.",
      icon: Icons.lightbulb,
    ),
    InstructionModel(
      title: "Tahmini Yap",
      description:
          "Doğru tahmin yaparsanız, o anahtar kelime için kalan puanınız 20 üzerinden hesaplanır. İpuçlarını kullanmadan doğru tahmin en yüksek puanı getirir.",
      icon: Icons.check_circle,
    ),
    InstructionModel(
      title: "Pas Geç",
      description:
          "Her pas geçme 30 puan ceza getirir. 3 kelimeyi de pas geçerseniz final puanınız 0 olur.",
      icon: Icons.skip_next,
    ),
    InstructionModel(
      title: "Bonus Puan",
      description:
          "Toplam süre 90 saniyedir ancak bonus puanı 60 saniye üzerinden hesaplanır. 60 saniye veya üzerinde bonus olarak tam 40 puan alırken süre ne kadar azalırsa bonus puan değeriniz düşecektir.",
      icon: Icons.timer,
    ),
    InstructionModel(
      title: "Tüm Harfler Açılırsa",
      description:
          "Eğer bir anahtar kelimenin bütün harflerini 'Harf Al' yöntemiyle açarsanız, o kelime için final puanınız 0 olur. En iyi sonuç için ipuçlarını kullanmadan doğru tahmin etmeye çalışın.",
      icon: Icons.warning,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Arka plan gradient
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.black87],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                "Kurallar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: instructions.length + 1,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    if (index < instructions.length) {
                      return InstructionCard(model: instructions[index]);
                    } else {
                      // Son sayfa: "Oyuna Başla" butonu
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32),
                              textStyle: const TextStyle(fontSize: 22),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              // Örneğin: PuzzleGameScreen'e geçiş
                              // Burada demo amaçlı bir City nesnesi kullanılabilir; kendi verinizle entegre ediniz.
                              // Aşağıdaki örnekte "city" parametresi olarak sabit bir şehir kullanıyorum.
                              Get.to(() => PuzzleGameScreen(
                                    city: widget.city,route: widget.route,
                                  ));
                            },
                            icon: const Icon(Icons.play_circle_filled, color: Colors.white),
                            label: const Text("Oyunu Başlat", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              // Sayfa indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(instructions.length + 1, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 12 : 8,
                    height: _currentPage == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.white : Colors.white54,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class InstructionModel {
  final String title;
  final String description;
  final IconData icon;

  InstructionModel({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class InstructionCard extends StatelessWidget {
  final InstructionModel model;
  const InstructionCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Card(
        elevation: 6,
        color: Colors.white.withOpacity(0.95),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                model.icon,
                size: 48,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                model.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                model.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
