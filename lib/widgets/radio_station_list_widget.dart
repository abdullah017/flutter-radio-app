import 'package:flutter/material.dart';
import 'package:flutter_radio_app/models/radio_station_model.dart';
import 'package:flutter_radio_app/utils/radio_player.dart';
import 'package:flutter_radio_app/utils/radio_station_util.dart';
import 'package:flutter_radio_app/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../providers/radio_provider.dart';

class RadioStationListWidget extends StatefulWidget {
  const RadioStationListWidget({super.key});

  @override
  State<RadioStationListWidget> createState() => _RadioStationListWidgetState();
}

class _RadioStationListWidgetState extends State<RadioStationListWidget> {
  late RadioStationModel selectedStation;
  late RadioProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<RadioProvider>(context, listen: false);
    selectedStation = provider.station;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RadioProvider>(context, listen: false);
    return ListView.builder(
        itemCount: RadioStationUtils.allStations.length,
        itemBuilder: (context, index) {
          final station = RadioStationUtils.allStations[index];
          bool isSelected = station.name == provider.station.name;
          return Container(
            decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(colors: [
                      Colors.pink,
                      Colors.deepPurple,
                    ])
                  : null,
            ),
            child: ListTile(
                leading: Image.network(
                  station.photoUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                horizontalTitleGap: 50,
                title: Text(
                  station.name,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                onTap: () async {
                  provider.setRadioStation(station);
                  SharedPrefs.setStation(station);
                  await RadioPlayerUtils.changeStation(station);
                  setState(() {
                    selectedStation = station;
                  });
                }),
          );
        });
  }
}
