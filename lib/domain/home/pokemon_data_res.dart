import 'dart:convert';

import 'model/pokemon.dart';

PokemonDataRes pokemonDataResFromJson(String str) =>
    PokemonDataRes.fromJson(json.decode(str));

String pokemonDataResToJson(PokemonDataRes data) => json.encode(data.toJson());

class PokemonDataRes {
  final String? typename;
  final List<Pokemon>? pokemons;

  PokemonDataRes({
    this.typename,
    this.pokemons,
  });

  PokemonDataRes copyWith({
    String? typename,
    List<Pokemon>? pokemons,
  }) =>
      PokemonDataRes(
        typename: typename ?? this.typename,
        pokemons: pokemons ?? this.pokemons,
      );

  factory PokemonDataRes.fromJson(Map<String, dynamic> json) => PokemonDataRes(
        typename: json["__typename"],
        pokemons: json["pokemons"] == null
            ? []
            : List<Pokemon>.from(
                json["pokemons"]!.map((x) => Pokemon.fromJson(x))),
      );

  factory PokemonDataRes.init() => PokemonDataRes(pokemons: [], typename: "");

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "pokemons": pokemons == null
            ? []
            : List<dynamic>.from(pokemons!.map((x) => x.toJson())),
      };
}
