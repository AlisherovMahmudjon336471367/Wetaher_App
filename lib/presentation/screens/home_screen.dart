import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/weather_menu.dart';
import '../widgets/city_part.dart';
import '../widgets/temperatura.dart';
import '../../logic/cubit/weather/weather_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _getWeather('london');
  }

  void _getWeather(String city) {
    context.read<WeatherCubit>().getWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (ctx, state) async {
          if (state is WeatherError) {
            await showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Error'),
                content: Text(state.messeage),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            if (state.messeage.toLowerCase().contains('not found')) {
              _getWeather('london');
            }
          }
        },
        builder: (ctx, state) {
          if (state is WeatherInitial) {
            return const Center(
              child: Text('Select a city'),
            );
          }
          if (state is WeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is WeatherLoaded) {
            final weather = state.weather;
            final mainWeather = weather.main.toLowerCase();
            String imagePath = '';

            if (mainWeather.contains('rain')) {
              imagePath = 'assets/rainy.jpg';
            } else if (mainWeather.contains('sun')) {
              imagePath = 'assets/sunny.jpg';
            } else if (mainWeather.contains('cloud')) {
              imagePath = 'assets/cloudy.jpeg';
            } else {
              imagePath = 'assets/night.jpg';
            }
            return Stack(
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
                Container(
                  color: Colors.black.withOpacity(0.4),
                ),
                Positioned(
                  right: 0,
                  top: 40,
                  child: WeatherMenu(
                    imagePath: imagePath,
                    getWeather: _getWeather,
                  ),
                ),
                SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CityPart(weather: weather),
                      Temperatura(weather: weather),
                    ],
                  ),
                )),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
