import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:web_frontend/models/models.dart';
import 'package:web_frontend/services/services.dart';
import 'package:web_frontend/screens/screens.dart';
import '../palette.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Palette.nestBlue),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Service Appointments',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black),),
      ),
      floatingActionButton: SpeedDial(
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            child: const Icon(Icons.car_repair_rounded),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            label: 'Brake fluid exchange',
            onPressed: () {
              setState(() {
                //_text = 'You pressed "Let\'s go for a run!"';
              });
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.car_repair_rounded),
            foregroundColor: Colors.black,
            backgroundColor: Colors.orange,
            label: 'Spark plug replacement',
            onPressed: () {
              setState(() {
                //_text = 'You pressed "Let\'s go for a walk!"';
              });
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.car_repair_rounded),
            foregroundColor: Colors.white,
            backgroundColor: Colors.yellow,
            label: 'Transmission fluid inspection',
            onPressed: () {
              setState(() {
                //_text = 'You pressed "Let\'s go cycling!"';
              });
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.car_repair_rounded),
            foregroundColor: Colors.black,
            backgroundColor: Colors.purple,
            label: 'Tire replacement',
            onPressed: () {
              setState(() {
                //_text = 'You pressed "Let\'s go cycling!"';
              });
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.car_repair_rounded),
            foregroundColor: Colors.white,
            backgroundColor: Colors.indigo,
            label: 'Timing belt replacement',
            onPressed: () {
              setState(() {
                //_text = 'You pressed "Let\'s go cycling!"';
              });
            },
          ),
        ],
        closedForegroundColor: Colors.black,
        openForegroundColor: Colors.white,
        closedBackgroundColor: Colors.white,
        openBackgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
