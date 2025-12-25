import 'package:flutter/material.dart';

/// Price range slider widget for filtering products
class PriceRangeSlider extends StatelessWidget {
  final RangeValues currentRange;
  final double min;
  final double max;
  final ValueChanged<RangeValues> onChanged;

  const PriceRangeSlider({
    super.key,
    required this.currentRange,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price Range',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '\$${currentRange.start.toStringAsFixed(0)} - \$${currentRange.end.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        RangeSlider(
          values: currentRange,
          min: min,
          max: max,
          divisions: 20,
          labels: RangeLabels(
            '\$${currentRange.start.toStringAsFixed(0)}',
            '\$${currentRange.end.toStringAsFixed(0)}',
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
