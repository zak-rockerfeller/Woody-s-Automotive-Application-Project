import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:web_frontend/screens/screens.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ZoomDrawerController z = ZoomDrawerController();
  final TrackingScrollController _trackingScrollController = TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Mboka'),
    );
  }
}
