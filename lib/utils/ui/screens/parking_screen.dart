import 'package:flutter/material.dart';
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
                child: TextField(
                  controller: _longitudeController,
                  decoration: InputDecoration(
                      labelText: 'Longitude',
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _latitudeController,
                  decoration: InputDecoration(
                      labelText: 'Latitude',
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
