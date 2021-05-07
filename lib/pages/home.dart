import 'package:flutter/material.dart';
import 'package:pomo_student_app/pages/task_screen.dart';
import '../util/constants.dart';
import '../services/task.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> taskList = [];

  String _day = '';
  String _month = '';
  String _year = '';
  String _dayOfWeek = '';

  void _getTime() {
    final String day = DateFormat('dd').format(DateTime.now()).toString();
    final String month =
        DateFormat('MMM').format(DateTime.now()).toString().toLowerCase();
    final String year = DateFormat('yyyy').format(DateTime.now()).toString();
    final String dayOfWeek =
        DateFormat('EEEE').format(DateTime.now()).toString().toLowerCase();

    setState(() {
      _day = day;
      _month = month;
      _year = year;
      _dayOfWeek = dayOfWeek;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                  child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                    child: Text(_day,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 40.0,
                            letterSpacing: -2.0)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_month,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20.0,
                                letterSpacing: -2.0,
                                height: 0.0)),
                        Text(_year,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20.0,
                                letterSpacing: -2.0))
                      ],
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(100.0, 0.0, 0.0, 0.0),
                    child: Text(_dayOfWeek,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 30.0,
                            letterSpacing: -.5)),
                  ))
                ],
              )),
              Divider(),
              Expanded(
                child: taskListView(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Future.delayed(Duration.zero, () {
            Navigator.of(context)
                .pushNamed(
              '/create',
            )
                .then((value) {
              if (value != null) {
                setState(() {
                  taskList.add(value);
                });
              }
            });
          });
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  ListView taskListView() {
    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (_, index) {
        if (taskList[index] == null) {
          print(taskList[index]);
          print(index);
        } else {
          return ListTile(
              title: Text(
                taskList[index].task_name,
                style: TextStyle(color: Colors.black, fontSize: 15.0),
              ),
              leading: CircularPercentIndicator(
                radius: 30.0,
                lineWidth: 5.0,
                percent: taskList[index].task_progress,
                progressColor: Colors.red,
                backgroundColor: Colors.grey,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/task',
                        arguments: taskList[index])
                    .then((value) {
                  setState(() {
                    taskList[index].task_progress;
                  });
                });
              });
        }
      },
    );
  }
}
