import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:pokemon_list/app/modules/model/pokemon_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final dio = Dio();
  final apiUrl = "https://pokeapi.co/api/v2/pokemon?limit=20";

  RxList<PokemonModel> pokemons = <PokemonModel>[].obs;

  void setDefaultPokemons() {
    pokemons = <PokemonModel>[].obs; // Set the default value here
  }

  Future getSinglePokemon(String url, Function callback) async {
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        PokemonBoxModel pokemonDetail = PokemonBoxModel(
            // imageUrl: response.data["sprites"]["other"]["official-artwork"]
            //     ["front_default"],
            imageUrl: response.data["sprites"]["other"]["home"]
                ["front_default"],
            id: response.data["id"]);
        callback(pokemonDetail, true);
      }
      callback(null, false);
    } catch (error) {
      callback(null, false);
    }
  }

  Future getPokemons(Function callback) async {
    try {
      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        var pokemonData = response.data["results"];
        for (var set in pokemonData) {
          PokemonModel myPokemon =
              PokemonModel(name: set["name"], url: set["url"]);
          pokemons.add(myPokemon);
        }
        callback(true);
      }
    } catch (error) {
      print(error);
      callback(false);
    }
  }

  Future getDetailPokemon(Function callback, url) async {
    try {
      final response = await dio.get(url);
      var pokemonData = response.data;
      callback(
          PokemonDetailModel(
              type: pokemonData["types"][0]["type"]["name"] ?? "none",
              imageUrl: pokemonData["sprites"]["other"]["official-artwork"]
                      ["front_default"] ??
                  "No",
              name: pokemonData["name"] ?? "No",
              height: pokemonData["height"] ?? 0,
              weight: pokemonData["weight"] ?? 0,
              ability: pokemonData["abilities"][0]["ability"]["name"] ?? "No",
              base_experience: pokemonData["base_experience"]),
          true);
    } catch (errors) {
      callback(errors, false);
    }
  }
}
