import 'dart:convert';
// import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/additional_info_item.dart';
import 'package:weather/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final cityName = "London";
  late Future<Map<String, dynamic>> weather;
  Future<Map<String, dynamic>> getCurrentWeather() async {
    // final weather = getCurrentWeather();
    try {
      final res = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey",
        ),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        // throw data['message'];   // it's a key on the page.
        throw "An unexpected error occured";
      }
      return data;
    } catch (e) {
      throw e.toString();
    }

    // print(res.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          // print(snapshot);
          // print(snapshot.runtimeType);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          final data = snapshot.data!;
          final currWeatherData = data['list'][0];
          final currentTemp = currWeatherData['main']['temp'];
          final currentSky = currWeatherData["weather"][0]["main"];
          final currentPressure = currWeatherData['main']['pressure'];
          final currentWindSpeed = currWeatherData['wind']["speed"];
          final currentHumidity = currWeatherData['main']['humidity'];
          // final cityName = "Ahmedabad";
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     cityName,
                //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                //   ),
                // ),
                SizedBox(
                  width: double.infinity,
                  // height: 250,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "$currentTemp K",
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Icon(
                                currentSky == "Clouds" || currentSky == "Rain"
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 64,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                "$currentSky",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Hourly Forecast",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 0; i < 39; i++)
                //         HourlyForecaseItem(
                //           time: data["list"][i + 1]['dt'].toString(),
                //           icon: data["list"][i + 1]["weather"][0]["main"] ==
                //                       "Clouds" ||
                //                   data["list"][i + 1]["weather"][0]["main"] ==
                //                       "Rain"
                //               ? Icons.cloud
                //               : Icons.sunny,
                //           temperature:
                //               data["list"][i + 1]['main']['temp'].toString(),
                //         ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final hourlyForecast = data['list'][index + 1];
                      final hourlySky =
                          data["list"][index + 1]["weather"][0]["main"];
                      final hourlyTemperature =
                          hourlyForecast['main']['temp'].toString();
                      final time = DateTime.parse(hourlyForecast['dt_txt']);
                      return HourlyForecastItem(
                        time: DateFormat.j().format(time),
                        // time: DateFormat('j').format(time),
                        temperature: hourlyTemperature,
                        icon: hourlySky == "Clouds" || hourlySky == "Rain"
                            ? Icons.cloud
                            : Icons.sunny,
                      );
                    },
                  ),
                ),

                const SizedBox(
                  height: 22,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Additional Information",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: currentHumidity.toString()),
                    AdditionalInfoItem(
                        icon: Icons.air,
                        label: "Wind Speed",
                        value: currentWindSpeed.toString()),
                    AdditionalInfoItem(
                        icon: Icons.beach_access,
                        label: "Pressure",
                        value: currentPressure.toString()),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

/*

 // Padding(
            
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     height: 205,
          //     width: 400,
          //     decoration: BoxDecoration(
          //         color: Color.fromARGB(80, 100, 100, 100),
          //         shape: BoxShape.rectangle,
          //         borderRadius: BorderRadius.circular(15)),
          //     child: const Padding(
          //       padding: EdgeInsets.all(8.0),
          //       child: Column(
          //         children: [
          //           Text(
          //             "300.67\u00B0F",
          //             style: TextStyle(
          //                 fontSize: 40,
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.w500),
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           Icon(
          //             Icons.cloud,
          //             size: 75,
          //             color: Color.fromARGB(250, 255, 255, 255),
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           Text(
          //             "Rain",
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 20,
          //               fontWeight: FontWeight.w300,
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        
*/
