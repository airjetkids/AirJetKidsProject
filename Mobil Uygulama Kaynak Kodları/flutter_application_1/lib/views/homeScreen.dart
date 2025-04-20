import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelgamekids/main.dart';
import 'package:travelgamekids/model/city.dart';
import 'package:travelgamekids/model/flightRoute.dart';
import 'package:travelgamekids/views/routeScreen.dart';

class RouteSelectionScreen extends StatefulWidget {
  const RouteSelectionScreen({Key? key}) : super(key: key);

  @override
  _RouteSelectionScreenState createState() => _RouteSelectionScreenState();
}

class _RouteSelectionScreenState extends State<RouteSelectionScreen> {
  City? selectedStart;
  City? selectedEnd;

  // Tüm şehir seçenekleri (rota verilerinden gelen benzersiz şehirler)
  final List<City> allCities = const [
    elazig,
    malatya,
    ankara,
    istanbul,
    izmir,
    manisa,
    bursa
  ];

  @override
  void initState() {
    super.initState();
    // Varsayılan seçimler
    selectedStart = allCities.first;
    selectedEnd = allCities.last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Uygulama arka planı: kırmızıdan siyaha doğru gradient
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
                SizedBox(height: 50,),                // Uygulama logonuz (1280x800 boyutunda) için AspectRatio ile orantı korunuyor.
                Container(
                
                  width: 175,
                  height: 175,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
 gradient: LinearGradient(
            colors: [Colors.white, const Color.fromARGB(255, 207, 21, 7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
 ),
                  ),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 40),
                // Başlık
                Text(
                  "Nereye Gidiyoruz ?",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 30),
                // Kalkış Dropdown
                _buildDropdown(
                  label: "Kalkış",
                  
                  value: selectedStart,
                  onChanged: (City? city) {
                    setState(() {
                      selectedStart = city;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Varış Dropdown
                _buildDropdown(
                  label: "Varış",
                  value: selectedEnd,
                  onChanged: (City? city) {
                    setState(() {
                      selectedEnd = city;
                    });
                  },
                ),
                const SizedBox(height: 30),
                // Yolculuğa Başla Butonu
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 12),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    // Seçilen başlangıç ve varışa ait rotayı bulma
                    FlightRoute? selectedRoute = flightRoutes.firstWhereOrNull(
                      (route) =>
                          route.start.name == selectedStart!.name &&
                          route.end.name == selectedEnd!.name,
                    );
                    if (selectedRoute != null) {
                      Get.to(() => RouteScreen(route: selectedRoute));
                    } else {
                      Get.snackbar(
                        icon: Icon(Icons.location_on,color: Colors.white,),
                        "Hata",
                        "Seçtiğiniz şehirler arası rota bulunamadı.",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: const Text("Yolculuğa Başla",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Stil verilmiş Dropdown widget'ı
  Widget _buildDropdown({
    required String label,
    required City? value,
    required ValueChanged<City?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white70),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          DropdownButton<City>(
            isExpanded: true,
            underline: const SizedBox(),
            value: value,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
            items: allCities.map((City city) {
              return DropdownMenuItem<City>(
                value: city,
                child: Text(
                  city.name,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 16),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
