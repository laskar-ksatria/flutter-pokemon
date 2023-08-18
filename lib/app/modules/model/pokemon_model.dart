// ignore_for_file: non_constant_identifier_names

class PokemonModel {
  PokemonModel({required this.name, required this.url});
  String name;
  String url;
}

class PokemonBoxModel {
  PokemonBoxModel({required this.imageUrl, required this.id});
  int id;
  String imageUrl;
}

class PokemonDetailModel {
  PokemonDetailModel(
      {required this.name,
      required this.height,
      required this.weight,
      required this.ability,
      required this.imageUrl,
      required this.type,
      required this.base_experience});

  String type;
  String imageUrl;
  String name;
  int height;
  int weight;
  int base_experience;
  String ability;
}
