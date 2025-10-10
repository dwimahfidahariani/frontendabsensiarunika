import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  static Future<String> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return "Layanan lokasi tidak aktif";
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return "Izin lokasi ditolak";
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return "Izin lokasi ditolak permanen. Buka pengaturan untuk mengaktifkan.";
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks.first;
    return "${place.street}, ${place.subLocality}, ${place.locality} "
        "(${position.latitude.toStringAsFixed(5)}, ${position.longitude.toStringAsFixed(5)})";
  }
}
