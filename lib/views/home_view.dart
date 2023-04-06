import 'package:flutter/material.dart';
import 'package:flutter_radio_app/utils/radio_player.dart';
import 'package:flutter_radio_app/widgets/gradient_background_widget.dart';
import 'package:flutter_radio_app/widgets/radio_player_widget.dart';
import 'package:radio_player/radio_player.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: FutureBuilder(
          future: RadioPlayerUtils.initPlayer(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return const RadioPlayerWidget();
          },
        ),
      ),
    );
  }
}
