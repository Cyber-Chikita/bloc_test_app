import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_test_app/models/pokedex_model.dart';
import 'package:bloc_test_app/repositories/pokedex_repository.dart';
import 'package:meta/meta.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  final PokedexRepository _repository;

  PokedexBloc(this._repository) : super(PokedexLoading()) {
    add(LoadingRequested());
  }

  @override
  Stream<PokedexState> mapEventToState(
    PokedexEvent event,
  ) async* {
    if (event is LoadingRequested) {
      try {
        yield PokedexLoading();
        yield PokedexLoaded(await _repository.getAllPokemons());
      } catch (e, st) {
        print(e);
        print(st);
        yield PokedexErrorHandled(
            "Произошла ошибка при полученные данных, повторите попытку позже.");
      }
    }
  }
}
