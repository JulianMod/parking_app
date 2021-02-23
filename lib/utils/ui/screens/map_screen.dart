import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_app/src/bloc/parking_spots_bloc.dart';
import 'package:parking_app/src/models/parking_spot.dart';
import 'package:parking_app/src/resources/firebase_database.dart';
import 'package:parking_app/utils/services/location.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  ParkingSpot parkingSpot = ParkingSpot();

  //this could be last location saved
  final LatLng _initialCameraPosition = LatLng(45.521563, -122.677433);

  GoogleMapController mapController;

  Future<void> getLocation() async {
    Location location = Location();
    //the location is requested and after it is received the view on the map is automatically updated
    await location.getCurrentLocation().then((value) {
      CameraPosition _currentLocation = CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 15.0);
      mapController.animateCamera(CameraUpdate.newCameraPosition(_currentLocation));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    getLocation();
  }

  @override
  void initState() {
    FirebaseProvider().getParkingSpots();
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking App'),
      ),
      body: StreamBuilder(
        stream: bloc.getStream,
        initialData: bloc.parkingSpotsList,
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialCameraPosition,
              zoom: 11.0,
            ),
            markers: parkingSpot.getParkingMarkers(snapshot.data),
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/parking_screen');
        },
      ),
    );
  }
}

