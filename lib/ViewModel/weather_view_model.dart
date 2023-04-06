import 'dart:convert';

import '../Model/weather_model.dart';
import 'package:http/http.dart' as http;

import '../Services/Utilities/app_url.dart';

class WeatherViewModel {
  /*getProductsApi function start here*/
  Future<WeatherModel> fetchWorldRecords(String city) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=205102d0bcad9cb763cd854449d30c7a';
    final response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  /*getProductsApi function end here*/
}
