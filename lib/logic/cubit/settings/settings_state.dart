part of 'settings_cubit.dart';

enum TempUnits {
  selseius,
  fahrenheit,
}

@immutable
class SettingsState {
  final TempUnits? tempUnit;

  const SettingsState({this.tempUnit});
}
