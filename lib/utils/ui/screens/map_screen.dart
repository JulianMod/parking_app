import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_app/src/bloc/parking_spots_bloc.dart';
import 'package:parking_app/src/models/parking_spot.dart';
import 'package:parking_app/src/resources/firebase_database.dart';
import 'package:parking_app/utils/helpers/constants.dart';
import 'package:parking_app/utils/services/location.dart';

///screen displaying map and parking locations
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //class initialization
  ParkingSpot parkingSpot = ParkingSpot();
  //initial map position
  final _initialCameraPosition = CameraPosition(
      target: LatLng(45.521563, -122.677433),
      zoom: 11.0
  );
  //map controller
  GoogleMapController mapController;
  //method to move map to current user location
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
  //assign map controller when map is created and receive the current user location
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    getLocation();
  }

  //receive the data from Firebase
  @override
  void initState() {
    FirebaseProvider().getParkingSpots();
    super.initState();
  }
  //dispose the controller
  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppName),
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
              initialCameraPosition: _initialCameraPosition,
              //draw parking markers on the map
              markers: parkingSpot.getParkingMarkers(snapshot.data, context),
            );
          }
      ),
      //button to move to the parking spot details screen
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

