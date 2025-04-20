// Uçuş rotası modeli: Başlangıç, bitiş ve rotadaki şehir listesini içerir.
import 'package:travelgamekids/model/city.dart';

class FlightRoute {
  final City start;
  final City end;
  final List<City> cities;

  const FlightRoute({
    required this.start,
    required this.end,
    required this.cities,
  });
}

// Örnek rotalar:
final List<FlightRoute> flightRoutes = [
  FlightRoute(
    start: elazig,
    end: istanbul,
    cities: [elazig, malatya, ankara, istanbul],
  ),
  FlightRoute(
    start: izmir,
    end: bursa,
    cities: [izmir,bursa],
  ),
];