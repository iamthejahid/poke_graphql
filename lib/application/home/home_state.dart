import 'package:equatable/equatable.dart';
import 'package:poke_graphql/domain/home/pokemon_data_res.dart';

import '../../utils/network_util/network_handler.dart';

class HomeState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final PokemonDataRes pokemonDataRes;
  final bool notification;
  final bool chatNotification;

  const HomeState({
    required this.loading,
    required this.failure,
    required this.pokemonDataRes,
    required this.notification,
    required this.chatNotification,
  });

  factory HomeState.init() => HomeState(
        loading: false,
        failure: CleanFailure.none(),
        pokemonDataRes: PokemonDataRes.init(),
        notification: false,
        chatNotification: false,
      );

  HomeState copyWith({
    bool? loading,
    CleanFailure? failure,
    PokemonDataRes? pokemonDataRes,
    bool? notification,
    bool? chatNotification,
  }) {
    return HomeState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      pokemonDataRes: pokemonDataRes ?? this.pokemonDataRes,
      notification: notification ?? this.notification,
      chatNotification: chatNotification ?? this.chatNotification,
    );
  }

  @override
  String toString() {
    return 'HomeState(loading: $loading, failure: $failure, pokemonDataRes: $pokemonDataRes, notification: $notification, chatNotification: $chatNotification)';
  }

  @override
  List<Object> get props {
    return [
      loading,
      failure,
      pokemonDataRes,
      notification,
      chatNotification,
    ];
  }
}
