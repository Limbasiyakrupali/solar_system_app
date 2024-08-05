import 'package:flutter/material.dart';
import 'package:planet_animation_app/view/homepage.dart';
import 'package:planet_animation_app/view/infopage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool introscreenvisit = prefs.getBool("introscreenvisit") ?? false;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const HomePage(),
      'intro': (context) => const InFoPage(),
    },
  ));
}
