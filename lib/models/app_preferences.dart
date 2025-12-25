/// User preferences model
class AppPreferences {
  final Set<String> favoriteProductIds;
  final String lastSortOption;
  final bool isGridView;
  final String themeMode; // 'light', 'dark', 'system'

  const AppPreferences({
    this.favoriteProductIds = const {},
    this.lastSortOption = 'Name',
    this.isGridView = false,
    this.themeMode = 'system',
  });

  /// Copy with method for immutable updates
  AppPreferences copyWith({
    Set<String>? favoriteProductIds,
    String? lastSortOption,
    bool? isGridView,
    String? themeMode,
  }) {
    return AppPreferences(
      favoriteProductIds: favoriteProductIds ?? this.favoriteProductIds,
      lastSortOption: lastSortOption ?? this.lastSortOption,
      isGridView: isGridView ?? this.isGridView,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'favoriteProductIds': favoriteProductIds.toList(),
      'lastSortOption': lastSortOption,
      'isGridView': isGridView,
      'themeMode': themeMode,
    };
  }

  /// Create from JSON
  factory AppPreferences.fromJson(Map<String, dynamic> json) {
    return AppPreferences(
      favoriteProductIds:
          (json['favoriteProductIds'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toSet() ??
          {},
      lastSortOption: json['lastSortOption'] as String? ?? 'Name',
      isGridView: json['isGridView'] as bool? ?? false,
      themeMode: json['themeMode'] as String? ?? 'system',
    );
  }
}
