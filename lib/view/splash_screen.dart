import 'dart:async';

import 'package:covid_tracking_app/view/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
    AnimationController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =  AnimationController(vsync: this, duration: const Duration(seconds: 5))..repeat();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const WorldStatesScreen())));
  }

    @override
    dispose() {
      _controller?.dispose(); // you need this
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
                animation: _controller!,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/virus.png"))),
                ),
                builder: (context, child) {
                  return Transform.rotate(
                    angle: (_controller?.value)! * math.pi * 2,
                    child: child,
                  );
                }),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text("Covid -19\n Tracker App",style: TextStyle(color: Colors.white,fontSize: 18),textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
