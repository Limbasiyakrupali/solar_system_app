import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/favorite_provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final allPlanets = ModalRoute.of(context)!.settings.arguments
        as List<Map<String, dynamic>>;
    final favoritePlanets = favoriteProvider.getFavoritePlanets(allPlanets);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: favoritePlanets.isEmpty
          ? Center(
              child: Text('No favorites added',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
          : SingleChildScrollView(
              child: Column(
                children: favoritePlanets.map((planet) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Image.network(
                        planet['image'],
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        planet['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Text(
                        'Position: ${planet['position']}',
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          'detail_page',
                          arguments: planet,
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
