part of 'pokedex_bloc.dart';

@immutable
abstract class PokedexEvent {}

class LoadingRequested extends PokedexEvent {}
