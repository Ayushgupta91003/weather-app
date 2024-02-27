import 'dart:convert';
// import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
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
  final cityName = "Ahmedabad";
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final res = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=f2b537edf488645da488c19f303260f3",
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
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cityName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
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
                    "Weather Forecast",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HourlyForecaseItem(
                        time: "00:00",
                        icon: Icons.cloud,
                        temperature: "301.22",
                      ),
                      HourlyForecaseItem(
                        time: "03:00",
                        icon: Icons.sunny,
                        temperature: "300.52",
                      ),
                      HourlyForecaseItem(
                        time: "06:00",
                        icon: Icons.cloud,
                        temperature: "302.22",
                      ),
                      HourlyForecaseItem(
                        time: "09:00",
                        icon: Icons.sunny,
                        temperature: "300.12",
                      ),
                      HourlyForecaseItem(
                        time: "12:00",
                        icon: Icons.cloud,
                        temperature: "304.12",
                      ),
                    ],
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
