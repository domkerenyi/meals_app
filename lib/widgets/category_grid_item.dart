import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category, required this.onSelectCategory});

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell( // with InkWell you get a ripple effect when you tap on the item
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor, // the color of the ripple effect
      borderRadius: BorderRadius.circular(15), // the radius of the ripple effect
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              category.color.withAlpha((0.55 * 255).toInt()),
              category.color.withAlpha((0.9 * 255).toInt()),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(category.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                )),
      ),
    );
  }
}
