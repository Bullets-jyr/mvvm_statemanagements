import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/movies_model.dart';

class FavoritesProvider with ChangeNotifier {
  final List<MovieModel> _favoritesList = [];

  List<MovieModel> get favoritesList => _favoritesList;

  final favskey = "favsKey";

  bool isFavorite(MovieModel movieModel) {
    // 그리고 여기에서 실제로 동일한 것이 있는지 확인합니다.
    return _favoritesList.any(
      (movie) => movie.id == movieModel.id,
    );
  }

  Future<void> addOrRemoveFromFavorites(MovieModel movieModel) async {
    if (isFavorite(movieModel)) {
      _favoritesList.removeWhere((movie) => movie.id == movieModel.id);
    } else {
      _favoritesList.add(movieModel);
    }
    await saveFavorites();
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    // 요청을 보낼 때 이를 인코딩하고 읽을 때 디코딩합니다.
    final stringList =
        _favoritesList.map((movie) => json.encode(movie.toJson())).toList();
    prefs.setStringList(favskey, stringList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(favskey) ?? [];
    _favoritesList.clear();
    _favoritesList.addAll(
        stringList.map((movie) => MovieModel.fromJson(json.decode(movie))));
    notifyListeners();
  }

  void clearAllFavs() {
    _favoritesList.clear();
    notifyListeners();
    saveFavorites();
  }
}
