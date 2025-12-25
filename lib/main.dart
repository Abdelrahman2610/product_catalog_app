import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';
import 'services/preferences_service.dart';
import 'models/app_preferences.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize preferences service
  final preferencesService = PreferencesService();
  await preferencesService.init();

  runApp(ProductCatalogApp(preferencesService: preferencesService));
}

/// Main application widget with preferences support
class ProductCatalogApp extends StatefulWidget {
  final PreferencesService preferencesService;

  const ProductCatalogApp({super.key, required this.preferencesService});

  @override
  State<ProductCatalogApp> createState() => _ProductCatalogAppState();
}

class _ProductCatalogAppState extends State<ProductCatalogApp> {
  AppPreferences _preferences = const AppPreferences();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  /// Load saved preferences
  Future<void> _loadPreferences() async {
    final prefs = await widget.preferencesService.loadPreferences();
    setState(() {
      _preferences = prefs;
      _isLoading = false;
    });
  }

  /// Update preferences
  void _updatePreferences(AppPreferences newPreferences) {
    setState(() {
      _preferences = newPreferences;
    });
  }

  /// Get theme mode from preferences
  ThemeMode _getThemeMode() {
    switch (_preferences.themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return MaterialApp(
      title: 'Product Catalog',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _getThemeMode(),
      home: HomeScreen(
        preferencesService: widget.preferencesService,
        initialPreferences: _preferences,
        onPreferencesChanged: _updatePreferences,
      ),
    );
  }
}
