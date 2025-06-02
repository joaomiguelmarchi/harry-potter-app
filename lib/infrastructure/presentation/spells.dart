import 'dart:async';

import 'package:flutter/material.dart';
import 'package:harry_potter/infrastructure/presentation/states/spells_state.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/spell.dart';
import '../../generated/l10n.dart';
import '../../main.dart';
import 'application.dart';

class SpellsScreen extends StatelessWidget {
  const SpellsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SpellsState(applicationUseCase),
      child: Consumer<SpellsState>(
        builder: (_, state, __) {
          return Scaffold(
            backgroundColor: isDarkTheme(context) ? Colors.black : Colors.white,
            appBar: AppBar(
              title: Text(S.of(context).spells, style: TextStyle(fontSize: 30)),
              centerTitle: true,
            ),
            body: Column(children: [Search(), SpellsListView()]),
          );
        },
      ),
    );
  }
}

class SpellsListView extends StatelessWidget {
  const SpellsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SpellsState>(context);

    if (state.isLoading) {
      return Expanded(child: Center(child: CircularProgressIndicator()));
    }

    return Expanded(
      child: ListView.builder(
        itemCount: state.list.length,
        itemBuilder: (_, index) {
          final wizard = state.list[index];

          return SpellItem(spell: wizard);
        },
      ),
    );
  }
}

class SpellItem extends StatelessWidget {
  const SpellItem({super.key, required this.spell});

  final Spell spell;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDarkTheme(context) ? null : Colors.black,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          spell.name,
                          style: TextStyle(
                            fontSize: 26,
                            color: isDarkTheme(context) ? null : Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    spell.description,
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkTheme(context) ? null : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SpellsState>(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        left: 4.0,
        right: 2.0,
        bottom: 4.0,
      ),
      child: TextFormField(
        enabled: true,
        controller: state.searchController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          fillColor: Colors.grey,
          suffixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(),
          label: Text(S.of(context).search),
        ),
        onChanged: (value) async {
          Timer(const Duration(milliseconds: 200), () async {
            state.filter();
          });
        },
      ),
    );
  }
}
