import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Heroo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            GestureDetector(
            onTap: () {
              Navigator.pop(context);
                   },
              child: Container(
                height: 300,   // 👈 give it height
                width: 300,    // 👈 give it width
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.blue,
                      Colors.purple,
                      Colors.red,
                    ],
                    stops: [0.0, 0.5, 1.0],
                    center: Alignment.center,
                    radius: 0.8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
