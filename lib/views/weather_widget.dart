import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather_library.dart';
import 'package:weather_app/views/value_tile.dart';

class WeatherWidget extends StatefulWidget {
  Weather weather;
  List<Weather> forecast;

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();

  WeatherWidget(this.weather, this.forecast);
}

class _WeatherWidgetState extends State<WeatherWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.forecast[0].date);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(
            widget.weather.areaName + ',',
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, top: 10),
          child: Text(
            widget.weather.country,
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, top: 10),
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width / 8,
            height: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, top: 10),
          child: Text(
            DateFormat('EEE , d MMMM ').format(DateTime.now()),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 10,
        ),
        Center(
          child: Column(
            children: <Widget>[
              Text(
                'Today',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    "http://openweathermap.org/img/wn/${widget.weather.weatherIcon}@4x.png",
                  ),
                  Text(
                    "${widget.weather.temperature.celsius.round()}°",
                    style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              Text(
                widget.weather.weatherDescription.toUpperCase(),
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 12,
        ),
        TabBar(
          labelPadding: EdgeInsets.only(left: 40),
          tabs: [Tab(text: 'Next 7 Days')],
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.transparent,
          unselectedLabelColor: Colors.blue.withOpacity(.95),
        ),
        Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
                  height: 70,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: widget.forecast.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 100,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    itemBuilder: (context, index) {
                      final item = widget.forecast[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                            child: ValueTile(
                          DateFormat('E, ha').format(item.date),
                          '${item.temperature.celsius.round()}°',
                          imageData:
                              "http://openweathermap.org/img/wn/${item.weatherIcon}@2x.png",
                        )),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
