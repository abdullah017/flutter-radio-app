import 'package:flutter/material.dart';
import 'package:flutter_radio_app/providers/radio_provider.dart';
import 'package:flutter_radio_app/utils/radio_player.dart';
import 'package:provider/provider.dart';

import 'radio_station_list_widget.dart';

class RadioPlayerWidget extends StatefulWidget {
  const RadioPlayerWidget({super.key});

  @override
  State<RadioPlayerWidget> createState() => _RadioPlayerWidgetState();
}

class _RadioPlayerWidgetState extends State<RadioPlayerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> radioOffset;
  late Animation<Offset> radioListOffset;

  bool listEnabled = false;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 500,
        ));

    radioListOffset = Tween(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    radioOffset = Tween(
      begin: const Offset(0, 0.3),
      end: const Offset(0, 0.0),
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));

        RadioPlayerUtils.player.stateStream.listen((event) {
          setState(() {
            isPlaying = event;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: SlideTransition(
          position: radioOffset,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                color: Colors.transparent,
                child:
                    Consumer<RadioProvider>(builder: ((context, value, child) {
                  return Image.network(
                    value.station.photoUrl,
                    fit: BoxFit.cover,
                  );
                })),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        listEnabled = !listEnabled;
                      });
                      switch (animationController.status) {
                        case AnimationStatus.dismissed:
                          animationController.forward();
                          break;
                        case AnimationStatus.completed:
                          animationController.reverse();
                          break;
                        default:
                      }
                    },
                    color: listEnabled ? Colors.amber : Colors.white,
                    iconSize: 30,
                    icon: const Icon(Icons.list),
                  ),
                  IconButton(
                    onPressed: () {},
                    color: Colors.white,
                    iconSize: 30,
                    icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                  ),
                  IconButton(
                    onPressed: () {
                      isPlaying
                          ? RadioPlayerUtils.player.stop()
                          : RadioPlayerUtils.player.play();
                    },
                    color: Colors.white,
                    iconSize: 30,
                    icon: const Icon(Icons.volume_up),
                  ),
                ],
              ),
            ],
          ),
        )),
        SlideTransition(
          position: radioListOffset,
          child: Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Radio List',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  indent: 30,
                  endIndent: 30,
                ),
                const Expanded(child: RadioStationListWidget())
              ],
            ),
          ),
        )
      ],
    );
  }
}
