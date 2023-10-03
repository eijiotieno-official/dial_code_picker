import 'package:flutter/material.dart';

import 'country.dart';
import 'picker_screen.dart';

class DialCodePicker {
  //Navigates to the PickerScreen and returns the country picked or null if no country is selected
  //Pass custom colors for your PickerScreen
  static Future<Country?> pickCountry({
    required BuildContext context,
    required Color accentColor,
    required Color backgroundColor,
    required Color textColor,
    required double fontSize,
  }) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PickerScreen(
            accentColor: accentColor,
            backgroundColor: backgroundColor,
            textColor: textColor,
            fontSize: fontSize,
          );
        },
      ),
    );
  }
}
