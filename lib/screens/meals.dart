// Goal: show all the meals for the selected category

import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';
import 'package:meals_app/screens/meal_details.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals});

  final String? title;
  final List<Meal> meals;
  //final void Function(Meal meals) onToggleFavorite;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MealDetailsScreen(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(meal: meals[index], onSelectMeal: (meal) { // we need meal here to pass it to selectMeal
            selectMeal(context, meal); // we pass the meal to selectMeal
          });
        },
        itemCount: meals.length,
      );
    } else {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ups no meals found for this category!',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting a different category...',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
          ],
        ),
      );
    }

    if (title == null) { // this way on the tabs.dart file we do not give the title input when we refer to MealsScreen so it will use...
      return content; //... this content here, which does not have a Scaffold(), thus the Scaffold from tabs.dart will be used.
    }

    return Scaffold( // if we give the title as well (which happenes on the categories screen, we use the Scaffold from here to get the categories Screen.
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
