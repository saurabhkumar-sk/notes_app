import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/weathbloc/bloc/weather_bloc.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Text(
          'Weather Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitial) {
                  return const Text('Press the button to fetch weather');
                } else if (state is WeatherLoading) {
                  return const CircularProgressIndicator();
                } else if (state is WeatherLoaded) {
                  return Column(
                    children: [
                      Text(
                        'Weather in ${state.weather.name}',
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Temperature: ${(state.weather.main!.temp! - 273.15).toStringAsFixed(2)} °C',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Condition: ${state.weather.weather![0].description}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Humidity: ${state.weather.main!.humidity}%',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                } else if (state is WeatherError) {
                  return Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Fetch weather when button is pressed
                context.read<WeatherBloc>().add(FetchWeather());
              },
              child: const Text('Fetch Weather'),
            ),
          ],
        ),
      ),
    );
  }
}
