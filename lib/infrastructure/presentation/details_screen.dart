import 'package:flutter/material.dart';
import 'package:harry_potter/infrastructure/presentation/states/details_state.dart';
import 'package:harry_potter/infrastructure/presentation/util/date_time_format.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/wizards.dart';
import '../../generated/l10n.dart';
import '../../main.dart';
import 'application.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailsState(applicationUseCase, id),
      child: Consumer<DetailsState>(
        builder: (_, state, __) {
          return Scaffold(
            backgroundColor: isDarkTheme(context) ? Colors.black : Colors.white,
            appBar: AppBar(
              title: Text(
                S.of(context).details,
                style: TextStyle(fontSize: 30),
              ),
              centerTitle: true,
            ),
            body: Details(),
          );
        },
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<DetailsState>(context);

    if (state.isLoading) {
      return Column(
        children: [Expanded(child: Center(child: CircularProgressIndicator()))],
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.wizard.image != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Image.network(
                    state.wizard.image!,
                    height: 300,
                    width: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        width: 100,
                        height: 100,
                        color: Colors.white,
                      );
                    },
                  ),
                ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: state.wizard.name,
                    style: TextStyle(fontSize: 50, fontFamily: 'HarryPotter'),
                  ),
                  WidgetSpan(
                    child: Icon(
                      state.wizard.gender == Gender.male
                          ? Icons.male
                          : Icons.female,
                      color: isDarkTheme(context) ? Colors.white : Colors.black,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (state.wizard.birthDate != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${S.of(context).birthDate}: ${tryFormatDate(DateFormatNamed.dateFormat, state.wizard.birthDate)}',
                style: TextStyle(fontSize: 30),
              ),
            ),
          if (state.wizard.house != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${S.of(context).house}: ${state.wizard.house!.name}',
                style: TextStyle(fontSize: 30),
              ),
            ),
          if (state.wizard.wand != null) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${S.of(context).wand}:',
                style: TextStyle(fontSize: 30),
              ),
            ),
            if (state.wizard.wand?.core != null &&
                state.wizard.wand?.core != '')
              Padding(
                padding: const EdgeInsets.only(left: 21.0),
                child: Text(
                  '•${state.wizard.wand!.core}',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            if (state.wizard.wand?.length != null)
              Padding(
                padding: const EdgeInsets.only(left: 21.0),
                child: Text(
                  '•${state.wizard.wand!.length}',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            if (state.wizard.wand?.wood != null &&
                state.wizard.wand?.wood != '')
              Padding(
                padding: const EdgeInsets.only(left: 21.0),
                child: Text(
                  '•${state.wizard.wand!.wood}',
                  style: TextStyle(fontSize: 30),
                ),
              ),
          ],
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              '${S.of(context).species}: ${state.wizard.specie}',
              style: TextStyle(fontSize: 30),
            ),
          ),
          if (state.wizard.ancestry != null && state.wizard.ancestry != '')
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${S.of(context).ancestry}: ${state.wizard.ancestry}',
                style: TextStyle(fontSize: 30),
              ),
            ),
          if (state.wizard.hairColour != null && state.wizard.hairColour != '')
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${S.of(context).hairColour}: ${state.wizard.hairColour}',
                style: TextStyle(fontSize: 30),
              ),
            ),
          if (state.wizard.eyeColour != null && state.wizard.eyeColour != '')
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${S.of(context).eyeColour}: ${state.wizard.eyeColour}',
                style: TextStyle(fontSize: 30),
              ),
            ),
          if (state.wizard.patronus != null && state.wizard.patronus != '')
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${S.of(context).patronus}: ${state.wizard.patronus}',
                style: TextStyle(fontSize: 30),
              ),
            ),
          if (state.wizard.alive != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${S.of(context).status}: ${state.wizard.alive! ? S.of(context).alive : S.of(context).died}',
                style: TextStyle(fontSize: 30),
              ),
            ),
        ],
      ),
    );
  }
}
