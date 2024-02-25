import 'package:flutter/material.dart';



class HourlyForecaseItem extends StatelessWidget {
  const HourlyForecaseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        child: const Column(
          children: [
            Text(
              "03:00",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            Icon(Icons.cloud, size: 32),
            SizedBox(
              height: 5,
            ),
            Text("320.12"),
          ],
        ),
      ),
    );
  }
}