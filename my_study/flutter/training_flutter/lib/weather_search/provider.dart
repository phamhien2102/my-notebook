import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_flutter/weather_search/model/weather.dart';
import 'package:training_flutter/weather_search/weather_notifier.dart';
import 'package:training_flutter/weather_search/weather_repository.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return FakeWeatherRepository();
});

final weatherNotifiProvider = StateNotifierProvider((ref) {
  return WeatherNotifier(ref.watch(weatherRepositoryProvider));
});
