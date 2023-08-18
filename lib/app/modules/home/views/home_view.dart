import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pokemon_list/app/modules/widget/poke_box.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        elevation: 0,
        backgroundColor: Colors.red,
        title: Image.asset(
          "assets/images/Daco_5394286.png",
          width: 200,
          height: 60,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: const PokeBox(),
      ),
    );
  }
}
