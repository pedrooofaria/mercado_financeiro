import 'package:flutter/material.dart';
import 'package:mercadofinanceiro/home_page.dart';


void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))
        ),
        hintColor: Colors.green,
        primaryColor: Colors.white
    ),
  ));
}