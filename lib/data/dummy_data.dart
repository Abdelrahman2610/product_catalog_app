import '../models/product.dart';

/// Dummy data for products
/// In a real app, this would come from an API or database
class DummyData {
  static final List<Product> products = [
    const Product(
      id: '1',
      name: 'Wireless Headphones',
      description:
          'Premium noise-cancelling wireless headphones with 30-hour battery life. '
          'Features advanced Bluetooth 5.0 technology, comfortable over-ear design, '
          'and exceptional sound quality. Perfect for music lovers and professionals.',
      price: 199.99,
      category: 'Electronics',
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
      rating: 4.5,
      reviewCount: 1234,
    ),
    const Product(
      id: '2',
      name: 'Smart Watch Pro',
      description:
          'Next-generation smartwatch with health monitoring, GPS tracking, and '
          'water resistance up to 50m. Track your fitness goals, receive notifications, '
          'and customize with hundreds of watch faces.',
      price: 349.99,
      category: 'Wearables',
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
      rating: 4.7,
      reviewCount: 892,
    ),
    const Product(
      id: '3',
      name: 'Leather Backpack',
      description:
          'Handcrafted genuine leather backpack with laptop compartment. '
          'Durable, stylish, and perfect for daily commute or travel. '
          'Features multiple pockets and adjustable straps for maximum comfort.',
      price: 129.99,
      category: 'Fashion',
      imageUrl:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500',
      rating: 4.3,
      reviewCount: 567,
    ),
    const Product(
      id: '4',
      name: 'Coffee Maker Deluxe',
      description:
          'Programmable coffee maker with 12-cup capacity and thermal carafe. '
          'Wake up to fresh coffee every morning with the built-in timer. '
          'Easy to clean and maintain with removable parts.',
      price: 89.99,
      category: 'Home & Kitchen',
      imageUrl:
          'https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=500',
      rating: 4.6,
      reviewCount: 2103,
    ),
    const Product(
      id: '5',
      name: 'Yoga Mat Premium',
      description:
          'Extra thick (6mm) non-slip yoga mat made from eco-friendly materials. '
          'Provides excellent cushioning and grip for all yoga styles. '
          'Comes with carrying strap and is easy to clean.',
      price: 39.99,
      category: 'Sports & Fitness',
      imageUrl:
          'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=500',
      rating: 4.8,
      reviewCount: 756,
    ),
    const Product(
      id: '6',
      name: 'Desk Lamp LED',
      description:
          'Modern LED desk lamp with adjustable brightness and color temperature. '
          'Touch control, USB charging port, and flexible gooseneck design. '
          'Energy-efficient and perfect for reading or working.',
      price: 45.99,
      category: 'Home & Office',
      imageUrl:
          'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500',
      rating: 4.4,
      reviewCount: 423,
    ),
    const Product(
      id: '7',
      name: 'Running Shoes Ultra',
      description:
          'Lightweight running shoes with responsive cushioning and breathable mesh. '
          'Engineered for speed and comfort, suitable for both casual runners '
          'and marathon enthusiasts. Available in multiple colors.',
      price: 119.99,
      category: 'Sports & Fitness',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500',
      rating: 4.6,
      reviewCount: 1876,
    ),
    const Product(
      id: '8',
      name: 'Portable Speaker',
      description:
          'Waterproof Bluetooth speaker with 360-degree sound and 20-hour battery. '
          'Perfect for outdoor adventures, pool parties, or home listening. '
          'Compact design with powerful bass and crystal-clear audio.',
      price: 79.99,
      category: 'Electronics',
      imageUrl:
          'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500',
      rating: 4.5,
      reviewCount: 991,
    ),
  ];
}
