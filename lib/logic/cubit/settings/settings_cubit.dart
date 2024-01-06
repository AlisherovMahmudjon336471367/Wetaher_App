import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState(tempUnit: TempUnits.selseius));

  void toggleTempereture() {
    if (state.tempUnit == TempUnits.selseius) {
      emit(const SettingsState(tempUnit: TempUnits.fahrenheit));
    } else {
      emit(const SettingsState(tempUnit: TempUnits.selseius));
    }
  }
}
