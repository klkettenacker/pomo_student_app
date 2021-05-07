import 'package:flutter/material.dart';
import 'package:pomo_student_app/pages/create_task.dart';
import 'package:pomo_student_app/pages/task_screen.dart';
import './pages/home.dart';
import './pages/loading.dart';
import './util/constants.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/home',
      theme: ThemeData(
          primaryColor: COLOR_WHITE,
          accentColor: COLOR_DARK_BLUE,
          textTheme: TEXT_THEME_DEFAULT,
          fontFamily: 'Poppins'),
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/create': (context) => CreateTask(),
        '/task': (context) => TaskScreen()
      },
    ));
