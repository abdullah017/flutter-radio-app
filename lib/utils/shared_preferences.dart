import 'package:flutter_radio_app/models/radio_station_model.dart';
import 'package:flutter_radio_app/utils/radio_station_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const _key = 'radio_station';

  static Future<RadioStationModel> getInitialRadioStation() async {
    final sharedPrefsBox = await SharedPreferences.getInstance();
    final stationName = sharedPrefsBox.getString(_key);
    if (stationName == null) return RadioStationUtils.allStations[0];
    return RadioStationUtils.allStations
        .firstWhere((element) => element.name == stationName);
  }

  static Future<void> setStation(RadioStationModel stationModel) async {
    final sharedPrefsBox = await SharedPreferences.getInstance();
    sharedPrefsBox.setString(_key, stationModel.name);
  }
}
