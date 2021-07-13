part of 'pokedex_bloc.dart';

@immutable
abstract class PokedexState {}

class PokedexLoading extends PokedexState {}

class PokedexLoaded extends PokedexState {
  final Pokedex pokedex;

  PokedexLoaded(this.pokedex);
}

class PokedexErrorHandled extends PokedexState {
  final String error;

  PokedexErrorHandled(this.error);
}
