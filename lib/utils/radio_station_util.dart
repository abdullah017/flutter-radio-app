import 'package:flutter_radio_app/models/radio_station_model.dart';

class RadioStationUtils {
  static List<RadioStationModel> allStations = [
    RadioStationModel(
        name: 'Alem FM',
        streamUrl:
            'http://turkmedya.radyotvonline.com/turkmedya/alemfm.stream/playlist.m3u8',
        photoUrl: 'https://upload.wikimedia.org/wikipedia/tr/b/bf/Alem_fm.jpg'),
    RadioStationModel(
        name: 'Kral FM',
        streamUrl: 'http://provisioning.streamtheworld.com/pls/JOY_TURKAAC.pls',
        photoUrl: 'https://i.ytimg.com/vi/A49bKX8gb-8/maxresdefault.jpg'),
    RadioStationModel(
        name: 'Power TURK',
        streamUrl: 'http://icast.powergroup.com.tr/PowerTurk/mpeg/128/home',
        photoUrl:
            'https://www.canliradyodinle.fm/wp-content/uploads/power-turk-fm.jpg'),
  ];
}
