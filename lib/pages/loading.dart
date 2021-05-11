import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:splashscreen/splashscreen.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SplashScreen(
          seconds: 14,
          navigateAfterSeconds: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
          title: new Text('Welcome In SplashScreen'),
          image: new Image.asset('screenshot.png'),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          loaderColor: Colors.red),
    ));
  }
}
