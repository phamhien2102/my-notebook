import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_flutter/weather_search/model/weather.dart';
import 'package:riverpod/riverpod.dart';
import 'package:training_flutter/weather_search/provider.dart';
import 'package:training_flutter/weather_search/weather_notifier.dart';

class WeatherSearchPage extends ConsumerStatefulWidget {
  const WeatherSearchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<WeatherSearchPage> createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends ConsumerState<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(weatherNotifiProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather Search'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: Consumer(
            builder: (context, ref, child) {
              if (state is WeatherInitial) {
                return buildInitialInput();
              } else if (state is WeatherLoading) {
                return buildLoading();
              } else if (state is WeatherLoaded) {
                return buildColumnWithData(state.weather);
              } else {
                return buildInitialInput();
              }
            },
          ),
        ));
  }

  Widget buildInitialInput() {
    return const Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        Text(
          weather.temperatureCelsius.toString(),
          style: const TextStyle(fontSize: 80),
        ),
        const CityInputField(),
      ],
    );
  }
}

class CityInputField extends ConsumerWidget {
  const CityInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) {
          ref.watch(weatherNotifiProvider.notifier).getWeather(value);
        },
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
            hintText: 'Enter a city',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: const Icon(Icons.search)),
      ),
    );
  }

  void submitCityName(BuildContext context, String value) {
    // context.r(weatherNotifiProvider).
  }
}
