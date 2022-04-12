import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_flutter/weather_search/model/weather.dart';
import 'package:training_flutter/weather_search/weather_repository.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  const WeatherLoaded(this.weather);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is WeatherLoaded && o.weather == weather;
  }

  @override
  int get hashCode => weather.hashCode;
}

class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is WeatherError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class WeatherNotifier extends StateNotifier<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherNotifier(this._weatherRepository) : super(const WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      state = WeatherLoading();
      final weather = await _weatherRepository.fetchWeather(cityName);
      state = WeatherLoaded(weather);
    } on Exception {
      state = WeatherError('Could not fetch weather');
    }
  }
}
