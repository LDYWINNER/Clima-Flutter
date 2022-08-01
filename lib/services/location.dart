import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    try {
      bool servicestatus = await Geolocator.isLocationServiceEnabled();

      if (servicestatus) {
        print("GPS service is enabled");
      } else {
        print("GPS service is disabled.");
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          print("GPS Location service is granted");
        }
      } else {
        print("GPS Location permission granted.");
      }

      Position position = await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: false,
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      print(position.latitude);
      print(position.longitude);
    } catch (e) {
      print(e);
    }
  }
}
