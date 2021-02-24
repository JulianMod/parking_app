import 'package:geolocator/geolocator.dart';

///class receiving the current user position
class Location{
  double latitude;
  double longitude;

  ///method to return the current user location as future
  Future<void> getCurrentLocation() async {
    //getting the navigation data is very battery heavy, the precision should be adjusted accordingly
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      longitude = position.longitude;
    }
    catch (e){
      print(e);
    }

  }
}