import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';


class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]); // we initialize the constructor function. With super we reach out to StateNotifier. In thsi case it should be a List of Meal
// super([]) must never be modified. ITS NOT ALLOWED! We always have to create a new one.

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList(); // with where we get a new list!!. // here we remove a meal
      return false;
    } else {
      state = [...state, meal]; //spread operator. here we add a meal: We pull out allthe elements contained by the list and add them as individual elements of the new state list and we then add as individual new element the meal
      return true;
    }
  }

}

final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List <Meal>>((ref) { // the state of the provided data will be change. It works together with an other class
  return FavoriteMealsNotifier(); // it returns an instance of the notifer class
}); 