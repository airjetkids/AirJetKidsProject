import 'package:flutter/material.dart';

class LogManager {
  LogManager._internal();
  static final LogManager _instance = LogManager._internal();
  factory LogManager() => _instance;

  // Log mesajlarını saklamak için ValueNotifier kullanıyoruz.
  final ValueNotifier<List<String>> logs = ValueNotifier<List<String>>([]);

  // Yeni log eklemek için metot.
  void log(String message) {
    // Yeni mesaj eklenirken eski loglar kopyalanıp, yeni mesaj ekleniyor.
    logs.value = List.from(logs.value)..add(message);
    // Aynı zamanda konsola da yazdırabilirsiniz:
    debugPrint(message);
  }
}

//              LogManager().log("Paketlerim ekranı öncesi tüm kodlar çalıştı...");
