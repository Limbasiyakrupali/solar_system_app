import 'package:flutter/material.dart';
import 'package:planet_animation_app/provider/favorite_provider.dart';
import 'package:planet_animation_app/provider/theme_provider.dart';
import 'package:planet_animation_app/view/detailpage.dart';
import 'package:planet_animation_app/view/favouritepage.dart';
import 'package:planet_animation_app/view/homepage.dart';
import 'package:planet_animation_app/view/spashscrren.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider(create: (context) => FavoriteProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: (Provider.of<ThemeProvider>(context).istapped)
          ? ThemeMode.dark
          : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        'home': (context) => HomePage(),
        'detail_page': (context) => DetailPage(),
        'favourite_page': (context) => FavouritePage(),
      },
    );
  }
}
