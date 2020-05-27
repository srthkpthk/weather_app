import 'package:geolocator/geolocator.dart';
import 'package:weather/weather_library.dart';
import 'package:weather_app/util/Constants.dart';

class AppRepository {
  WeatherStation _ws = WeatherStation(API_KEY);

  Future<Weather> getWeather(Position position) async {
    return await _ws.currentWeather(position.latitude, position.longitude);
  }

  Future<List<Weather>> getForecast(Position position) async {
    return await _ws.fiveDayForecast(position.latitude, position.longitude);
  }
}
