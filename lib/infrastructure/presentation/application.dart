import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:harry_potter/infrastructure/presentation/routes/routes.dart';

import '../../generated/l10n.dart';
import 'home.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultTransition = SharedAxisPageTransitionsBuilder(
      transitionType: SharedAxisTransitionType.horizontal,
    );

    final allTargetPlatform = TargetPlatform.values;
    final builders = <TargetPlatform, PageTransitionsBuilder>{};

    for (final item in allTargetPlatform) {
      builders[item] = defaultTransition;
    }

    return MaterialApp(
      initialRoute: NamedRoutes.home,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: builders),
        fontFamily: 'HarryPotter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: builders),
        fontFamily: 'HarryPotter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      routes: MainRoute.routes,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const HomePage(),
    );
  }
}

bool isDarkTheme(BuildContext context) {
  return Theme.brightnessOf(context) == Brightness.dark;
}
