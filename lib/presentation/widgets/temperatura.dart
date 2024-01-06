import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/weather.dart';
import '../../logic/cubit/settings/settings_cubit.dart';

class Temperatura extends StatefulWidget {
  const Temperatura({
    super.key,
    required this.weather,
  });

  final Weather weather;

  @override
  State<Temperatura> createState() => _TemperaturaState();
}

class _TemperaturaState extends State<Temperatura> {
  String _showTemperatura(double temp) {
    final tempUnit = context.watch<SettingsCubit>().state.tempUnit;

    if (tempUnit == TempUnits.fahrenheit) {
      return '${(temp * 9 / 5 + 32).toStringAsFixed(0)}℉';
    }

    return '${temp.toStringAsFixed(0)}℃';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _showTemperatura(widget.weather.temperature),
          style: const TextStyle(
            fontSize: 70,
            color: Colors.white,
            height: 0.1,
          ),
        ),
        Row(
          children: [
            Image.network(
              'https://openweathermap.org/img/wn/${widget.weather.icon}.png',
              width: 60,
              height: 60,
            ),
            Text(
              widget.weather.main,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
