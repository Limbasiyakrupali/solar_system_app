import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  final Set<String> favoritePositions = {};

  void toggleFavorite(Map<String, dynamic> planet) {
    final position = planet['position'] as String;
    if (favoritePositions.contains(position)) {
      favoritePositions.remove(position);
    } else {
      favoritePositions.add(position);
    }
    notifyListeners();
  }

  bool isFavorite(Map<String, dynamic> planet) {
    final position = planet['position'] as String;
    return favoritePositions.contains(position);
  }

  List<Map<String, dynamic>> getFavoritePlanets(
      List<Map<String, dynamic>> allPlanets) {
    return allPlanets
        .where((planet) => favoritePositions.contains(planet['position']))
        .toList();
  }
}
