import 'package:flutter/material.dart';
import 'package:parking_app/config/routes/routes.dart';

class ParkingApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}