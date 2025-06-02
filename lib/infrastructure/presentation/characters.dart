import 'package:flutter/material.dart';
import 'package:harry_potter/domain/entities/wizards.dart';
import 'package:harry_potter/infrastructure/presentation/routes/routes.dart';
import 'package:harry_potter/infrastructure/presentation/states/characters_state.dart';
import 'package:harry_potter/infrastructure/presentation/util/date_time_format.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../main.dart';
import 'application.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({super.key, this.house});

  final House? house;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CharactersState(applicationUseCase, house),
      child: Consumer<CharactersState>(
        builder: (_, state, __) {
          return Scaffold(
            backgroundColor: isDarkTheme(context) ? Colors.black : Colors.white,
            appBar: AppBar(
              title: Text(
                S.of(context).characters,
                style: TextStyle(fontSize: 30),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [if (house == null) _Filters(), CharactersListView()],
            ),
          );
        },
      ),
    );
  }
}

class CharactersListView extends StatelessWidget {
  const CharactersListView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CharactersState>(context);

    if (state.isLoading) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    }

    return Expanded(
      child: ListView.builder(
        itemCount: state.list.length,
        itemBuilder: (_, index) {
          final wizard = state.list[index];

          return WizardItem(wizard: wizard);
        },
      ),
    );
  }
}

class WizardItem extends StatelessWidget {
  const WizardItem({super.key, required this.wizard});

  final Wizards wizard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(
          context,
        ).pushNamed(NamedRoutes.details, arguments: wizard.id);
      },
      child: SizedBox(
        height: 130,
        child: Card(
          color: isDarkTheme(context) ? null : Colors.black,
          child: Row(
            children: [
              if (wizard.image != null)
                Image.network(
                  wizard.image!,
                  height: 100,
                  width: 100,
                  errorBuilder: (_, __, ___) {
                    return SizedBox.shrink();
                  },
                ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            wizard.name,
                            style: TextStyle(
                              fontSize: 26,
                              color: isDarkTheme(context) ? null : Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (wizard.gender == Gender.male)
                          Icon(
                            Icons.male,
                            color: isDarkTheme(context) ? null : Colors.white,
                          )
                        else
                          Icon(
                            Icons.female,
                            color: isDarkTheme(context) ? null : Colors.white,
                          ),
                      ],
                    ),
                    if (wizard.birthDate != null)
                      Text(
                        tryFormatDate(
                              DateFormatNamed.dateFormat,
                              wizard.birthDate,
                            ) ??
                            '',
                        style: TextStyle(
                          fontSize: 18,
                          color: isDarkTheme(context) ? null : Colors.white,
                        ),
                      ),
                    if (wizard.house != null)
                      Text(
                        '${S.of(context).house}: ${wizard.house!.name}',
                        style: TextStyle(
                          fontSize: 18,
                          color: isDarkTheme(context) ? null : Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Icon(Icons.filter_alt_rounded, size: 32),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: _BuildFilterList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildFilterList extends StatelessWidget {
  const _BuildFilterList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 8.0),
        children: [
          for (final item in House.values) _ComponentListFilters(house: item),
        ],
      ),
    );
  }
}

class _ComponentListFilters extends StatelessWidget {
  const _ComponentListFilters({required this.house});

  final House house;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CharactersState>(context);

    final isSelected = state.selected == house;
    final themeCardColor = isDarkTheme(context) ? Colors.white : null;
    final themeTextColor = isSelected ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () async {
          state.filter(house);
        },
        child: Chip(
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.secondary
              : themeCardColor,
          padding: const EdgeInsets.all(8.0),
          label: Text(
            house.name,
            style: TextStyle(
              fontSize: 20,
              color: isDarkTheme(context) ? Colors.black : themeTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
