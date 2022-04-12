import 'dart:math';

import 'package:training_flutter/weather_search/model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);
}

class FakeWeatherRepository implements WeatherRepository {
  double cacheTempCelsius = 0;
  @override
  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(const Duration(seconds: 1), () {
      final random = Random();
      cacheTempCelsius = 20 + random.nextInt(15) + random.nextDouble();
      return Weather(cityName: cityName, temperatureCelsius: cacheTempCelsius);
    });
  }
}
