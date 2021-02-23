import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

//List<ParkingSpot> parkingSpotsList = [];

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

  Map<String, dynamic> toMap (ParkingSpot parkingSpot){
    return {
      'name': parkingSpot.name,
      'description': parkingSpot.description,
      'latitude': parkingSpot.latitude,
      'longitude': parkingSpot.longitude,
      'rating': parkingSpot.rating
    };
  }

  ParkingSpot fromMap (QueryDocumentSnapshot snapshot){
    return ParkingSpot(
        name: snapshot['name'],
        description: snapshot['description'],
        latitude: snapshot['latitude'],
        longitude: snapshot['longitude'],
        rating: snapshot['rating']
    );
  }

  Set<Marker> getParkingMarkers(List<ParkingSpot> parkingSpotList){
    List<Marker> _markers = <Marker>[];

    for (int i = 0; i < parkingSpotList.length; i++){
      _markers.add(
          Marker(
              markerId: MarkerId(uuid.v1()),
              position: LatLng(parkingSpotList[i].latitude, parkingSpotList[i].longitude),
              //TODO: to add way to display all the parking spot information
              infoWindow: InfoWindow(
                  title: parkingSpotList[i].name
              )
          )
      );
    }

    return Set<Marker>.of(_markers);
  }
}