// jhere we want to create a widget for the meals

import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(Meal meal) onSelectMeal; // this gets the meal on which we tapped

  // getter that will return a string for complexity

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }

    String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge, // we want to clip the content of the card to the rounded corners of the card itself to make it look nice
      elevation: 2,
      child: InkWell(
        // we want the meals to be tappable
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          // Stack is a widget that allows you to place widgets on top of each other. We can set image as background and have Text on it
          children: [
            Hero(
              tag: meal.id, // unique per Widget tag
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover, // we want the image to cover the whole card and not be stretched
                height: 200, // we want the image to have a fixed height
                width: double.infinity, // we want the image to take the full width of the card
              ),
            ),
            Positioned(
              bottom: 0, // it starts at the bottom of the card
              left: 0, // it starts at the beginning of the left boarder
              right: 0, // it ends at the end of the right boarder
              child: Container(
                color: Colors
                    .black54, // we want to have a black background for the text
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait( // MealItemTrait also has Row() thus we are using double Row() but its not a problem since we are using it in a Column() and a Positioned()
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: affordabilityText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
