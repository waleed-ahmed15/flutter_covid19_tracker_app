import 'dart:async';

import 'package:covid19_tracker_app/views/world_stats.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 4))
        ..repeat();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => WorldStatsScreen())),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              child: Container(
                  width: 200,
                  height: 200,
                  child: const Image(
                    image: AssetImage("images/virus.png"),
                  )),
              builder: (BuildContext context, Widget? child) {
                // print(_animationController.value);
                return Transform.rotate(
                  angle: _animationController.value * 3,
                  child: child,
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            const Center(
              child: Text(
                "Covid19\nTracker App",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            )
          ],
        ),
      ),
    );
  }
}
