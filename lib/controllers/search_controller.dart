import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchWeatherController extends GetxService {
  String apiKey = 'd58ba9905d03fcf718c823f9baf9df24';
  String baseURL = 'http://api.weatherstack.com';
  String endpoint = '/current';
  TextEditingController textEditingController = TextEditingController();
  Dio dio = Dio();
  Rx<WeatherModel> weatherData = WeatherModel().obs;
  RxBool stateLoad = false.obs;
  Future<void> getData() async {
    stateLoad(false);
    await dio
        .get(
            '$baseURL$endpoint?access_key=$apiKey&query=${textEditingController.text}')
        .then((value) {
      printInfo(info: value.data.toString());
      weatherData(WeatherModel.fromJson(value.data));
      printInfo(info: weatherData.value.currentData!.description.toString());
      stateLoad(true);
    });
  }
}

class WeatherModel {
  LocationModel? locationModel;
  CurrentData? currentData;
  WeatherModel({this.currentData, this.locationModel});
  factory WeatherModel.fromJson(Map<String, dynamic> jsonData) {
    return WeatherModel(
        currentData: CurrentData.fromJson(jsonData['current']),
        locationModel: LocationModel.fromJson(jsonData['location']));
  }
}

class LocationModel {
  String? name;
  String? country;
  LocationModel({this.country, this.name});
  factory LocationModel.fromJson(Map<String, dynamic> jsonData) {
    return LocationModel(
        country: jsonData['country'] ?? "", name: jsonData['name'] ?? "");
  }
}

class CurrentData {
  String? obsTime;
  int? temp;
  String? description;
  String? weatherIcon;
  int? windSpeed;
  CurrentData(
      {this.weatherIcon,
      this.description,
      this.obsTime,
      this.temp,
      this.windSpeed});
  factory CurrentData.fromJson(Map<String, dynamic> jsonData) {
    return CurrentData(
        weatherIcon: jsonData['weather_icons'][0] ?? "",
        description: jsonData['weather_descriptions'][0] ?? "",
        obsTime: jsonData['observation_time'] ?? "",
        temp: jsonData['temperature'] ?? "",
        windSpeed: jsonData['wind_degree'] ?? "");
  }
}
