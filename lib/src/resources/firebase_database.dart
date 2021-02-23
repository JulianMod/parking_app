import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_app/src/bloc/parking_spots_bloc.dart';
import 'package:parking_app/src/models/parking_spot.dart';

class FirebaseProvider {

  final firebaseData = FirebaseFirestore.instance.collection('parkingSpots');
  final parkingSpot = ParkingSpot();

  void addNewParkingSpot(ParkingSpot parkingSpot) {
    firebaseData.add(parkingSpot.toMap(parkingSpot));
    bloc.addParkingSpot(parkingSpot);
  }

  void getParkingSpots() {
    firebaseData.get().then((snapshot) {
      snapshot.docs.forEach((element) {
        var _newParkingSpot = parkingSpot.fromMap(element);
        bloc.addParkingSpot(_newParkingSpot);
      });
    });
  }

}