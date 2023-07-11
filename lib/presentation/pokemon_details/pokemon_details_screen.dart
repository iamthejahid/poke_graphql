import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poke_graphql/domain/home/model/pokemon.dart';
import 'package:poke_graphql/utils/ui_constant.dart';

import '../../utils/custom_style.dart';
import '../widgets/k_title_text.dart';

class PokemonDetailsScreen extends StatelessWidget {
  static String route = "pokemonDetailsPage";
  const PokemonDetailsScreen({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Image.network(
                pokemon.image!,
                height: 150.w,
              ),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .slideY(end: 0.5, duration: const Duration(seconds: 3))
                .shake(
                  hz: 0.5,
                )
                .scaleXY(end: 0.7),
            const Gap(120),
            KTitleText(
              pokemon.name ?? "",
              style: CustomTextStyle.textStyle30w700,
            ),
            Row(
              children: [
                gap16,
                KTitleText(
                  "ID : ",
                  style: CustomTextStyle.textStyle14w400,
                ),
                KTitleText(
                  pokemon.id ?? "",
                  style: CustomTextStyle.textStyle14w400,
                ),
              ],
            ),
            Row(
              children: [
                gap16,
                KTitleText(
                  "Name : ",
                  style: CustomTextStyle.textStyle14w400,
                ),
                KTitleText(
                  pokemon.name ?? "",
                  style: CustomTextStyle.textStyle14w400,
                ),
              ],
            ),
            Row(
              children: [
                gap16,
                KTitleText(
                  "Weight : ",
                  style: CustomTextStyle.textStyle14w400,
                ),
                KTitleText(
                  pokemon.weight?.maximum ?? "",
                  style: CustomTextStyle.textStyle14w400,
                ),
              ],
            ),
            Row(
              children: [
                gap16,
                KTitleText(
                  "Height: ",
                  style: CustomTextStyle.textStyle14w400,
                ),
                KTitleText(
                  pokemon.height?.maximum ?? "",
                  style: CustomTextStyle.textStyle14w400,
                ),
              ],
            ),
            Row(
              children: [
                gap16,
                KTitleText(
                  "Classification: ",
                  style: CustomTextStyle.textStyle14w400,
                ),
                KTitleText(
                  pokemon.classification ?? "",
                  style: CustomTextStyle.textStyle14w400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
