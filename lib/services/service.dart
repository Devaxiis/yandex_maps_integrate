import 'package:geolocator/geolocator.dart';
import 'package:yandex_maps_integrat/model/map_model.dart';


abstract class AppLocation {
  Future<AppLatLong> getCurrentLocation();

  Future<bool> requestPermission();

  Future<bool> checkPermission();
}

class LocationService implements AppLocation {
  final defLocation = const TashkentLocation();

  @override
  Future<AppLatLong> getCurrentLocation() async {  //для определения текущей геопозиции (широта и долгота);
    return Geolocator.getCurrentPosition().then((value) {
      return AppLatLong(lat: value.latitude, long: value.longitude);
    }).catchError(
          (_) => defLocation,
    );
  }

  @override
  Future<bool> checkPermission() { //foydalanuvchi qurilmaning joylashuviga kirishga ruxsat berganligini tekshiradi.
    return Geolocator.checkPermission()
        .then((value) =>
    value == LocationPermission.always ||
        value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  @override
  Future<bool> requestPermission() { //joylashuv xizmatidan foydalanishga ruxsat so‘rash;
    return Geolocator.requestPermission()
        .then((value) =>
    value == LocationPermission.always ||
        value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }
}
