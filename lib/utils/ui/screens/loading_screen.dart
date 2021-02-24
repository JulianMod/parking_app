import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_app/src/resources/firebase_database.dart';
import 'package:parking_app/utils/services/location.dart';

LatLng currentLocation;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double latitude;
  double longitude;

  @override
  void initState() {
    FirebaseProvider().getParkingSpots();
    getLocation();
    super.initState();
  }

  Future<void> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation().then((value) {
     currentLocation = LatLng(location.latitude, location.longitude);
      Navigator.pushNamed(context, '/map_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator()
      ),
    );
  }
}