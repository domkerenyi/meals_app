// we want to build here the widget that displays all the categories
// it will be a main screen in the app

import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  //final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync:
          this, // trough this it gets access to SingleTickerProviderStateMixin state
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    // here we are adding a method to a StatelessWidget
    // this method will be called when we tap on a category
    // we will navigate to the meals screen
    // we will pass the selected category to the meals screen
    // for that we use the Navigator.push

    final filteredMeals = widget
        .availableMeals // here we changed dummyMeals to availableMeals, which is already filtered based on the Filters which can be found in tabs.dart
        .where((meal) => meal.categories.contains(category.id))
        .toList(); // here we get the individual meals for the selected category. If its true we keep the meal, if its false we don't keep it

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(title: category.title, meals: filteredMeals),
      ),
    );

    // as we are in a Stateless Widget, context is not globally available thus we add BuildContext context to _selectCategory
    // what it does is it pushes a new route onto the stack of routes managed by the Navigator
    // the user always see the topmost route. When we push a new route, the user sees the new route
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        // here we dont need a Scaffold, since we have it in the tabs.dart, which used to select the screens and we set it there
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ), // I can set the number of columns here. Here 2 columns next to each other
        children: [
          // for loop is an alternative to using availableCategories.map((category) => CategoryGridItem(category: category)).toList()
          for (final category
              in availableCategories) // this category we are passing to _selectCategory down below
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0,
              0.3), // we start by offsetting the postiion of the GridView child on the Y axis by 0.3
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
