import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  const AdditionalInfoItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(Icons.water_drop, size: 32),
        SizedBox(
          height: 8,
        ),
        Text(
          "Humidity",
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "94",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
