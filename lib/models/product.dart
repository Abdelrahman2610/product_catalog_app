/// Product model class
/// Represents a single product with its properties
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviewCount;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
  });

  /// Formatted price string with currency symbol
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  /// Star rating display (e.g., "4.5 ⭐")
  String get ratingDisplay => '$rating ⭐';
}
