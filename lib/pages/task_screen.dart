import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/task.dart';
import 'package:simple_timer/simple_timer.dart';
import 'dart:math' as math;

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  bool isBreakTime = false;

  bool isLongBreakTime = false;

  //FOR BUTTON
  bool isPaused = false;

  TimerController _timerController;
  TimerStyle _timerStyle = TimerStyle.ring;
  TimerProgressIndicatorDirection _progressIndicatorDirection =
      TimerProgressIndicatorDirection.clockwise;
  TimerProgressTextCountDirection _progressTextCountDirection =
      TimerProgressTextCountDirection.count_down;

  void initState() {
    // TODO: implement initState
    _timerController = TimerController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Task task = ModalRoute.of(context).settings.arguments as Task;
    Duration focusTime = Duration(seconds: 3);
    Duration breakTime = Duration(seconds: 2);
    Duration longBreakTime = Duration(seconds: 4);
    Duration currentDuration = focusTime;

    task.task_progress = (task.pomo_done / task.pomo_count).toDouble();

    CupertinoAlertDialog finishedTaskDialog = CupertinoAlertDialog(
      title: Text('Congrats on finishing your task!'),
      content: Text('Add one more pomo?'),
      actions: [
        CupertinoDialogAction(
          child: Text('+1'),
          onPressed: () {
            setState(() {
              task.pomo_count += 1;
              task.isFinished = false;
            });
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text('Done'),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context, task);
          },
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  task.task_name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(task.pomo_done + 1 > task.pomo_count
                  ? 'finished'
                  : '${task.pomo_done + 1}/${task.pomo_count}'),
              SizedBox(
                height: 40.0,
              ),
              Text(isBreakTime
                  ? (isLongBreakTime)
                      ? 'time to rest.'
                      : 'break time.'
                  : 'focus.'),
              SizedBox(
                height: 5.0,
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: SimpleTimer(
                  duration: currentDuration,
                  controller: _timerController,
                  timerStyle: _timerStyle,
                  backgroundColor: (isBreakTime)
                      ? (isLongBreakTime)
                          ? Colors.purple
                          : Colors.blue
                      : Colors.red,
                  progressIndicatorColor: Colors.black,
                  progressIndicatorDirection: _progressIndicatorDirection,
                  progressTextCountDirection: _progressTextCountDirection,
                  progressTextStyle:
                      TextStyle(color: Colors.black, fontSize: 70.0),
                  strokeWidth: 10,
                  onEnd: () {
                    setState(() {
                      if ((task.pomo_done / task.pomo_count).toDouble() <=
                          1.0) {
                        task.task_progress =
                            (task.pomo_done / task.pomo_count).toDouble();
                      }

                      if (task.task_progress > 1.0) {
                        task.task_progress = 1.0;
                      }
                      print(task.task_progress);

                      if (_timerController.duration == focusTime) {
                        task.pomo_done += 1;
                      }

                      if (task.pomo_done >= task.pomo_count) {
                        task.isFinished = true;
                      }

                      if (task.isFinished == true) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => finishedTaskDialog);
                      }

                      if (isBreakTime == true) {
                        _timerController.duration = focusTime;
                        isBreakTime = false;
                        isLongBreakTime = false;
                      } else {
                        if (task.pomo_done % task.taskSettings['pomoSession'] ==
                            0) {
                          isBreakTime = true;
                          isLongBreakTime = true;
                          _timerController.duration = longBreakTime;

                          print('SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS');
                        } else {
                          _timerController.duration = breakTime;
                          isBreakTime = true;
                        }
                      }

                      _timerController.reset();
                      print('bruh $isPaused');
                      isPaused = !isPaused;
                      print('dude $isPaused');
                    });
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                  icon: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Icon(Icons.refresh)),
                  onPressed: () {
                    _timerController.reset();
                  },
                ),
                //SizedBox(width: 20),
                IconButton(
                    iconSize: 80.0,
                    alignment: Alignment.center,
                    icon: isPaused ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                    onPressed: () {
                      setState(() {
                        isPaused
                            ? _timerController.pause()
                            : _timerController.start();
                        isPaused = !isPaused;
                        print(isPaused);
                      });
                    }),
                IconButton(
                    icon: Icon(Icons.skip_next),
                    onPressed: () {
                      setState(() {});
                    }),
              ])
            ],
          )),
    );
  }
}
