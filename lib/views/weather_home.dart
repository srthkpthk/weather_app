import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/repository/app_repository.dart';
import 'package:weather_app/views/weather_widget.dart';
import 'package:weather_app/weather/weather_bloc.dart';

class WeatherHome extends StatefulWidget {
  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  WeatherBloc _weatherBloc;
  AppRepository _repository = AppRepository();

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(_repository);
    getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.blue.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: BlocBuilder(
            bloc: _weatherBloc,
            // ignore: missing_return
            builder: (_, WeatherState state) {
              if (state is WeatherEmpty || state is WeatherLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is WeatherError) {
                return Center(
                  child: Text(
                    'There was an error',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                );
              } else if (state is WeatherLoaded) {
                return WeatherWidget(state.weather,state.forecast);
              }
            }),
      ),
    );
  }

  void getLocation() async {
    if (await Geolocator()
            .getLastKnownPosition(desiredAccuracy: LocationAccuracy.lowest) ==
        null) {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
      print(position);
      _weatherBloc.add(FetchWeather(position));
    } else {
      Position position = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.lowest);
      print("last $position");
      _weatherBloc.add(FetchWeather(position));
    }
  }

  void getPermission() async {
    Permission.location.request();
    _weatherBloc.add(LocationGranted());
    getLocation();
  }
}
