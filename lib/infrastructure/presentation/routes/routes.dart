import 'package:flutter/cupertino.dart';

import '../../../domain/entities/wizards.dart';
import '../characters.dart';
import '../details_screen.dart';
import '../home.dart';
import '../houses.dart';

class NamedRoutes {
  static const String home = 'home';
  static const String characters = 'characters';
  static const String houses = 'houses';
  static const String details = 'details';
}

class MainRoute {
  static final routes = {
    NamedRoutes.home: (context) => const HomePage(),
    NamedRoutes.characters: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as House?;

      return CharactersList(house: args);
    },
    NamedRoutes.houses: (_) => const HousesScreen(),
    NamedRoutes.details: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as String;

      return DetailsScreen(id: args);
    },
  };
}
