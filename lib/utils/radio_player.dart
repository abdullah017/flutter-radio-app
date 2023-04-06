import 'package:flutter/material.dart';
import 'package:flutter_radio_app/models/radio_station_model.dart';
import 'package:provider/provider.dart';
import 'package:radio_player/radio_player.dart';

import '../providers/radio_provider.dart';

class RadioPlayerUtils {
  static late RadioPlayer player;

  static Future<void> initPlayer(BuildContext context) async {
    final provider = Provider.of<RadioProvider>(context, listen: false);
    player = RadioPlayer();
    await player.stop();
    await player.setChannel(
        title: provider.station.name, url: provider.station.streamUrl);
    await player.play();
  }

  static Future<void> changeStation(RadioStationModel stationModel) async {
    await player.stop();
    await player.setChannel(
        title:stationModel.name, url: stationModel.streamUrl);
    await player.play();
  }
}
