import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_frontend/models/models.dart';
import 'package:web_frontend/services/services.dart';
import 'package:web_frontend/screens/screens.dart';

import '../palette.dart';

class ManageShop extends StatefulWidget {
  const ManageShop({Key? key}) : super(key: key);

  @override
  State<ManageShop> createState() => _ManageShopState();
}

class _ManageShopState extends State<ManageShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Palette.nestBlue),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Shop Management',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black),),
      ),
    );
  }
}
