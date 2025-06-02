import 'package:flutter/material.dart';
import 'package:harry_potter/infrastructure/presentation/routes/routes.dart';

import '../../domain/entities/wizards.dart';
import '../../generated/l10n.dart';
import 'application.dart';

class HousesScreen extends StatelessWidget {
  const HousesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).houses, style: TextStyle(fontSize: 30)),
      ),
      backgroundColor: isDarkTheme(context) ? Colors.black : Colors.white,
      body: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HousesContainer(house: House.gryffindor),
              HousesContainer(house: House.slytherin),
            ],
          ),
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HousesContainer(house: House.hufflepuff),
              HousesContainer(house: House.ravenclaw),
            ],
          ),
        ],
      ),
    );
  }
}

class HousesContainer extends StatelessWidget {
  const HousesContainer({super.key, required this.house});

  final House house;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(NamedRoutes.characters, arguments: house);
      },
      child: Container(
        height: 200,
        width: 190,
        decoration: BoxDecoration(
          color: isDarkTheme(context) ? Colors.grey[800] : Colors.black,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(Icons.home, size: 100, color: Colors.white),
            Image.asset('assets/${house.name}.png', width: 100, height: 100,),
            Text(
              house.name,
              style: TextStyle(
                fontSize: 45,
                color: Colors.white,
                fontFamily: 'HarryPotter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
