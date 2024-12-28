import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false
        }); // setting initial state, now its not an empty list, its a map of filters

  
  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
  
  void setFilter(Filter filter, bool isActive) {
    //state[filter] = isActive; // NOT ALLOWED! -> mutating state

    state = {
      ...state,
      filter: isActive, // override the key-value pairs
    };
  }
}

final filtersProvider = StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
); // we create an instance of the class FiltersNotifierF


// Here we add a new Provider that depends on the above Provider:

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider); // whenever watched value changes the Provider gets refreshed
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
});
