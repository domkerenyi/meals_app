// here we are creating the drawer for the Screens
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withAlpha(200),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text('Cooking Up!',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        )),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.restaurant,
                size: 26,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface), // it will be before the title
            title: Text(
              'Meals',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            onTap: () {
              onSelectScreen('meals');
            },
          ), // outputing list content
          ListTile(
            leading: Icon(Icons.settings,
                size: 26,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface), // it will be before the title
            title: Text(
              'Filters',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            onTap: () {
              onSelectScreen('filters');
            },
          ),
        ],
      ),
    );
  }
}
