// tabs navigation requires its own screen which loads other screens as embedded screens
// main data management widget
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
// import 'package:meals_app/data/dummy_data.dart'; // we dont need it due to provider package
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';
// import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/screens/filters.dart';
// import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';


/* const kInitialFilters = {
Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false,
}; //k : for global variables */

class TabsScreen extends ConsumerStatefulWidget { // due to Riverpod Package
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favoriteMeals = [];
  /* Map<Filter, bool> _selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false,
  }; */


  /* void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        // we need SetState here to refresh the UI once we click on the 'Favorites' Icon button
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite');
    } else {
      setState(() {
        // same here
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Marked as a favorite');
    }
  } */

  void _selectPage(int index) {
    //here index is provided by Flutter
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      ); //pushReplacement: FiltersScreen won't be pushed, instead the tabscreen will be replaced with FiltersScreen as active screen. Thus 'Back' button on Adroid can not be used for navigation
      //} else {
      //  Navigator.of(context).pop();

    }
  }

  @override
  Widget build(BuildContext context) {
// We dont need these providers as these are already connected to the filteredMealsProvider
//    final meals = ref.watch(mealsProvider);  // we set up a listener here, whenever mealsProvider changes it reruns the build method
//    final activeFilters = ref.watch(filtersProvider);

    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      //onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
        //onToggleFavorite: _toggleMealFavoriteStatus,
      ); // we are passing it to the MealsScreen and through there to MealsDetailScreen and there through the Button we toggle it
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap:
            _selectPage, // we provide the index of the Tab - It will be provided by Flutter
        currentIndex: _selectedPageIndex,
        items: [
          // list of Tabs
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
