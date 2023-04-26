import 'package:flutter/material.dart';
import 'package:web_frontend/palette.dart';


class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width <= 700 ?
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Palette.nestBlue,
          elevation: 8,
          padding: const EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        onPressed: press,
        child: Row(
          children: [
            Image.asset(icon, color: Palette.nestBlue, width: MediaQuery.of(context).size.width <= 700 ? 20 : 35,),
            const SizedBox(width: 20),
            Expanded(child: Text(text, style: TextStyle(fontFamily: "SF-Pro-Text-Regular",
              fontSize: MediaQuery.of(context).size.width <= 700 ? 15 : 20,),)),
            Icon(Icons.arrow_forward_ios,size: MediaQuery.of(context).size.width <= 700 ? 20 : 35,),
          ],
        ),
      ),
    ) : SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Palette.nestBlue,
            elevation: 8,
            padding: const EdgeInsets.all(20),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          onPressed: press,
          child: Row(
            children: [
              Image.asset(icon, color: Palette.nestBlue, width: MediaQuery.of(context).size.width <= 700 ? 25 : 35,),
              const SizedBox(width: 20),
              Expanded(child: Text(text, style: const TextStyle(fontFamily: "SF-Pro-Text-Regular", fontSize: 20),)),
              Icon(Icons.arrow_forward_ios,size: MediaQuery.of(context).size.width <= 700 ? 20 : 35,),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width <= 700 ?
    GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Image.asset(icon, color: Palette.nestBlue, width: 30,),
            const SizedBox(width: 20),
            Expanded(child: Text(text, style: const TextStyle(
                fontSize: 16,
                fontFamily: "SF-Pro-Text-Regular"),)),
          ],
        ),
      ),
    ) : SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Image.asset(icon, color: Palette.nestBlue, width: 35,),
            const SizedBox(width: 25),
            Expanded(child: Text(text, style: const TextStyle(
                fontSize: 18, fontFamily: "SF-Pro-Text-Regular"),)),
          ],
        ),
      ),
    );
  }
}