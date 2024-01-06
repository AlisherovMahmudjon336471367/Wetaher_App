import 'package:flutter/material.dart';
import '../screens/search_screen.dart';
import '../screens/settings_screen.dart';

class WeatherMenu extends StatelessWidget {
  final Function getWeather;
  const WeatherMenu(
      {super.key, required this.imagePath, required this.getWeather});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            final _city =
                await Navigator.of(context).pushNamed(SearchScreen.routName);
            if (_city != null) {
              getWeather(_city as String);
            }
          },
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(SettingsScreen.rauteName);
          },
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
