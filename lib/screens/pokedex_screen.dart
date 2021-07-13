import 'package:bloc_test_app/bloc/pokedex/pokedex_bloc.dart';
import 'package:bloc_test_app/constraints/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokedexScreen extends StatelessWidget {
  const PokedexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<PokedexBloc, PokedexState>(
              builder: (context, state) {
                if (state is PokedexLoading)
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                else
                  return RefreshIndicator(
                    color: Colors.red,
                    onRefresh: () async =>
                        context.read<PokedexBloc>().add(LoadingRequested()),
                    child: _getPokedexGrid(state),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPokedexGrid(PokedexState state) {
    if (state is PokedexLoaded)
      return GridView.count(
        crossAxisCount: 3,
        children: state.pokedex.name!
            .map((e) =>
                _getPokemonCard(state.pokedex.name?.indexOf(e) ?? 0, state))
            .toList(),
      );
    else if (state is PokedexErrorHandled)
      return ListView(
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Text(
              state.error,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    else
      return ListView(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20.0),
            child: Text("Неизвестная ошибка"),
          )
        ],
      );
  }

  Widget _getPokemonCard(int index, PokedexLoaded state) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Image.network(
                "$pokemonImgUrl${_getImgNumber(index + 1)}.png",
              ),
            ),
            Text(state.pokedex.name![index]),
          ],
        ),
      ),
    );
  }

  String _getImgNumber(int number) {
    String imgNumber = number.toString();
    if (imgNumber.length == 2)
      return "0$imgNumber";
    else if (imgNumber.length == 1) return "00$imgNumber";
    return imgNumber;
  }
}
