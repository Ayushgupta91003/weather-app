import 'package:flutter/material.dart';

class HourlyForecaseItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;
  const HourlyForecaseItem({super.key, required this.time, required this.icon, required this.temperature});

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
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            Icon(icon, size: 32),
            const SizedBox(
              height: 5,
            ),
            Text(temperature),
          ],
        ),
      ),
    );
  }
}
