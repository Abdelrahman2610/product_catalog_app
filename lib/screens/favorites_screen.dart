import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/product_grid_item.dart';
import '../widgets/empty_state_widget.dart';
import 'detail_screen.dart';

/// Favorites screen displaying user's favorite products
class FavoritesScreen extends StatelessWidget {
  final List<Product> favoriteProducts;
  final bool isGridView;
  final Function(String) onFavoriteToggle;

  const FavoritesScreen({
    super.key,
    required this.favoriteProducts,
    required this.isGridView,
    required this.onFavoriteToggle,
  });

  void _navigateToDetail(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          product: product,
          isFavorite: true,
          onFavoriteToggle: () => onFavoriteToggle(product.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favoriteProducts.isEmpty
          ? const EmptyStateWidget(
              message: 'No favorites yet',
              icon: Icons.favorite_border,
            )
          : isGridView
          ? GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return ProductGridItem(
                  product: product,
                  onTap: () => _navigateToDetail(context, product),
                  isFavorite: true,
                  onFavoriteToggle: () => onFavoriteToggle(product.id),
                );
              },
            )
          : ListView.builder(
              itemCount: favoriteProducts.length,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return ProductCard(
                  product: product,
                  onTap: () => _navigateToDetail(context, product),
                  isFavorite: true,
                  onFavoriteToggle: () => onFavoriteToggle(product.id),
                );
              },
            ),
    );
  }
}
