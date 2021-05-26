import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/task.dart';
import 'package:simple_timer/simple_timer.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:wakelock/wakelock.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/permission_handler.dart';
import 'package:sizer/sizer.dart';

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
    Duration focusTime = task.taskSettings['focusTimeDuration'];
    Duration breakTime = task.taskSettings['breakTimeDuration'];
    Duration longBreakTime = task.taskSettings['longBreakTimeDuration'];
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
              isBreakTime = false;
              isLongBreakTime = false;
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

    void _setTimerWheel() {}

    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(''),
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 2.w, 0),
                child: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    String focusTimeInitialValue = task
                        .taskSettings['focusTimeDuration']
                        .abs()
                        .inMinutes
                        .toString();

                    String breakTimeInitialValue = task
                        .taskSettings['breakTimeDuration']
                        .abs()
                        .inMinutes
                        .toString();

                    String longBreakTimeInitialValue = task
                        .taskSettings['longBreakTimeDuration']
                        .abs()
                        .inMinutes
                        .toString();
                    //SETTINGS FOR POMO TASK
                    final _focusController =
                        TextEditingController(text: focusTimeInitialValue);
                    final _breakController = TextEditingController(
                      text: breakTimeInitialValue,
                    );
                    final _longBreakController = TextEditingController(
                      text: longBreakTimeInitialValue,
                    );
                    final _sessionController = TextEditingController(
                        text: task.taskSettings['pomoSession'].toString());

                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.sp),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Container(
                                height: 500,
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text('focus time',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              Container(
                                                width: 100,
                                                child: TextFormField(
                                                  controller: _focusController,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                  ),
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                          decimal: true),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            r'^\d+\.?\d{0,2}')),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Column(children: [
                                            Text('break time',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                            Container(
                                              width: 100,
                                              child: TextFormField(
                                                controller: _breakController,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                ),
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                          r'^\d+\.?\d{0,2}')),
                                                ],
                                              ),
                                            ),
                                          ]),
                                        ],
                                      ),
                                      SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text('rest time',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              Container(
                                                width: 100,
                                                child: TextFormField(
                                                  controller:
                                                      _longBreakController,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                  ),
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                          decimal: true),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            r'^\d+\.?\d{0,2}')),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10.w),
                                          Column(
                                            children: [
                                              Text('pomo session',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              Container(
                                                width: 100,
                                                child: TextFormField(
                                                  controller:
                                                      _sessionController,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                  ),
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                          decimal: true),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            r'^\d+\.?\d{0,2}')),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      ElevatedButton(
                                        child: Text('save'),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.red)),
                                        onPressed: () {
                                          setState(() {
                                            var newFocusTime = int.parse(
                                                _focusController.text
                                                    .toString());

                                            var newBreakTime = int.parse(
                                                _breakController.text
                                                    .toString());

                                            var newLongBreakTime = int.parse(
                                                _longBreakController.text
                                                    .toString());

                                            var newPomoSession = int.parse(
                                                _sessionController.text
                                                    .toString());

                                            var oldFocusTime = focusTime;
                                            var oldBreakTime = breakTime;
                                            var oldLongBreakTime =
                                                longBreakTime;

                                            focusTime = task.taskSettings[
                                                    'focusTimeDuration'] =
                                                Duration(minutes: newFocusTime);
                                            breakTime = task.taskSettings[
                                                    'breakTimeDuration'] =
                                                Duration(minutes: newBreakTime);
                                            longBreakTime = task.taskSettings[
                                                    'longBreakTimeDuration'] =
                                                Duration(
                                                    minutes: newLongBreakTime);

                                            task.taskSettings['pomoSession'] =
                                                newPomoSession;

                                            //WONT WORK IF TWO OF EACH HAS SAME VALUE
                                            if (_timerController.duration ==
                                                oldFocusTime) {
                                              _timerController.duration =
                                                  focusTime;
                                            } else if (_timerController
                                                    .duration ==
                                                oldBreakTime) {
                                              _timerController.duration ==
                                                  breakTime;
                                            } else if (_timerController
                                                    .duration ==
                                                oldLongBreakTime) {
                                              _timerController.duration ==
                                                  longBreakTime;
                                            }
                                            Navigator.pop(context);
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                )),
                          );
                        });
                  },
                ),
              )
            ],
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
                    height: 1.h,
                  ),
                  Text(task.pomo_done + 1 > task.pomo_count
                      ? 'finished'
                      : '${task.pomo_done + 1}/${task.pomo_count}'),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(isBreakTime
                      ? (isLongBreakTime)
                          ? 'time to rest.'
                          : 'break time.'
                      : 'focus.'),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    height: 40.h,
                    width: 70.w,
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
                          TextStyle(color: Colors.black, fontSize: 45.sp),
                      strokeWidth: 8.sp,
                      onEnd: () {
                        setState(() {
                          //CHECK IF PROGRESS GOES ABOVE 1.0 FOR PROGRESS INDICATOR IN HOME
                          if ((task.pomo_done / task.pomo_count).toDouble() <=
                              1.0) {
                            task.task_progress =
                                (task.pomo_done / task.pomo_count).toDouble();
                          }

                          if (task.task_progress > 1.0) {
                            task.task_progress = 1.0;
                          }

                          //Crappy condition if 2 durations are the same...fix later
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
                            if (task.pomo_done %
                                    task.taskSettings['pomoSession'] ==
                                0) {
                              isBreakTime = true;
                              isLongBreakTime = true;
                              _timerController.duration = longBreakTime;
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
                  SizedBox(height: 2.h),
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
                        iconSize: 50.sp,
                        alignment: Alignment.center,
                        icon: isPaused
                            ? Icon(Icons.pause)
                            : Icon(Icons.play_arrow),
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
                              if (task.pomo_done %
                                      task.taskSettings['pomoSession'] ==
                                  0) {
                                isBreakTime = true;
                                isLongBreakTime = true;
                                _timerController.duration = longBreakTime;
                              } else {
                                _timerController.duration = breakTime;
                                isBreakTime = true;
                              }
                            }

                            _timerController.reset();
                            isPaused = false;
                          });
                        }),
                  ]),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text('wake lock'),
                          SwitcherButton(
                            onColor: Colors.red,
                            offColor: Colors.black,
                            value: false,
                            onChange: (value) {
                              if (value == true) {
                                Wakelock.enable();
                              } else {
                                Wakelock.disable();
                              }

                              print(value);
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
