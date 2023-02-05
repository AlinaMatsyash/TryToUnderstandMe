import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.teal,
    primaryColorDark: Colors.teal,
    scaffoldBackgroundColor: Colors.white,
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
    iconTheme: const IconThemeData(
      color: Colors.teal,
      size: 45,
    ),
    sliderTheme: SliderThemeData(
        activeTrackColor: Colors.teal,
        inactiveTrackColor: Colors.teal[50],
        thumbColor: Colors.teal),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.teal,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.teal,
        size: 20,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.teal,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.teal,
    primaryColorDark: Colors.teal,
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    sliderTheme: SliderThemeData(
        activeTrackColor: Colors.teal,
        inactiveTrackColor: Colors.teal[50],
        thumbColor: Colors.teal),
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.black),
    iconTheme: const IconThemeData(
      color: Colors.teal,
      size: 45,
    ),
    listTileTheme: const ListTileThemeData(tileColor: Colors.black),
    appBarTheme: const AppBarTheme(
      color: Colors.teal,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.teal,
        size: 20,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.teal,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Colors.teal,
      elevation: 3,
    ),
  );
}
