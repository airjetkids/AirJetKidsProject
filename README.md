# AirJet Kids

## Repositories Notları

1. **Dökümantasyon Tanıtım ve Raporlar:** Tanıtım videosu,proje sunumları ve proje dökümantasyonları bu klasörde yer alır
2. **Mobil Uygulama Kaynak Kodları:** AirJet Kids mobil uygulamasının ilk geliştirme kaynak kodları bu klasörde yer alır.
3. **Web Sitesi Kaynak Kodları:** Airjet Kids web sitesi kaynak kodları bu klasörde yer alır.
4. **Mobil Uygulama Beta Apk:** Airjet Kids mobil uygulamasının gerçek cihazlarda test edilebilir ilk apk beta sürümü bu klasörde yer alır.
5. **Proje Son Sürüm Güncel Kod:** AirJet Kids mobil uygulamasının tamamlandığı en güncel kaynak kodları bu klasörde yer alır.
6. **Proje Son Sürüm Güncel Apk:** Airjet Kids mobil uygulamasının gerçek cihazlarda test edilebilir ve yeni sürüm özelliklerinin eklendiği en güncel apk sürümü bu klasörde yer alır.

   
**Proje Tanıtımı**  
Uçak seyahatlerinde çocukların kaliteli ve verimli bir yolculuk geçirmelerini sağlamak amacıyla geliştirilmiş interaktif bir mobil uygulama. Türkiye haritası üzerinde kullanıcıların seçtikleri şehirler arasında uçuş rotaları çizer; her şehirde artırılmış gerçeklik ile zenginleştirilmiş görseller ve puanlama süre gibi parametreler içeren kelime bulmaca oyunları sunarak çocuklara eğlenceli ve eğitici bir uçuş deneyimi yaşatır.

**Web Sitesi**  
🔗 [https://airjetkids.github.io/](https://airjetkids.github.io/)

<img width="1370" alt="Ekran Resmi 2025-04-20 16 02 05" src="https://github.com/user-attachments/assets/945ee091-aaaa-4e9b-a2bb-b34ca40caf52" />

**Proje Geliştirme Ekibi Üyeleri ve Görevleri**  
- **Ekip Lideri: Muhammed Fethi GÜMÜŞBOĞA** – Flutter ile mobil uygulama ön yüz geliştirme, Dart teknolojisi ile şehir rota modellerinin oluşturulması, Harita ve UI tasarımı, AR entegrasyonu ve 3D model yönetimi, Oyun mantığı GetX yönetimi, Oyun akışı ve puanlama

  
<img width="310" alt="Ekran Resmi 2025-04-20 15 59 55" src="https://github.com/user-attachments/assets/6048c8cf-2adf-420e-9a6a-a987036caee0" />



- **Ekip Üyesi: Nurettin Mutlu TÜVER** – Veri modelleri, JSON ve rota verilerinin hazırlanması, AR sahnelerinin oluşturulması, Marka web sitesinin oluşturulması, Proje dökümantasyon rapor ve tanıtımlarının gerçekleştirilmesi

  
<img width="310" alt="Ekran Resmi 2025-04-20 16 00 17" src="https://github.com/user-attachments/assets/f9bbaffa-ea14-4f0f-ac60-f4346913744e" />

- ## Trello Adresi
🔗 [ https://trello.com/b/frMMlU0m/airjet-kids](https://trello.com/b/frMMlU0m/airjet-kids)

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
- Gerçek cihazda deneyim yaşamak için Mobil Uygulama Beta Apk klasörü içinden mevcut apk sürümü indirilmesi gerekir.
- Gerçek cihazda deneyim için ARCore destekli Android işletim sistemine sahip cihazlarda çalıştırılması gerekir.
- ARCore destekli Cihazlar [https://developers.google.com/ar/devices?hl=tr](https://developers.google.com/ar/devices?hl=tr)


## Beta Sürüm Notları

1. **Kısıtlı sayıda rotasyonlar mevcuttur. (Elazığ-İstanbul,İzmir-Bursa)**
2. **Arttırılmış gerçeklik teknolojisi entegrasyonları tamamlandı. (Sahneler henüz mevcut değil)**
3. **Kullanıcı bazlı puanlama sistem altyapısı çalışmalarına başlandı.**


## Güncel Son Sürüm Notları

1. **Türkiye için olası uçuş rotasyonları eklendi.**
2. **Her şehir için ayrı ayrı materyaller ve ar modeli içeren kullanıcıların hafıza gelişimini destekleyen AR Kart Eşleştirme Oyunu Eklendi.**
3. **81 şehir için kullanıcı yaş kategorilerine göre kolay ve orta zorluklarda kelime oyunu verileri eklendi**
4. **Kullanıcı kayıt olma giriş yapma özellikleri eklendi.**
5. **Kullanıcıların Kelime Oyunu ve Ar Kart Eşleştirme Oyunu için şehir bazlı puanlarının görüntülendiği puanlama sistemi eklendi.**
6. **Her şehir için mevcut oyunlardaki en yüksek dereceyi yapan kullanıcılar Firebase bulut ortamında tutularak bütün kullanıcılar tarafından görüntüleneceği yapı eklendi.**
7. **Kullanıcının göz sağlık durumları etkilenmemesi için 20 dakikada bir 5 dakikalık zorunlu mola ekranı geliştirildi ve bu mola ekranından kullanıcının uygulama devam etme durumu engellendi.**
8. **Kullanıcının kişisel verileri sha-256 algoritmalarıyla şifrelenerek Firebase veritabanı ortamına aktarıldığı güvenlik katmanı eklendi.**
9. **Alfa Beta ve Gama testlerinde hata tespiti için mobil uygulama içerisinde loglama altyapısı kuruldu.**
10.**Oyun tanıtım ekranları eklenerek kullanıcıların oyunları nasıl oynayacağı ve puanlama sistemi anlatıldı.**

  
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

- ## Temel Akış

1. Şehir seçimi “Nereye Gidiyoruz?” ekranında kalkış ve varış şehirlerini belirleyin.


<p align="start">
  <img 
    src="https://github.com/user-attachments/assets/f34eb192-b938-4ffc-bde6-799b4e4397f5" 
    width="150"
    heigth ="300"
    alt="Uçuş Rotasyonu Ekran Görüntüsü" 
  />
</p>


2. Rota görüntüleme Harita ve şehir listesi ile uçuş rotasını inceleyin.

  <p align="start">
  <img 
    src="https://github.com/user-attachments/assets/f4213b78-ae06-41fc-872f-5c30326fe201" 
    width="150"
    heigth ="300"
    alt="Uçuş Rotasyonu Ekran Görüntüsü" 
  />
</p>

3. Şehir detayı Bir şehir seçip AR model önizlemesini görün ve “Oyunu Oyna” butonuna tıklayın.

   <p align="start">
  <img 
    src="https://github.com/user-attachments/assets/24fee34b-b5ba-4923-b829-a8ae500bdf83" 
    width="150"
    heigth ="300"
    alt="Uçuş Rotasyonu Ekran Görüntüsü" 
  />
</p>


4. Seçilen şehirde derece yapmış skorları görün ve "Oyuna Başla" veya "Öğren" butonuna tıklayın.

   <p align="start">
  <img 
    src="https://github.com/user-attachments/assets/f80ccb51-a6f6-4c5c-a745-e98c1ccac4bb" 
    width="150"
    heigth ="300"
    alt="Uçuş Rotasyonu Ekran Görüntüsü" 
  />
</p>

5. Bulmaca Kalan süre, ipucu, tahmin, harf al ve pas geç işlevlerini test ederek mini kelime bulmacayı tamamlayın.
 

   <p align="start">
  <img 
    src="https://github.com/user-attachments/assets/6debca88-611e-4b81-b55a-b4ca6eee25a4" 
    width="150"
    heigth ="300"
    alt="Uçuş Rotasyonu Ekran Görüntüsü" 
  />
</p>

6. Oyun sonu Puanınız hesaplanır; “Kaydet ve Çık” veya “Oyundan Çık” seçeneğiyle ana ekrana dönebilirsiniz.

    <p align="start">
  <img 
    src="https://github.com/user-attachments/assets/bea2fb66-472c-48e5-bea0-47fcb0edacd0" 
    width="150"
    heigth ="300"
    alt="Uçuş Rotasyonu Ekran Görüntüsü" 
  />
</p>

## Kapsamlı Tanıtım Videomuzun Linkimiz

https://youtu.be/xSlaiuqp3Vk

## Proje Sunum Dosyamızın Linki 

https://github.com/airjetkids/AirJetKidsProject/tree/main/D%C3%B6k%C3%BCmantasyon%20Tan%C4%B1t%C4%B1m%20ve%20Raporlar/Proje%20Sunumu


   


   
