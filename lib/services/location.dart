import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class Location {
  double longitude;
  double latitude;

  Future<dynamic> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
