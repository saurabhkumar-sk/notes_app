import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:notesapp/model/model.dart';

class Repo {
  Future getWeather() async {
    var weatherApiUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=Delhi&APPID=43ea6baaad7663dc17637e22ee6f78f2";

    final response = await http.get(Uri.parse(weatherApiUrl));
    log(response.body, name: "response");

    var responsebody = response.body;

    if (response.statusCode == 200) {
      log(response.body);
      return WeatherModel.fromJson(
        json.decode(responsebody),
      );
    } else {
      log("Failed to get weather data: ${response.statusCode}", name: 'failed');
    }
  }
}
