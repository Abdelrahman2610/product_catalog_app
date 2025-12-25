import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';
import '../models/app_preferences.dart';
import '../services/preferences_service.dart';
import '../widgets/product_card.dart';
import '../widgets/product_grid_item.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/filter_chip_widget.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/advanced_search_sheet.dart';
import 'detail_screen.dart';
import 'favorites_screen.dart';

/// Ultimate enhanced home screen with all features
class HomeScreen extends StatefulWidget {
  final PreferencesService preferencesService;
  final AppPreferences initialPreferences;
  final Function(AppPreferences) onPreferencesChanged;

  const HomeScreen({
    super.key,
    required this.preferencesService,
    required this.initialPreferences,
    required this.onPreferencesChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State variables
  final TextEditingController _searchController = TextEditingController();
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  AppPreferences _preferences = const AppPreferences();

  // Filter states
  String _selectedCategory = 'All';
  Set<String> _advancedSelectedCategories = {};
  RangeValues _priceRange = const RangeValues(0, 400);
  double _minRating = 0;
  bool _isAdvancedSearchActive = false;

  @override
  void initState() {
    super.initState();
    _preferences = widget.initialPreferences;
    _loadProducts();

    // Calculate price range from products
    if (_products.isNotEmpty) {
      final prices = _products.map((p) => p.price).toList();
      _priceRange = RangeValues(
        prices.reduce((a, b) => a < b ? a : b),
        prices.reduce((a, b) => a > b ? a : b),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Load products and apply saved sort preference
  void _loadProducts() {
    setState(() {
      _products = List.from(DummyData.products);
      _filterAndSortProducts();
    });
  }

  /// Get unique categories
  List<String> _getCategories() {
    final categories = _products.map((p) => p.category).toSet().toList();
    categories.sort();
    return ['All', ...categories];
  }

  /// Get price range from products
  RangeValues _getPriceRange() {
    if (_products.isEmpty) return const RangeValues(0, 400);
    final prices = _products.map((p) => p.price).toList();
    return RangeValues(
      prices.reduce((a, b) => a < b ? a : b),
      prices.reduce((a, b) => a > b ? a : b),
    );
  }

  /// Filter and sort products
  void _filterAndSortProducts() {
    List<Product> filtered = _products;

    // Apply search filter
    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((product) {
        return product.name.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ) ||
            product.description.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            );
      }).toList();
    }

    // Apply category filter (simple or advanced)
    if (_isAdvancedSearchActive && _advancedSelectedCategories.isNotEmpty) {
      filtered = filtered.where((product) {
        return _advancedSelectedCategories.contains(product.category);
      }).toList();
    } else if (_selectedCategory != 'All') {
      filtered = filtered.where((product) {
        return product.category == _selectedCategory;
      }).toList();
    }

    // Apply price range filter
    filtered = filtered.where((product) {
      return product.price >= _priceRange.start &&
          product.price <= _priceRange.end;
    }).toList();

    // Apply minimum rating filter
    if (_minRating > 0) {
      filtered = filtered.where((product) {
        return product.rating >= _minRating;
      }).toList();
    }

    // Apply sorting
    switch (_preferences.lastSortOption) {
      case 'Name':
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Price (Low-High)':
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price (High-Low)':
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Rating':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }

    setState(() {
      _filteredProducts = filtered;
    });
  }

  /// Handle search changes
  void _onSearchChanged(String value) {
    _filterAndSortProducts();
  }

  /// Clear search
  void _clearSearch() {
    _searchController.clear();
    _filterAndSortProducts();
  }

  /// Handle category selection
  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _isAdvancedSearchActive = false;
      _advancedSelectedCategories.clear();
    });
    _filterAndSortProducts();
  }

  /// Show sort options
  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  'Sort By',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Divider(),
              _buildSortOption('Name'),
              _buildSortOption('Price (Low-High)'),
              _buildSortOption('Price (High-Low)'),
              _buildSortOption('Rating'),
            ],
          ),
        );
      },
    );
  }

  /// Build sort option item
  Widget _buildSortOption(String option) {
    final isSelected = _preferences.lastSortOption == option;
    return ListTile(
      leading: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: isSelected ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(
        option,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      onTap: () async {
        final updated = await widget.preferencesService.updateSortOption(
          _preferences,
          option,
        );
        setState(() {
          _preferences = updated;
        });
        widget.onPreferencesChanged(updated);
        _filterAndSortProducts();
        Navigator.pop(context);
      },
    );
  }

  /// Show advanced search sheet
  void _showAdvancedSearch() {
    final priceRange = _getPriceRange();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AdvancedSearchSheet(
          categories: _getCategories(),
          selectedCategories: _advancedSelectedCategories,
          priceRange: _priceRange,
          minPrice: priceRange.start,
          maxPrice: priceRange.end,
          minRating: _minRating,
          onApply: (categories, priceRange, minRating) {
            setState(() {
              _advancedSelectedCategories = categories;
              _priceRange = priceRange;
              _minRating = minRating;
              _isAdvancedSearchActive =
                  categories.isNotEmpty ||
                  priceRange.start != _getPriceRange().start ||
                  priceRange.end != _getPriceRange().end ||
                  minRating > 0;
              _selectedCategory = 'All';
            });
            _filterAndSortProducts();
          },
        );
      },
    );
  }

  /// Toggle favorite
  Future<void> _toggleFavorite(String productId) async {
    final updated = await widget.preferencesService.toggleFavorite(
      _preferences,
      productId,
    );
    setState(() {
      _preferences = updated;
    });
    widget.onPreferencesChanged(updated); // Show feedback
    final isFavorited = updated.favoriteProductIds.contains(productId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorited ? 'Added to favorites' : 'Removed from favorites',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  /// Toggle view mode
  Future<void> _toggleViewMode() async {
    final updated = await widget.preferencesService.toggleViewMode(
      _preferences,
    );
    setState(() {
      _preferences = updated;
    });
    widget.onPreferencesChanged(updated);
  }

  /// Toggle theme
  Future<void> _toggleTheme() async {
    final currentTheme = _preferences.themeMode;
    String newTheme;
    if (currentTheme == 'light') {
      newTheme = 'dark';
    } else if (currentTheme == 'dark') {
      newTheme = 'system';
    } else {
      newTheme = 'light';
    }
    final updated = await widget.preferencesService.updateThemeMode(
      _preferences,
      newTheme,
    );
    setState(() {
      _preferences = updated;
    });
    widget.onPreferencesChanged(updated);
  }

  /// Pull to refresh
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    _loadProducts();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Products refreshed!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  /// Reset all filters
  void _resetFilters() {
    final priceRange = _getPriceRange();
    setState(() {
      _selectedCategory = 'All';
      _advancedSelectedCategories.clear();
      _priceRange = priceRange;
      _minRating = 0;
      _isAdvancedSearchActive = false;
      _searchController.clear();
    });
    _filterAndSortProducts();
  }

  /// Navigate to detail screen
  void _navigateToDetail(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          product: product,
          isFavorite: _preferences.favoriteProductIds.contains(product.id),
          onFavoriteToggle: () => _toggleFavorite(product.id),
        ),
      ),
    );
  }

  /// Navigate to favorites screen
  void _navigateToFavorites() {
    final favoriteProducts = _products.where((product) {
      return _preferences.favoriteProductIds.contains(product.id);
    }).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesScreen(
          favoriteProducts: favoriteProducts,
          isGridView: _preferences.isGridView,
          onFavoriteToggle: _toggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = _getCategories();
    final favoriteCount = _preferences.favoriteProductIds.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
        actions: [
          // Advanced search button
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.filter_list),
                if (_isAdvancedSearchActive)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            tooltip: 'Advanced Search',
            onPressed: _showAdvancedSearch,
          ),
          // Sort button
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort',
            onPressed: _showSortOptions,
          ),
          // View mode toggle
          IconButton(
            icon: Icon(
              _preferences.isGridView ? Icons.view_list : Icons.grid_view,
            ),
            tooltip: 'Toggle view',
            onPressed: _toggleViewMode,
          ),
          // Favorites button
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.favorite),
                if (favoriteCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        favoriteCount > 9 ? '9+' : '$favoriteCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            tooltip: 'Favorites',
            onPressed: _navigateToFavorites,
          ),
          // Theme toggle
          IconButton(
            icon: Icon(
              _preferences.themeMode == 'dark'
                  ? Icons.light_mode
                  : _preferences.themeMode == 'light'
                  ? Icons.dark_mode
                  : Icons.brightness_auto,
            ),
            tooltip: 'Toggle theme',
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          SearchBarWidget(
            controller: _searchController,
            onChanged: _onSearchChanged,
            onClear: _clearSearch,
          ),

          // Category filter chips
          if (!_isAdvancedSearchActive)
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return FilterChipWidget(
                    label: category,
                    isSelected: _selectedCategory == category,
                    onSelected: () => _onCategorySelected(category),
                  );
                },
              ),
            ),

          // Results header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).cardTheme.color,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredProducts.length} products',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (_selectedCategory != 'All' ||
                    _searchController.text.isNotEmpty ||
                    _isAdvancedSearchActive)
                  TextButton.icon(
                    onPressed: _resetFilters,
                    icon: const Icon(Icons.clear, size: 16),
                    label: const Text('Clear filters'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
              ],
            ),
          ),

          // Product list/grid with pull-to-refresh
          Expanded(
            child: _filteredProducts.isEmpty
                ? EmptyStateWidget(
                    message: 'No products found',
                    onActionPressed: _resetFilters,
                    actionLabel: 'Clear Filters',
                  )
                : RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: _preferences.isGridView
                        ? GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                            itemCount: _filteredProducts.length,
                            itemBuilder: (context, index) {
                              final product = _filteredProducts[index];
                              return ProductGridItem(
                                product: product,
                                onTap: () =>
                                    _navigateToDetail(context, product),
                                isFavorite: _preferences.favoriteProductIds
                                    .contains(product.id),
                                onFavoriteToggle: () =>
                                    _toggleFavorite(product.id),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: _filteredProducts.length,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemBuilder: (context, index) {
                              final product = _filteredProducts[index];
                              return ProductCard(
                                product: product,
                                onTap: () =>
                                    _navigateToDetail(context, product),
                                isFavorite: _preferences.favoriteProductIds
                                    .contains(product.id),
                                onFavoriteToggle: () =>
                                    _toggleFavorite(product.id),
                              );
                            },
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
