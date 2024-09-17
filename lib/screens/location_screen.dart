import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/zipcode.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  const LocationScreen({super.key, this.locationWeather});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int? temperature;
  String? cityName;
  String? weatherIcon;
  String? weatherMessage;
  String? inWord;
  List? codes;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        inWord = '';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);

      cityName = weatherData['name'];
      inWord = 'in';

      weatherMessage = weather.getMessage(temperature!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              var weatherData = await weather.getLocationWeather();
              updateUI(weatherData);
            },
            child: const Icon(
              Icons.near_me,
              size: 40,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey[600],
              ),
              child: const Text(
                'Clima App',
                style: TextStyle(fontSize: 35),
              ),
            ),
            ListTile(
              title: const Text('City weather'),
              onTap: () async {
                var typedName = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CityScreen(),
                  ),
                );
                if (typedName != null) {
                  var weatherData = await weather.getCityWeather(typedName);
                  updateUI(weatherData);
                }
                Navigator.pop(context);
              },
              leading: Icon(Icons.location_city),
            ),
            Visibility(
              visible: false,
              child: ListTile(
                title: const Text('ZipCode weather'),
                onTap: () async {
                  var typedName = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Zipcode(),
                    ),
                  );
                  if (typedName != null) {
                    var weatherData =
                        await weather.getZipWeather(typedName[0], typedName[1]);
                    updateUI(weatherData);
                  }
                  Navigator.pop(context);
                },
                leading: Icon(Icons.pin_drop_outlined),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text('$temperature°', style: kTempTextStyle),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  '$weatherMessage $inWord $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
