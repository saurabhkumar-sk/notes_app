import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notesapp/model/model.dart';
import 'package:notesapp/widgets/weatherapi.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final Repo weatherRepo;

  WeatherBloc(this.weatherRepo) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await weatherRepo.getWeather();
        if (weather != null) {
          emit(WeatherLoaded(weather));
        } else {
          emit(WeatherError("Failed to fetch weather data"));
        }
      } catch (e) {
        emit(WeatherError("Error: ${e.toString()}"));
      }
    });
  }
}
