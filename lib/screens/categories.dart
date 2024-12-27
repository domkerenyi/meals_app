// we want to build here the widget that displays all the categories
// it will be a main screen in the app

import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavorite, required this.availableMeals});

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    // here we are adding a method to a StatelessWidget
    // this method will be called when we tap on a category
    // we will navigate to the meals screen
    // we will pass the selected category to the meals screen
    // for that we use the Navigator.push

    final filteredMeals = availableMeals // here we changed dummyMeals to availableMeals, which is already filtered based on the Filters which can be found in tabs.dart
        .where((meal) => meal.categories.contains(category.id))
        .toList(); // here we get the individual meals for the selected category. If its true we keep the meal, if its false we don't keep it

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(title: category.title, meals: filteredMeals, onToggleFavorite: onToggleFavorite,),
      ),
    );

    // as we are in a Stateless Widget, context is not globally available thus we add BuildContext context to _selectCategory
    // what it does is it pushes a new route onto the stack of routes managed by the Navigator
    // the user always see the topmost route. When we push a new route, the user sees the new route
  }

  @override
  Widget build(BuildContext context) {
    return GridView( // here we dont need a Scaffold, since we have it in the tabs.dart, which used to select the screens and we set it there
          padding: const EdgeInsets.all(25),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ), // I can set the number of columns here. Here 2 columns next to each other
          children: [
            // for loop is an alternative to using availableCategories.map((category) => CategoryGridItem(category: category)).toList()
            for (final category in availableCategories) // this category we are passing to _selectCategory down below
              CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
              )
          ],
        );
  }
}
