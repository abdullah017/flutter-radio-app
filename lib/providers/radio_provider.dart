import 'package:flutter/material.dart';
import 'package:flutter_radio_app/models/radio_station_model.dart';

class RadioProvider with ChangeNotifier {
  final RadioStationModel initialRadioStation;

  RadioProvider(this.initialRadioStation);

  RadioStationModel? _station;
  RadioStationModel get station => _station ?? initialRadioStation;

  void setRadioStation(RadioStationModel stationModel) {
    _station = stationModel;
    notifyListeners();
  }
}
