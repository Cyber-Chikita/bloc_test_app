import 'package:bloc_test_app/bloc/pokedex/pokedex_bloc.dart';
import 'package:bloc_test_app/repositories/pokedex_repository.dart';
import 'package:bloc_test_app/screens/pokedex_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
        create: (context) => PokedexRepository(),
        child: BlocProvider(
          create: (context) => PokedexBloc(context.read<PokedexRepository>()),
          child: PokedexScreen(),
        ),
      ),
    );
  }
}
