import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

List<ParkingSpot> parkingSpotsList = [];

class ParkingSpot{
  double latitude;
  double longitude;
  String name;
  String description;
  double rating;

  var uuid = Uuid();

  ParkingSpot({
      this.name,
      this.description,
      this.latitude,
      this.longitude,
      this.rating
  });

  Set<Marker> getParkingMarkers(){
    List<Marker> _markers = <Marker>[];

    for (int i = 0; i < parkingSpotsList.length; i++){
      _markers.add(
        Marker(
          markerId: MarkerId(uuid.v1()),
          position: LatLng(parkingSpotsList[i].latitude, parkingSpotsList[i].longitude),
          //TODO: to add way to display all the parking spot information
            infoWindow: InfoWindow(
            title: parkingSpotsList[i].name
          )
        )
      );
    }

    return Set<Marker>.of(_markers);
  }
}