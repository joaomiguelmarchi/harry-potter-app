import 'package:flutter/material.dart';
import 'package:harry_potter/infrastructure/presentation/routes/routes.dart';
import '../../generated/l10n.dart';
import 'application.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkTheme(context) ? Colors.black : Colors.white,
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 200.0, bottom: 60),
              child: Text(
                'Harry Potter',
                style: TextStyle(
                  fontSize: 100,
                  color: isDarkTheme(context) ? Colors.white : Colors.black,
                  fontFamily: 'HarryPotter',
                ),
              ),
            ),
            Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(NamedRoutes.houses);
                  },
                  child: Container(
                    height: 200,
                    width: 190,
                    decoration: BoxDecoration(
                      color: isDarkTheme(context)
                          ? Colors.grey[800]
                          : Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home, size: 100, color: Colors.white),
                        Text(
                          S.of(context).houses,
                          style: TextStyle(
                            fontSize: 45,
                            color: Colors.white,
                            fontFamily: 'HarryPotter',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(NamedRoutes.spells);
                  },
                  child: Container(
                    height: 200,
                    width: 190,
                    decoration: BoxDecoration(
                      color: isDarkTheme(context)
                          ? Colors.grey[800]
                          : Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star_sharp, size: 100, color: Colors.white),
                        Text(
                          S.of(context).spells,
                          style: TextStyle(
                            fontSize: 45,
                            color: Colors.white,
                            fontFamily: 'HarryPotter',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(NamedRoutes.characters);
                  },
                  child: Container(
                    height: 170,
                    width: 400,
                    decoration: BoxDecoration(
                      color: isDarkTheme(context)
                          ? Colors.grey[800]
                          : Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person, size: 100, color: Colors.white),
                        Text(
                          S.of(context).characters,
                          style: TextStyle(
                            fontSize: 45,
                            color: Colors.white,
                            fontFamily: 'HarryPotter',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
