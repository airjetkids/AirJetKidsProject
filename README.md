# AirJet Kids

**Proje Tanıtımı**  
Uçak seyahatlerinde çocukların kaliteli ve verimli bir yolculuk geçirmelerini sağlamak amacıyla geliştirilmiş interaktif bir mobil uygulama. Türkiye haritası üzerinde kullanıcıların seçtikleri şehirler arasında uçuş rotaları çizer; her şehirde artırılmış gerçeklik ile zenginleştirilmiş görseller ve puanlama süre gibi parametreler içeren kelime bulmaca oyunları sunarak çocuklara eğlenceli ve eğitici bir uçuş deneyimi yaşatır.

**Web Sitesi**  
🔗 [https://airjetkids.github.io/](https://airjetkids.github.io/)

<img width="1370" alt="Ekran Resmi 2025-04-20 16 02 05" src="https://github.com/user-attachments/assets/2718cad6-120e-47ae-9e1a-e3782e0e0509" />

**Proje Geliştirme Ekibi Üyeleri ve Görevleri**  
- **Ekip Lideri: Muhammed Fethi GÜMÜŞBOĞA** – Flutter ile mobil uygulama ön yüz geliştirme, Dart teknolojisi ile şehir rota modellerinin oluşturulması, Harita ve UI tasarımı, AR entegrasyonu ve 3D model yönetimi, Oyun mantığı GetX yönetimi, Oyun akışı ve puanlama
  
<img width="310" alt="Ekran Resmi 2025-04-20 15 59 55" src="https://github.com/user-attachments/assets/31084705-1c00-4d58-ad11-fe0976e31370" />



- **Ekip Üyesi: Nurettin Mutlu TÜVER** – Veri modelleri, JSON ve rota verilerinin hazırlanması, AR sahnelerinin oluşturulması, Marka web sitesinin oluşturulması, Proje dökümantasyon rapor ve tanıtımlarının gerçekleştirilmesi
  
<img width="310" alt="Ekran Resmi 2025-04-20 16 00 17" src="https://github.com/user-attachments/assets/0b4165a8-a78a-4785-bbc9-789d77eb9064" />


- ## Mobil Uygulama Kaynak Kod Yapısı

- **`lib/main.dart`**  
  Uygulamanın başlangıç noktası; `GetStorage`’ı başlatır ve ana ekran olarak `RouteSelectionScreen`’i yükler.

- **`lib/homeScreen.dart`** (`RouteSelectionScreen`)  
  Kullanıcının kalkış ve varış şehirlerini seçmesini sağlar, seçilen rotaya göre `RouteScreen` ekranına geçiş yapar.

- **`lib/routeScreen.dart`** (`RouteScreen` & `TurkeyMapWidget`)  
  Seçilen rotayı Türkiye haritası üzerinde çizerek uçak ve şehir ikonlarıyla gösterir; alt kısımda şehir listesini sunar.

- **`lib/cityDetailsScreen.dart`** (`CityDetailScreen`)  
  Seçilen şehir için AR model önizlemesi ve “Oyunu Oyna” butonunu içerir, bulmaca akışını başlatır.

- **`lib/r.dart`** (`CityARDisplay`)  
  `ar_flutter_plugin` kullanarak verilen GLTF modelini sahneye ekler, AR oturumunu yönetir.

- **`lib/gameOnboard.dart`** (`PuzzleInfoScreen`)  
  Bulmaca kurallarını kartlarla açıklar; en sonda “Oyunu Başlat” düğmesiyle oyuna geçiş yapar.

- **`lib/gameStartScreen.dart`** (`PuzzleStartScreen`)  
  Şehir için “Dereceleri” (lider tablosu) gösterir ve “Oyuna Başla” / “Öğren” seçenekleri sunar.

- **`lib/gameScreen.dart`** (`PuzzleGameScreen`)  
  Ana bulmaca oyunu ekranı: kalan süre, puan, ipucu gösterimi, tahmin, harf al ve pas geç işlevlerini barındırır.

- **`lib/puzzleController.dart`** (`PuzzleController`)  
  GetX tabanlı kontrolcü: süre sayımı, kelime yönetimi, puan hesaplama, pas geç ve oyun sonu mantığını içerir.

- **`lib/awartWidget.dart`** (`TopAwardsWidget`)  
  Ödül modeline (`Award`) dayalı basit bir PageView ile en yüksek skorlu oyuncuları döngüsel olarak gösterir.

- **`lib/awart.dart`** (`Award`)  
  Bir oyuncu adı ve skorunu tutan veri modeli.

- **`lib/city.dart`** (`City`)  
  Şehir adı, koordinatlar, AR model yolu ve bulmaca için anahtar kelime/ipuçları gibi meta verileri tanımlar.

- **`lib/flightRoute.dart`** (`FlightRoute`)  
  Başlangıç, bitiş şehirleri ve ara durak listesini içeren model; örnek rotalar barındırır.

- **`lib/logManager.dart`** (`LogManager`)  
  Uygulama içinde üretilen debug log’larını saklayan singleton sınıf.

- **`lib/logScreen.dart`** (`LogView`)
  `LogManager`’daki kayıtları yatay kaydırılabilir bir listede gösterir.


## Gereksinimler

- Flutter SDK (≥ 2.10)  
- Android Studio veya Xcode ile emülatör / gerçek cihaz  
- Gerçek cihazda deneyim için Beta Apk sürümü repostory içinden indirilmeli
- Gerçek cihazda deneyim için ARCore destekli Android işletim sistemine sahip cihazlarda çalıştırılması gerekir.
- ARCore destekli Cihazlar [https://developers.google.com/ar/devices?hl=tr](https://developers.google.com/ar/devices?hl=tr)

---

## Kurulum & Çalıştırma

1. **Depoyu klonlayın**  
   ```bash
   git clone <REPO_URL>
   cd <PROJECT_FOLDER>

2. **Gerekli paketleri yükleyin**  
   ```bash
   flutter pub get

3. **Uygulamayı Başlatmak için Emülatörü başlatın ve başlatma komutunu yazın**  
   ```bash
   flutter run

**Temel Akış**

1. Şehir seçimi “Nereye Gidiyoruz?” ekranında kalkış ve varış şehirlerini belirleyin.

<p align="start">
  <img 
    src="https://github.com/user-attachments/assets/350e7e6f-413f-4048-b023-01c104be0555" 
    width="150"
    heigth ="300"
    alt="Uçuş Rotasyonu Ekran Görüntüsü" 
  />
</p>

2. Rota görüntüleme Harita ve şehir listesi ile uçuş rotasını inceleyin.

  <p align="start">
  <img 
    src="https://github.com/user-attachments/assets/1b73a2e5-efb9-4ee0-945e-d04c0cd3a526" 
    width="150"
    heigth ="300"
    alt="Uçuş Rotasyonu Ekran Görüntüsü" 
  />
</p>

3. Şehir detayı Bir şehir seçip AR model önizlemesini görün ve “Oyunu Oyna” butonuna tıklayın.

   <p align="start">
  <img 
    src="https://github.com/user-attachments/assets/163e60a9-0a57-4fcd-b30d-1268e9911730" 
    width="150"
    heigth ="300"
    alt="Uçuş Rotasyonu Ekran Görüntüsü" 
  />
</p>


4. Seçilen şehirde derece yapmış skorları görün ve "Oyuna Başla" veya "Öğren" butonuna tıklayın.

   <p align="start">
  <img 
    src="https://github.com/user-attachments/assets/2f74d6ef-9b61-4523-b044-8ada67145be3" 
    width="150"
    heigth ="300"
    alt="Uçuş Rotasyonu Ekran Görüntüsü" 
  />
</p>

5. Bulmaca Kalan süre, ipucu, tahmin, harf al ve pas geç işlevlerini test ederek mini kelime bulmacayı tamamlayın.

   <p align="start">
  <img 
    src="https://github.com/user-attachments/assets/4388d88d-8761-446c-bb3e-faba8cdbc07f" 
    width="150"
    heigth ="300"
    alt="Uçuş Rotasyonu Ekran Görüntüsü" 
  />
</p>

6. Oyun sonu Puanınız hesaplanır; “Kaydet ve Çık” veya “Oyundan Çık” seçeneğiyle ana ekrana dönebilirsiniz.

    <p align="start">
  <img 
    src="https://github.com/user-attachments/assets/536a3ec3-5dcc-43f4-b0e8-e4658d9d8b15" 
    width="150"
    heigth ="300"
    alt="Uçuş Rotasyonu Ekran Görüntüsü" 
  />
</p>


   


   
