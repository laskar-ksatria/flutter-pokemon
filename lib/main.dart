import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pokemon_list/app/modules/home/controllers/home_controller.dart';
import 'package:pokemon_list/app/widgets/splash.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final HomeController pokemonController = Get.put(HomeController());

  Future<bool> fetchPokemon() async {
    return Future.delayed(const Duration(seconds: 4), () async {
      await pokemonController.getPokemons((bool isSuccess) {});
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchPokemon(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Application",
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
            );
          }
        }));
  }
}
