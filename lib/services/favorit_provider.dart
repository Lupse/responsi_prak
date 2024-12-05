import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  List<String> _favorites = [];

  List<String> get favorites => _favorites;

  bool isFavorite(String item) {
    return _favorites.contains(item);
  }

  void addFavorite(String item) async {
    if (!_favorites.contains(item)) {
      _favorites.add(item);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList('favorites', _favorites);
    }
  }

  void removeFavorite(String item) async {
    _favorites.remove(item);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', _favorites);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList('favorites') ?? [];
    notifyListeners();
  }
}
