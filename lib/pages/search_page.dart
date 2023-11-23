// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/weather_service.dart';

class SearchPage extends StatelessWidget {
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search a City'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter City Name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    WeatherModel? weather;
                    try {
                      WeatherService service = WeatherService();
                      weather = await service.getWeather(cityName: cityName!);
                      Provider.of<WeatherProvider>(context, listen: false)
                          .weatherData = weather;
                      Provider.of<WeatherProvider>(context, listen: false)
                          .cityName = cityName;
                      FocusManager.instance.primaryFocus
                          ?.unfocus(); // to close keyboard
                      Navigator.pop(context);
                    } catch (e) {
                       ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Make sure city name is correct !')));                 
                      print(e);
                    }
                  },
                ),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                cityName = val;
              },
              onSubmitted: (val) async {
                WeatherModel? weatherData;
                try {
                  WeatherService service = WeatherService();
                  weatherData = await service.getWeather(cityName: val);
                  Provider.of<WeatherProvider>(context, listen: false)
                      .cityName = val;
                  cityName = val;
                  Provider.of<WeatherProvider>(context, listen: false)
                      .weatherData = weatherData;                  
                      Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Make sure city name is correct !')));                                 
                  print(e);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
