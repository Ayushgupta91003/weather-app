import 'dart:convert';
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
  // double temp = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentWeather();
  // }

  Future getCurrentWeather() async {
    try {
      String cityName = "London";
      final res = await http.get(
        Uri.parse(
            "https://https://api.openweathermap.org/data/2.5/forecast?q=London&APPID=f2b537edf488645da488c19f303260f3"),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw "an unexpected error occured";
      }
      return data;
      // setState(() {
      //   temp = data["list"][0]["main"]["temp"];
      // });
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
          print(snapshot);
          print(snapshot.runtimeType);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text(snapshot.hasError.toString());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "200 K",
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Icon(
                                Icons.cloud,
                                size: 64,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Rain",
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                        icon: Icons.water_drop, label: "Humidity", value: "94"),
                    AdditionalInfoItem(
                        icon: Icons.air, label: "Wind Speed", value: "7.67"),
                    AdditionalInfoItem(
                        icon: Icons.beach_access,
                        label: "Pressure",
                        value: "1000"),
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
