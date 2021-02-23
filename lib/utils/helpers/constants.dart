import 'package:flutter/services.dart';

List<TextInputFormatter> kCoordinateFormat = [
  FilteringTextInputFormatter.allow(
      RegExp(r'(^-?\d*\.?\d*)'))
];

const TextInputType kCoordinateKeyboard = TextInputType.numberWithOptions(decimal: true);

const double kParkingScreenVerticalSpacer = 15.0;
const double kParkingScreenHorizontalSpacer = 10.0;
const double kRatingSize = 50.0;
const double kParkingScreenBottomSpacer = 40.0;
const double kParkingScreenSaveButtonWidth = 150.0;
const double kParkingScreenSaveButtonHeight = 40.0;
const double kParkingScreenPadding = 8.0;