import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parking_app/src/models/parking_spot.dart';
import 'package:parking_app/src/resources/firebase_database.dart';
import 'package:parking_app/utils/helpers/constants.dart';
import 'package:parking_app/utils/helpers/parser.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ParkingScreen extends StatefulWidget {
  @override
  _ParkingScreenState createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  TextEditingController _longitudeController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _parkingName = TextEditingController();
  TextEditingController _parkingDescription = TextEditingController();
  double _rating = 0;

  String validateLatitude(String value) {
    if (value.isNotEmpty) {
      double validatorValue = stringToDouble(value);
      if (validatorValue < -90 || validatorValue > 90) {
        return 'Please enter valid latitude';
      }
    }
    return null;
  }

  String validateLongitude(String value){
    if (value.isNotEmpty) {
      double validatorValue = stringToDouble(value);
      if (validatorValue < -180 || validatorValue > 180) {
        return 'Please enter valid latitude';
      }
    }
    return null;
  }

  Future<void> _showWarningDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text(
              'Input latitude and longitude before creating a parking spot'),
          actions: <Widget>[
            TextButton(
              child: Text('Understood'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _sendDataToFirebase() {
    //all fields except for lat and long can be empty for the definition of the parking spot
    if (_latitudeController.text.isNotEmpty && _longitudeController.text.isNotEmpty) {
      double _latitude = stringToDouble(_latitudeController.text);
      double _longitude = stringToDouble(_longitudeController.text);
      ParkingSpot _newParkingSpot = ParkingSpot(
          name: _parkingName.text,
          description: _parkingDescription.text,
          latitude: _latitude,
          longitude: _longitude,
          rating: _rating
      );
      FirebaseProvider().addNewParkingSpot(_newParkingSpot);
      Navigator.pop(context);
    }
    else {
      _showWarningDialog();
    }
  }

  @override
  void dispose() {
    _longitudeController.dispose();
    _latitudeController.dispose();
    _parkingName.dispose();
    _parkingDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking App'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(kParkingScreenPadding),
        children: [
          TextField(
            controller: _parkingName,
            decoration: InputDecoration(
                labelText: 'Parking name',
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: kParkingScreenVerticalSpacer),
          TextField(
            controller: _parkingDescription,
            decoration: InputDecoration(
                labelText: 'Parking description',
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: kParkingScreenVerticalSpacer),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  controller: _latitudeController,
                  validator: validateLatitude,
                  inputFormatters: kCoordinateFormat,
                  keyboardType: kCoordinateKeyboard,
                  decoration: InputDecoration(
                      labelText: 'Latitude',
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              SizedBox(width: kParkingScreenHorizontalSpacer),
              Expanded(
                child:
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  controller: _longitudeController,
                  validator: validateLongitude,
                  inputFormatters: kCoordinateFormat,
                  keyboardType: kCoordinateKeyboard,
                  decoration: InputDecoration(
                      labelText: 'Longitude',
                      border: OutlineInputBorder()
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: kParkingScreenVerticalSpacer),
          Center(
            child: SmoothStarRating(
              size: kRatingSize,
              //allowHalfRating: false,
              onRated: (value) {
                _rating = value;
              },
            ),
          ),
          SizedBox(height: kParkingScreenBottomSpacer),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: kParkingScreenSaveButtonWidth,
              height: kParkingScreenSaveButtonHeight,
              child: ElevatedButton(
                onPressed: () {
                  _sendDataToFirebase();
                },
                child: Text(
                    'Save the spot'
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
