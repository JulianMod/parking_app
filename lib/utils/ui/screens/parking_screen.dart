import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parking_app/src/models/parking_spot.dart';
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

  Future<void> _showWarningDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('Input latitude and longitude before creating a parking spot'),
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
      appBar:AppBar(
        title: Text('Parking App'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          TextField(
            controller: _parkingName,
            decoration: InputDecoration(
                labelText: 'Parking name',
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: _parkingDescription,
            decoration: InputDecoration(
                labelText: 'Parking description',
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  controller: _latitudeController,
                  validator: (value) {
                    if(value.isNotEmpty){
                      double validatorValue = double.parse(value);
                      if (validatorValue<-90 || validatorValue > 90){
                        return 'Please enter valid latitude';
                      }
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                      labelText: 'Latitude',
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child:
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  controller: _longitudeController,
                  validator: (value) {
                    if(value.isNotEmpty){
                      double validatorValue = double.parse(value);
                      if (validatorValue<-180 || validatorValue > 180){
                        return 'Please enter valid latitude';
                      }
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                      labelText: 'Longitude',
                      border: OutlineInputBorder()
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Center(
            child: SmoothStarRating(
              size: 50.0,
              //allowHalfRating: false,
              onRated: (value) {
                _rating = value;
              },
            ),
          ),
          SizedBox(height: 40),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  //all fields except for lat and long can be empty for the definition of the parking spot
                  if(_latitudeController.text.isNotEmpty && _longitudeController.text.isNotEmpty){
                    double _latitude = double.parse(_latitudeController.text);
                    double _longitude = double.parse(_longitudeController.text);

                    /*ParkingSpot newParkingSpot = ParkingSpot(
                        name: _parkingName.text,
                        description: _parkingDescription.text,
                        latitude: _latitude,
                        longitude: _longitude,
                        rating: _rating);
                    parkingSpotsList.add(newParkingSpot);*/

                    FirebaseFirestore.instance.
                    collection('parkingSpots')
                        .add({
                      'name': _parkingName.text,
                      'description': _parkingDescription.text,
                      'latitude': _latitude,
                      'longitude': _longitude,
                      'rating': _rating
                    });

                    Navigator.pop(context);
                  }
                  else {
                    _showWarningDialog();
                  }
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
