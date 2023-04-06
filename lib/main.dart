import 'package:flutter/material.dart';
import 'package:flutter_radio_app/models/radio_station_model.dart';
import 'package:flutter_radio_app/providers/radio_provider.dart';
import 'package:flutter_radio_app/utils/shared_preferences.dart';
import 'package:flutter_radio_app/views/home_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final radioStation = await SharedPrefs.getInitialRadioStation();
  runApp(MyApp(
    initialStation: radioStation,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.initialStation}) : super(key: key);

  final RadioStationModel initialStation;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: ((context) => RadioProvider(initialStation)))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeView(),
      ),
    );
  }
}
