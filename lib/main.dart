import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'logic/cubit/settings/settings_cubit.dart';
import 'presentation/screens/settings_screen.dart';
import 'presentation/screens/search_screen.dart';
import 'logic/cubit/weather/weather_cubit.dart';
import 'logic/repositories/weather_repository.dart';
import 'logic/services/https/weather_api_services.dart';

import '../presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        weatherApiServices: WeatherApiServices(
          client: Client(),
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => WeatherCubit(
              weatherRepository: ctx.read<WeatherRepository>(),
            ),
          ),
          BlocProvider(
            create: (ctx) => SettingsCubit(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
          routes: {
            SearchScreen.routName: (ctx) => SearchScreen(),
            SettingsScreen.rauteName: (ctx) => const SettingsScreen(),
          },
        ),
      ),
    );
  }
}
