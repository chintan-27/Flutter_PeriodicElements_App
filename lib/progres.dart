import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newapp/fadein.dart';

class Progress extends StatefulWidget{
  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return FadeIn(1,Container(
      child: Center(
        child: SpinKitWave(
          color: Colors.greenAccent,
          size: 100,
          controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
        ),
      ),
    )
    );
  }
}
