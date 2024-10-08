import 'package:clima/services/networking.dart';
import '../services/location.dart';

const apiKey = 'APIKEY';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getZipWeather(String zipCode, String countryCode) async {
    var url =
        '$openWeatherMapURL?zip={$zipCode},{$countryCode}&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location newLocation = Location();
    await newLocation.getCurrentLocation();

    NetworkHelper newNetwork = NetworkHelper(
        '$openWeatherMapURL?lat=${newLocation.latitude}&lon=${newLocation.longitude}&appid=$apiKey&units=metric');

    var weatherData = await newNetwork.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
