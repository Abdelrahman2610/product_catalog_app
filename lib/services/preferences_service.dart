import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_preferences.dart';

/// Service to handle local storage of user preferences
/// Uses SharedPreferences for persistent storage
class PreferencesService {
  static const String _prefsKey = 'app_preferences';
  SharedPreferences? _prefs;

  /// Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Load preferences from storage
  Future<AppPreferences> loadPreferences() async {
    if (_prefs == null) await init();

    final String? jsonString = _prefs?.getString(_prefsKey);
    if (jsonString == null) {
      return const AppPreferences();
    }

    try {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return AppPreferences.fromJson(json);
    } catch (e) {
      // If parsing fails, return default preferences
      return const AppPreferences();
    }
  }

  /// Save preferences to storage
  Future<void> savePreferences(AppPreferences preferences) async {
    if (_prefs == null) await init();

    final String jsonString = jsonEncode(preferences.toJson());
    await _prefs?.setString(_prefsKey, jsonString);
  }

  /// Toggle favorite status for a product
  Future<AppPreferences> toggleFavorite(
    AppPreferences current,
    String productId,
  ) async {
    final Set<String> newFavorites = Set.from(current.favoriteProductIds);

    if (newFavorites.contains(productId)) {
      newFavorites.remove(productId);
    } else {
      newFavorites.add(productId);
    }

    final updated = current.copyWith(favoriteProductIds: newFavorites);
    await savePreferences(updated);
    return updated;
  }

  /// Update sort preference
  Future<AppPreferences> updateSortOption(
    AppPreferences current,
    String sortOption,
  ) async {
    final updated = current.copyWith(lastSortOption: sortOption);
    await savePreferences(updated);
    return updated;
  }

  /// Toggle view mode (list/grid)
  Future<AppPreferences> toggleViewMode(AppPreferences current) async {
    final updated = current.copyWith(isGridView: !current.isGridView);
    await savePreferences(updated);
    return updated;
  }

  /// Update theme mode
  Future<AppPreferences> updateThemeMode(
    AppPreferences current,
    String themeMode,
  ) async {
    final updated = current.copyWith(themeMode: themeMode);
    await savePreferences(updated);
    return updated;
  }

  /// Clear all preferences
  Future<void> clearPreferences() async {
    if (_prefs == null) await init();
    await _prefs?.remove(_prefsKey);
  }
}
