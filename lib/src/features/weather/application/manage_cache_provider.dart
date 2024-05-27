import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoriteCitiesProvider =
    StateNotifierProvider<FavoriteCitiesNotifier, List<String>>(
  (ref) => FavoriteCitiesNotifier(),
);

class FavoriteCitiesNotifier extends StateNotifier<List<String>> {
  FavoriteCitiesNotifier()
      : super(['Melbourne', 'Monte Carlo', 'Sao Paulo', 'Silverstone']) {
    _loadFavoriteCities();
  }

  Future<void> _loadFavoriteCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedCities = prefs.getStringList('favoriteCities');
    state = storedCities ??
        ['Melbourne', 'Monte Carlo', 'Sao Paulo', 'Silverstone'];
  }

  Future<void> _saveFavoriteCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteCities', state);
  }

  void addFavoriteCity(String city) {
    state = [...state, city];
    _saveFavoriteCities();
  }

  void deleteFavoriteCity(int index) {
    state = [...state.sublist(0, index), ...state.sublist(index + 1)];
    _saveFavoriteCities();
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final city = state.removeAt(oldIndex);
    state = [...state.sublist(0, newIndex), city, ...state.sublist(newIndex)];
    _saveFavoriteCities();
  }
}
