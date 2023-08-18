// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_list/app/modules/home/controllers/home_controller.dart';
import 'package:pokemon_list/app/modules/model/pokemon_model.dart';
import 'package:pokemon_list/app/modules/screens/pokemon_detail.dart';

class PokeBox extends StatefulWidget {
  const PokeBox({super.key});

  @override
  State<PokeBox> createState() => _PokeBoxState();
}

class _PokeBoxState extends State<PokeBox> {
  HomeController pokemonsController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: GridView.builder(
                itemCount: pokemonsController.pokemons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1),
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(PokemonDetail(
                        url: pokemonsController.pokemons[index].url,
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: PokeItem(
                        url: pokemonsController.pokemons[index].url,
                        getpokemon: pokemonsController.getSinglePokemon,
                      ),
                    ),
                  );
                })))
      ],
    );
  }
}

class PokeItem extends StatefulWidget {
  const PokeItem({super.key, required this.url, required this.getpokemon});

  final String url;
  final Function getpokemon;

  @override
  State<PokeItem> createState() => _PokeItemState();
}

class _PokeItemState extends State<PokeItem> {
  bool isLoading = true;
  late PokemonBoxModel myPokemon;

  Future<void> fetchPokemon() async {
    await widget.getpokemon(widget.url, (pokeData, status) {
      if (status) {
        setState(() {
          myPokemon = pokeData;
          isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.red,
              strokeWidth: 2,
            )
          : Image.network(
              myPokemon.imageUrl,
              height: 180,
            ),
    );
  }
}
