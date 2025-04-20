import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelgamekids/controller/puzzleController.dart';
import 'package:travelgamekids/model/city.dart';
import 'package:travelgamekids/model/flightRoute.dart';
import 'package:travelgamekids/views/routeScreen.dart';

class PuzzleGameScreen extends StatelessWidget {
  final City city;
  final FlightRoute route;
  const PuzzleGameScreen({Key? key, required this.city, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PuzzleController puzzleController = Get.put(
        PuzzleController(city.keywords, city.keywordHints));
    TextEditingController guessController = TextEditingController();

    return Scaffold(
     
      body: Container(
          decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.red, Colors.black87],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
Text("${city.name} Kelime Oyunu",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
SizedBox(height: 20,),

                // Üst bilgi: Kalan Süre, Pas Ceza, Bonus
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text("Kalan Süre",
                              style: TextStyle(fontSize: 16)),
                          Obx(() => Text(
                                "${puzzleController.remainingSeconds.value} sn",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Pas Cezası",
                              style: TextStyle(fontSize: 16)),
                          Obx(() => Text(
                                "${puzzleController.skipPenalty.value}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Bonus",
                              style: TextStyle(fontSize: 16)),
                          Obx(() => Text(
                                "${puzzleController.currentBonus}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Anahtar kelime kutuları: Wrap widgetı kullanarak kelimenin harfleri kare kutularda gösterilir.
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: Obx(() {
                    String currentWord =
                        puzzleController.currentUserAnswer.value;
                    return Wrap(
                      key: ValueKey<String>(currentWord),
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: currentWord.split('').map((char) {
                        return Container(
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: char == '_'
                                ? Colors.grey[200]
                                : Colors.red[200],
                            border: Border.all(
                                color: Colors.redAccent, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            char,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                // İpucu metni: aktif kelime ile ilgili dolaylı çağrışım içeren bilgi.
                Obx(() => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "İpucu: ${puzzleController.currentHint}",
                        style: const TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    )),
                const SizedBox(height: 30),
                // Tahmin girişi ve butonlar
           // Tahmin girişi ve butonlar bölümü
TextField(
  controller: guessController,
  decoration: InputDecoration(
    hintText: "Tahmininizi Girin",
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    filled: true,
    fillColor: Colors.white,
  ),
),
const SizedBox(height: 10),
Obx(() {
  // Oyun bitiş durumuna göre butonlar devre dışı bırakılıyor.
  bool disabled = puzzleController.gameOver.value;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ElevatedButton.icon(
        onPressed: disabled
            ? null
            : () {
                puzzleController.submitGuess(guessController.text);
                guessController.clear();
              },
        icon: const Icon(Icons.check, color: Colors.green),
        label: Text("Tahmini Yap", style: TextStyle(color: disabled != true ? Colors.red:Colors.grey)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle: const TextStyle(fontSize: 16),
        ),
      ),
      ElevatedButton.icon(
        onPressed:
            disabled ? null : puzzleController.revealLetter,
        icon: const Icon(Icons.lightbulb, color: Colors.yellow),
        label:  Text("Harf Al", style: TextStyle(color: disabled != true ? Colors.red:Colors.grey)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle: const TextStyle(fontSize: 16),
        ),
      ),
      ElevatedButton.icon(
        onPressed:
            disabled ? null : puzzleController.skipKeyword,
        icon: const Icon(Icons.skip_next, color: Colors.red),
        label:  Text("Pas Geç", style: TextStyle(color: disabled != true ? Colors.red:Colors.grey)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle: const TextStyle(fontSize: 16),
        ),
      ),
    ],
  );
}),

        const SizedBox(height: 30),
                // Oyun bitişinde final puan gösterimi.
                Obx(() {
                  if (puzzleController.gameOver.value) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            "Oyun Bitti! Final Skorunuz: ${puzzleController.finalScore.value}",
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                         SizedBox(height: 30,),

                                                ElevatedButton.icon(
                  onPressed: () { 
                    //Kullanıcı skoru burada kayıt olur

                    //Geciş İşlemi
                    Get.to(RouteScreen(route: route,));
              
                  },
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text("Kaydet ve Çık", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),),
                      ],
                    );
                  } else {
                     return Column(
                       children: [
                         Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Text(
                            "Oyun Devam Ediyor",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                                             ),
                                            SizedBox(height: 30,),

                                                ElevatedButton.icon(
                  onPressed: () {
                                  Get.to(RouteScreen(route: route,));

                  },
                  icon: const Icon(Icons.info, color: Colors.white),
                  label: const Text("Oyundan Çık", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                       ],
                     );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


