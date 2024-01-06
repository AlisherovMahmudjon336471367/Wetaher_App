import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/settings/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const rauteName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListTile(
        title: const Text(
          'Temperatura Unit',
        ),
        subtitle: const Text(' Celsius / Fahrenheit (default: Celsius)'),
        trailing: Switch.adaptive(
          value: context.watch<SettingsCubit>().state.tempUnit ==
                  TempUnits.selseius
              ? true
              : false,
          onChanged: (value) {
            context.read<SettingsCubit>().toggleTempereture();
          },
        ),
      ),
    );
  }
}
