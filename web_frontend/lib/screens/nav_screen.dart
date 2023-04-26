import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_frontend/models/models.dart';
import 'package:web_frontend/services/services.dart';
import 'package:web_frontend/screens/screens.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../palette.dart';


class NavScreen extends StatefulWidget {
  int selectedIndex;
  NavScreen({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  static final List<Widget> _widgetOptions = <Widget>[
    const BookingScreen(),
    const ManageShop(),
    const TransactionScreen(),
    const ReportScreen(),

  ];


  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: _widgetOptions.elementAt(widget.selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.red,
              hoverColor: Palette.nestBlue,
              gap: 5,
              curve: Curves.linearToEaseOut,
              activeColor: Palette.nestBlue,
              iconSize: MediaQuery.of(context).size.width <= 500 ? 23 : 30,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              duration: const Duration(milliseconds: 400),
              //tabBackgroundColor: Colors.grey[100],
              color: Palette.nestBlue,
              tabs: [
                GButton(
                  icon: BootstrapIcons.book,
                  text: 'Booking',
                  textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width <= 500 ? 14 : 18, overflow: TextOverflow.fade, fontFamily: "SF-Pro-Text-Bold", color: Palette.nestBlue),
                ),
                GButton(
                  icon: BootstrapIcons.shop,
                  text: 'Shop',
                  textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width <= 500 ? 14 : 18, overflow: TextOverflow.fade, fontFamily: "SF-Pro-Text-Bold", color: Palette.nestBlue),
                ),
                GButton(
                  icon: BootstrapIcons.cash_stack,
                  text: 'Transaction',
                  textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width <= 500 ? 14 : 18, overflow: TextOverflow.fade, fontFamily: "SF-Pro-Text-Bold", color: Palette.nestBlue),
                ),
                GButton(
                  icon: BootstrapIcons.graph_down,
                  text: 'Reports',
                  textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width <= 500 ? 14 : 18, overflow: TextOverflow.fade, fontFamily: "SF-Pro-Text-Bold", color: Palette.nestBlue),
                ),

              ],
              selectedIndex: widget.selectedIndex,
              onTabChange: (index) {
                setState(() {
                  widget.selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}


