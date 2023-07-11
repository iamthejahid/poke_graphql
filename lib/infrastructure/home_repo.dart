import 'dart:convert';

import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:poke_graphql/domain/home/pokemon_data_res.dart';
import 'package:poke_graphql/utils/network_util/network_handler_graph.dart';

import '../../utils/network_util/network_handler.dart';

class HomeRepo {
  final api = NetworkHandlerGraphQL.instance;

  Future<Either<CleanFailure, PokemonDataRes>> getHomeDate() async {
    final data = await api.get(
        // endPoint: APIRoute.HOME,
        // withToken: false,
        query: '''
      query GetAllPokemon {
        pokemons(first: 20) {
          id
          name
          weight {
            maximum
          }
          height {
            maximum
          }
          image
          classification
        }
      }
      ''');

    Logger.v("data: $data");

    return data.fold((l) {
      final error = jsonDecode(l.error);
      final failure = l.copyWith(error: error['error']);
      return left(failure);
    }, (r) {
      Logger.e(r.data);
      return right(PokemonDataRes.fromJson(r.data!));
    });
  }
}
