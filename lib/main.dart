// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/providers/weather_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
    create: (BuildContext context) {
      return WeatherProvider();
    },
    child: WeatherApp(),
  ));
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Provider.of<WeatherProvider>(context).weatherData == null ? Colors.blue :
        Provider.of<WeatherProvider>(context).weatherData!.getThemeColor(),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
