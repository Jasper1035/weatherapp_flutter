import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp_flutter/weather_model.dart';
import 'package:weatherapp_flutter/weather_service.dart';
// import 'package:weatherapp_flutter/weatherinfo.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  final weatherService = WeatherService(dotenv.env['weatherinfo']!);
  WeatherModel? _weather;

  _fetchWeather() async {
    String cityName = await weatherService.getCurrentCity();
    try {
      final weather = await weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      rethrow;
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunny.json';
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud.json';

      case 'rain':
        return 'assets/rain.json';
      case 'drizzle':
        return 'assets/sunny.json';
      case 'snow':
        return 'assets/cloud.json';
      case 'thunderstorm':
        return 'assets/storm.json';
      case 'sunny':
        return 'assets/sunny.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? 'loading city..'),

            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            // Lottie.asset('assets/rain.json'),
            Text('${_weather?.temperature.round()} °C'),

            Text(_weather?.mainCondition ?? ''),
          ],
        ),
      ),
    );
  }
}
