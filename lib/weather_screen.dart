import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather/additional_info_item.dart';
import 'package:weather/hourly_forecast_item.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
      body: Padding(
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
                            "300.67\u00B0F",
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
                  HourlyForecaseItem(),
                  HourlyForecaseItem(),
                  HourlyForecaseItem(),
                  HourlyForecaseItem(),
                  HourlyForecaseItem(),
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
                AdditionalInfoItem(),
                AdditionalInfoItem(),
                AdditionalInfoItem(),
              ],
            )
          ],
        ),
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
