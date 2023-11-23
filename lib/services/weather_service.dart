import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {    

  Future<WeatherModel> getWeather({required String cityName}) async {
    String baseUrl = "http://api.weatherapi.com/v1";
  String apiKey = 'b416a09e4fe4487b96a145007231108';
    Uri url =
        Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=3');
    http.Response response = await http.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);
    WeatherModel weatherData = WeatherModel.fromJson(data);
    return weatherData;
  }
}
