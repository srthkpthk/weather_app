part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class InitialWeatherState extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherError extends WeatherState {}

class WeatherLoaded extends WeatherState {
  Weather weather;
  List<Weather> forecast;

  WeatherLoaded(this.weather, this.forecast);
}

class WeatherEmpty extends WeatherState {}
