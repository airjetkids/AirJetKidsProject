import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelgamekids/model/city.dart';
import 'package:travelgamekids/model/flightRoute.dart';
import 'package:travelgamekids/views/cityDetailsScreen.dart';

class RouteScreen extends StatelessWidget {
  final FlightRoute route;
  const RouteScreen({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<City> routeCities = route.cities;
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text( "Rota: ${route.start.name} - ${route.end.name}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                fontSize: 18),),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                   
                    height: 240,
                    width: double.infinity,
                     decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 0.5,
                              
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                    child:  TurkeyMapWidget(cities: routeCities),
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                    itemCount: routeCities.length,
                    itemBuilder: (context, index) {
                      final city = routeCities[index];
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          leading: const Icon(Icons.location_on,color: Colors.red,),
                          title: Text(city.name),
                          subtitle: Text("Lat: ${city.latitude}, Lng: ${city.longitude}"),
                          trailing: const Icon(Icons.arrow_forward_ios,color: Colors.red,),
                          onTap: () {
                            // Seçilen şehir detay ekranına geçiş
                            Get.to(() => CityDetailScreen(city: city,route: route,));
                          },
                        ),
                      );
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


 // Yukarıdaki widget'ı bu dosyaya taşıyın veya uygun konumda import edin.

class TurkeyMapScreen extends StatelessWidget {
  final List<City> cities;
  const TurkeyMapScreen({Key? key, required this.cities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Türkiye Haritası"),backgroundColor: Colors.purple,),
      body: Center(child: TurkeyMapWidget(cities: cities)),
    );
  }
}

class TurkeyMapWidget extends StatelessWidget {
  final List<City> cities;
  const TurkeyMapWidget({Key? key, required this.cities}) : super(key: key);

  // Haritanın kapsadığı coğrafi sınırlar (resminizdeki coğrafi alanı kesin olarak belirleyin)
  static const double minLat = 36.0;
  static const double maxLat = 42.0;
  static const double minLng = 26.0;
  static const double maxLng = 45.0;

  // Harita asset'inizin orijinal boyutları: burada 1600x777 (dosyanızın 1807x777 gibi eski örnekten farklı olabilir)
  static const double mapImageWidth = 1600.0;
  static const double mapImageHeight = 777.0;

  /// Şehir koordinatlarını, container içindeki gerçek harita gösterim alanına göre hesaplar.
  Offset _calculateOffset({
    required double lat,
    required double lng,
    required double displayedWidth,
    required double displayedHeight,
    required double offsetX,
    required double offsetY,
  }) {
    // Enlem değerlerinin ters çevrildiğine dikkat: widget'larda y aşağıya artıyor.
    double relativeX = (lng - minLng) / (maxLng - minLng);
    double relativeY = (maxLat - lat) / (maxLat - minLat);
    double posX = offsetX + relativeX * displayedWidth;
    double posY = offsetY + relativeY * displayedHeight;
    return Offset(posX, posY);
  }

  @override
  Widget build(BuildContext context) {
  
    return LayoutBuilder(builder: (context, constraints) {
    
      final double containerWidth = constraints.maxWidth;
      final double containerHeight = constraints.maxHeight;

      // Resmin container'a sığdırılması sırasında hesaplanan scale değeri
      double scale = min(
        containerWidth / mapImageWidth,
        containerHeight / mapImageHeight,
      );
      double displayedWidth = mapImageWidth * scale;
      double displayedHeight = mapImageHeight * scale;

      // Resmin container içinde tam ortalanması için offset değerleri
      double offsetX = (containerWidth - displayedWidth) / 2;
      double offsetY = (containerHeight - displayedHeight) / 2;

      // Şehirlerin container içindeki pozisyonlarını hesaplayalım.
      final List<Offset> cityPositions = cities.map((city) {
        return _calculateOffset(
          lat: city.latitude,
          lng: city.longitude,
          displayedWidth: displayedWidth,
          displayedHeight: displayedHeight,
          offsetX: offsetX,
          offsetY: offsetY,
        );
      }).toList();

      return Stack(
        children: [
          // Arka planda Türkiye haritası resmi: resmin tamamının görünmesi için BoxFit.contain kullanılıyor.
          Positioned.fill(
            child: Image.asset(
              'assets/turkey_map.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
          // Şehirler arası ince çizgiyi çizen katman.
          Positioned.fill(
            child: CustomPaint(
              painter: RouteLinePainter(cityPositions: cityPositions),
            ),
          ),
          // Her iki şehir arasına uçak ikonları yerleştiriliyor.
          ..._buildAirplaneIcons(cityPositions),
          // Şehir marker’ları (kırmızı ikonlar)
          ...cityPositions.map((pos) {
            return Positioned(
              left: pos.dx - 12, // İkonun merkezde görünmesi için yarı genişlik çıkarılır.
              top: pos.dy - 12,
              child: GestureDetector(
                onTap: () {
                  // Marker tıklanırsa detay ekranına geçiş gibi işlemler ekleyebilirsiniz.
                },
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 24,
                ),
              ),
            );
          }).toList(),
        ],
      );
    });
  }

  // Şehirler arası her segmentin orta noktasına uçak ikonu yerleştirir.
  List<Widget> _buildAirplaneIcons(List<Offset> positions) {
    List<Widget> icons = [];
    // İki nokta arasında uçak ikonu yerleştirmek için her ardışık çift için
    for (int i = 0; i < positions.length - 1; i++) {
      Offset start = positions[i];
      Offset end = positions[i + 1];
      // Segmentin orta noktası:
      Offset midpoint = Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2);
      // İki nokta arasındaki açıyı hesaplayın (radyan cinsinden)
      double angle = atan2(end.dy - start.dy, end.dx - start.dx);
      icons.add(
        Positioned(
          // Uçak ikonunun merkezi orta noktaya denk gelecek şekilde ayarlanıyor.
          left: midpoint.dx - 12,
          top: midpoint.dy - 12,
          child: Transform.rotate(
            angle: angle,
            child: const Icon(
              Icons.airplanemode_active,
              color: Colors.blue,
              size: 24,
            ),
          ),
        ),
      );
    }
    return icons;
  }
}

/// Şehir marker'ları arasında ince çizgi çizen CustomPainter.
class RouteLinePainter extends CustomPainter {
  final List<Offset> cityPositions;
  RouteLinePainter({required this.cityPositions});

  @override
  void paint(Canvas canvas, Size size) {
    if (cityPositions.isEmpty) return;

    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(cityPositions.first.dx, cityPositions.first.dy);
    for (var pos in cityPositions.skip(1)) {
      path.lineTo(pos.dx, pos.dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant RouteLinePainter oldDelegate) {
    return oldDelegate.cityPositions != cityPositions;
  }
}
