import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math' as math;
import 'home.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();
  @override
  void initState() {
    Timer(
        Duration(seconds: 10),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*Animated Covid Img start here*/
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  child: const Center(
                    child: Image(
                      image: AssetImage('images/mlogo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                }),
            /*Animated Covid Img end here*/
            /*
            /*first portion start here*/
            Image.asset(
              'images/mlogo.png',
              height: 240,
              width: 240,
            ),
            /*first portion end here*/
            */
            /*second portion start here*/
            Text(
              'Weather App',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            /*second portion end here*/
            SizedBox(
              height: 30,
            ),
            /*third portion start here*/
            SpinKitWave(
              color: Colors.white,
              size: 50.0,
            ),
            /*third portion end here*/
          ],
        ),
      ),
    );
  }
}
