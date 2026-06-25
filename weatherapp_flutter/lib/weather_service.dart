import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp_flutter/weather_model.dart';

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<WeatherModel> getWeather(String cityName) async {
    final Response = await http.get(
      Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'),
    );
    if (Response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(Response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
