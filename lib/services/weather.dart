import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

const apiKey = '3d044a250241b395a843403572a0e966';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  double longitude;
  double latitude;

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkingHelper networkingHelper = NetworkingHelper(
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$cityName.json?access_token=pk.eyJ1Ijoic29uaWJveSIsImEiOiJja2pmcXdqZ3Q0aTRhMnlsZzk0ZXQ2eXN4In0.C3EGSG3df6cspYfogn_eyA");
    var weather = await networkingHelper.getData();
    return getLocationData(weatherReport: weather);
  }

  Future<dynamic> getLocationData({dynamic weatherReport}) async {
    if (weatherReport != null) {
      longitude = weatherReport['features'][3]['center'][0];
      latitude = weatherReport['features'][3]['center'][1];

      var name = weatherReport['query'];
      print(name);
    } else {
      Location location = Location();
      await location.getCurrentLocation();

      longitude = location.longitude;
      latitude = location.latitude;
    }

    NetworkingHelper networkingHelper = NetworkingHelper(
        '$openWeatherMapUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    var weatherData = await networkingHelper.getData();
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
