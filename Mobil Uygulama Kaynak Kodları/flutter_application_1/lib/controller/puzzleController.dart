import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PuzzleController extends GetxController {
  // Toplam süre 90 saniye olarak ayarlanmıştır.
  final RxInt remainingSeconds = 90.obs;
  // Doğru tahminlerden elde edilen puanlar
  final RxInt solvedScore = 0.obs;
  // Pas geçme cezası toplamı
  final RxInt skipPenalty = 0.obs;
  // Final puan (solvedScore + bonus - skipPenalty) hesaplanır.
  final RxInt finalScore = 0.obs;
  final RxBool gameOver = false.obs;

  // Anahtar kelime listesi; örneğin: ["Harput Kalesi", "Çaydacıra", "Keban"]
  final List<String> keywords;
  // Her anahtar kelime için ipucu metinleri listesi
  final List<String> hints;
  final RxInt currentKeywordIndex = 0.obs;
  // Mevcut anahtar kelimenin "_" şeklindeki gösterimi
  final RxString currentUserAnswer = ''.obs;
  // Bu anahtar kelime için açılan harf sayısını takip eder.
  final RxInt lettersRevealedCount = 0.obs;
  
  // Her anahtar kelimenin tamamen açılıp açılmadığını tutan RxList; başlangıçta tüm elemanlar false
  late RxList<bool> fullyRevealed;

  Timer? timer;
  final int initialTime = 90; // Toplam süre sabiti (saniye)
  int skipCount = 0;

  // Eğer kullanıcı 3 anahtar kelime pas geçerse final puan 0 olacak.
  bool allSkipped = false;

  PuzzleController(this.keywords, this.hints) {
    // fullyRevealed listesi, keywords uzunluğu kadar false ile başlatılır.
    fullyRevealed = RxList<bool>.generate(keywords.length, (index) => false);
    _startCurrentKeyword();
    startTimer();
  }

  void _startCurrentKeyword() {
    lettersRevealedCount.value = 0;
    // Yeni kelime için fullyRevealed bayrağı sıfırlanır.
    fullyRevealed[currentKeywordIndex.value] = false;
    String currentKeyword = keywords[currentKeywordIndex.value];
    currentUserAnswer.value = '_' * currentKeyword.length;
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        endGame();
      }
    });
  }

  /// "Harf Al" butonuyla: Mevcut kelimenin açılmamış harflerinden rastgele bir tanesini açar.
  /// Eğer açılan harf sonrası kelime tamamen açıldıysa,
  /// fullyRevealed[currentKeywordIndex] değeri true olarak işaretlenir.
  void revealLetter() {
    String currentKeyword = keywords[currentKeywordIndex.value];
    List<String> answerChars = currentUserAnswer.value.split('');
    List<int> hiddenIndices = [];
    for (int i = 0; i < currentKeyword.length; i++) {
      if (answerChars[i] == '_') {
        hiddenIndices.add(i);
      }
    }
    if (hiddenIndices.isNotEmpty) {
      int randomIndex = hiddenIndices[Random().nextInt(hiddenIndices.length)];
      answerChars[randomIndex] = currentKeyword[randomIndex];
      currentUserAnswer.value = answerChars.join('');
      lettersRevealedCount.value++;
    }
    // Eğer tüm harfler açılmışsa, bu kelime tamamen reveal edilmiş demektir.
    if (!currentUserAnswer.value.contains('_')) {
      fullyRevealed[currentKeywordIndex.value] = true;
      // Otomatik olarak sonraki kelimeye geçiş.
      Get.snackbar("Tüm Harfler Açıldı", "Bir sonraki anahtar kelimeye geçiliyor.",
       backgroundColor: Colors.red,
                        colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2));
      nextKeyword();
    }}
    
  /// Bu getter, mevcut kelime için harf alımından (ipucu) kaynaklanan ceza miktarını hesaplar.
  /// Örneğin, 10 harflik bir kelimede 5 harf açılmışsa ceza = floor((5/10)*20) = 10.
  int get letterPenalty {
    String currentKeyword = keywords[currentKeywordIndex.value];
    int totalLetters = currentKeyword.length;
    return ((lettersRevealedCount.value / totalLetters) * 20).floor();
  }

  /// Bonus puanı, kalan süre 50 saniye üzerinden hesaplanır.
  /// Örneğin, eğer kalan süre 50 saniye ise bonus = 40, 40 saniye ise bonus = floor((40/50)*40) = 32.
  int get currentBonus {
    int bonusTime = 50;
    int effectiveRemaining =
        remainingSeconds.value > bonusTime ? bonusTime : remainingSeconds.value;
    return ((effectiveRemaining / bonusTime) * 40).floor();
  }
  
  /// Aktif anahtar kelime için ipucu metnini döndürür.
  String get currentHint {
    return hints[currentKeywordIndex.value];
  }

  /// "Tahmini Yap" butonu: Kullanıcının tahminini kontrol eder.
  /// Doğru tahmin yapıldığında, alınacak puan = 20 - (harf alım oranı * 20).
  void submitGuess(String guess) {
    String currentKeyword = keywords[currentKeywordIndex.value];
    if (guess.trim().toLowerCase() == currentKeyword.toLowerCase()) {
      int totalLetters = currentKeyword.length;
      double revealedFraction = lettersRevealedCount.value / totalLetters;
      int deduction = (revealedFraction * 20).floor();
      int keywordScore = 20 - deduction;
      solvedScore.value += keywordScore;
      Get.snackbar("Tahmininiz Doğru!",
          "Anahtar kelime: $currentKeyword, Puan: $keywordScore",
           backgroundColor: Colors.green,
                        colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2));
      nextKeyword();
    } else {
      Get.snackbar("Yanlış Tahmin", "Tekrar deneyin!",
       backgroundColor: Colors.red,
                        colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2));
    }
  }

  /// "Pas Geç" butonuyla: Her pas geçişinde 30 puan ceza eklenir.
  /// Eğer 3 anahtar kelime pas geçilmişse, oyunun tümü için final puan 0 yapılır.
  void skipKeyword() {
    skipCount++;
    skipPenalty.value += 30;
    if (skipCount >= 3) {
      solvedScore.value = 0;
      endGame();
    } else {
      nextKeyword();
    }
  }

  /// Sonraki anahtar kelimeye geçiş yapar. Tüm anahtar kelimeler bittiğinde oyunu sonlandırır.
  void nextKeyword() {
    if (currentKeywordIndex.value < keywords.length - 1) {
      Future.delayed(const Duration(milliseconds: 500), () {
        currentKeywordIndex.value++;
        _startCurrentKeyword();
      });
    } else {
      endGame();
    }
  }

  /// Oyun bittiğinde: Final puan = (solvedScore + bonus - skipPenalty).
  /// Ayrıca, eğer kullanıcı tüm anahtar kelimeleri tamamen açtıysa (fullyRevealed tümü true ise),
  /// final puan 0 olarak belirlenir.
  void endGame() {
    timer?.cancel();
    gameOver.value = true;
    // Eğer tüm kelimeler tamamen reveal edildiyse, final puan 0.
    if (fullyRevealed.every((flag) => flag)) {
      finalScore.value = 0;
    } else {
      int bonus = currentBonus;
      finalScore.value = solvedScore.value + bonus - skipPenalty.value;
      if (finalScore.value < 0) finalScore.value = 0;
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
