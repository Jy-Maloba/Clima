import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.low,
      distanceFilter: 100,
    );
    try {
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
      latitude = position.latitude;
      longitude = position.longitude;
      // print(position);
    } catch (e) {
      // print(e);
    }
  }
}
