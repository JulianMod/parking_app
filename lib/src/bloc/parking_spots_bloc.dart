import 'dart:async';

import 'package:parking_app/src/models/parking_spot.dart';

class ParkingSpotsBloc {
  final parkingSpotStreamController = StreamController.broadcast();

  Stream get getStream => parkingSpotStreamController.stream;

  final List<ParkingSpot> parkingSpotsList = [];

  void addParkingSpot(ParkingSpot spot) {
    parkingSpotsList.add(spot);
    parkingSpotStreamController.sink.add(parkingSpotsList);
  }

  void dispose() {
    parkingSpotStreamController.close();
  }
}

final bloc = ParkingSpotsBloc();