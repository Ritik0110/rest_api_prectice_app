import 'package:flutter/material.dart';

class ReusableRow extends StatelessWidget {
  const ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final int value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value.toString()),
            ],
          ),
          const Divider(thickness: 1.2),
        ],
      ),
    );
  }
}
