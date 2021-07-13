import 'package:bloc_test_app/constraints/urls.dart';
import 'package:bloc_test_app/models/pokedex_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class PokedexRepository {
  Dio _dio = Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));

  PokedexRepository() {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 120,
    ));
  }

  Future<Pokedex> getAllPokemons() async {
    final response = await _dio.get(pokemonApiUrl);
    return Pokedex.formJson(response.data);
  }
}
