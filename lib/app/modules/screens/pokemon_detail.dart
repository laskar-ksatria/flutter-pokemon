// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:pokemon_list/app/modules/home/controllers/home_controller.dart';
import 'package:pokemon_list/app/modules/model/pokemon_model.dart';

class PokemonDetail extends StatefulWidget {
  const PokemonDetail({super.key, required this.url});

  final String url;

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  bool isLoading = true;

  HomeController pokemonController = Get.put(HomeController());

  late final PokemonDetailModel myPokemonDetail;

  Future<void> getDetail() async {
    return Future.delayed(Duration(milliseconds: 500), () async {
      await pokemonController.getDetailPokemon(
          (PokemonDetailModel data, status) {
        if (status) {
          setState(() {
            isLoading = false;
            myPokemonDetail = data;
          });
        }
      }, widget.url);
    });
  }

  Color getColor(String type) {
    if (type == "fire") return Colors.red;
    if (type == "grass") return Colors.green;
    if (type == "water") return Colors.blue;
    if (type == "poison") return Colors.purple;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDetail(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  myPokemonDetail.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                automaticallyImplyLeading: true,
                backgroundColor: getColor(myPokemonDetail.type),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(420),
                  child: Center(
                    child: Image.network(
                      myPokemonDetail.imageUrl,
                      height: 400,
                    ),
                  ),
                ),
              ),
              body: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: RichText(
                            text: TextSpan(
                              text: 'Type: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: myPokemonDetail.type,
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: RichText(
                            text: TextSpan(
                              text: 'Height: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: myPokemonDetail.height.toString(),
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: RichText(
                            text: TextSpan(
                              text: 'Weight: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: myPokemonDetail.weight.toString(),
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: RichText(
                            text: TextSpan(
                              text: 'Ability: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: myPokemonDetail.ability,
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }));
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 120,
          width: 120,
          child: Lottie.asset('assets/lottie/pokeball2.json'),
        ),
      ),
    );
  }
}
