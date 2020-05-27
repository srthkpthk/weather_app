import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather/weather_library.dart';
import 'package:weather_app/repository/app_repository.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  AppRepository _appRepository;

  WeatherBloc(this._appRepository);

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final Weather _weather =
            await _appRepository.getWeather(event.position);
        print(_weather);
        final List<Weather> _forecast =
            await _appRepository.getForecast(event.position);
        print(_forecast);
        yield WeatherLoaded(_weather, _forecast);
      } catch (_) {
        yield WeatherError();
      }
    }
  }
}
