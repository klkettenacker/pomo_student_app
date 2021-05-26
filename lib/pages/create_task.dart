import 'package:flutter/material.dart';
import '../services/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  int pomo_counter = 0;
  final taskController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose

    taskController.dispose();
    pomo_counter = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CupertinoAlertDialog nullPomoCountDialog = CupertinoAlertDialog(
      title: Text("Pomo Count can't be 0"),
      actions: [
        CupertinoDialogAction(
          child: Text('OK'),
          onPressed: () {
            setState(() {});
            Navigator.pop(context);
          },
        )
      ],
    );

    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(""),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Text(
                'new pomo task',
                style: TextStyle(
                    fontSize: 22.sp,
                    height: 0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 4.h),
              TextFormField(
                controller: taskController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'new task name...'),
                style: TextStyle(fontSize: 15.0),
              ),
              SizedBox(height: 5.h),
              Text(
                'pomo count',
                style: TextStyle(
                    fontSize: 20.sp,
                    height: 0.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(Icons.exposure_minus_1),
                      onPressed: () {
                        setState(() {
                          if (pomo_counter == 0) {
                          } else {
                            pomo_counter -= 1;
                          }
                        });
                      }),
                  SizedBox(width: 4.w),
                  Container(
                      alignment: Alignment.center,
                      width: 30.w,
                      child: Text(
                        pomo_counter.toString(),
                        style: TextStyle(
                          fontSize: 25.sp,
                        ),
                      )),
                  SizedBox(width: 4.w),
                  IconButton(
                      icon: Icon(Icons.exposure_plus_1),
                      onPressed: () {
                        setState(() {
                          pomo_counter += 1;
                        });
                      }),
                ],
              ),
              TextButton(
                child: Text(
                  'confirm',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  if (pomo_counter <= 0) {
                    print('bruh');
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => nullPomoCountDialog);
                  }

                  Task newTask = new Task(
                      pomo_count: pomo_counter, task_name: taskController.text);

                  Navigator.pop(context, newTask);
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
