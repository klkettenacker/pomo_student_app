import 'package:flutter/material.dart';
import '../services/task.dart';

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
                  fontSize: 30.0,
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: taskController,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'new task name...'),
              style: TextStyle(fontSize: 15.0),
            ),
            SizedBox(height: 70.0),
            Text(
              'pomo count',
              style: TextStyle(
                  fontSize: 28.0,
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 20.0),
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
                SizedBox(width: 20.0),
                Container(
                    alignment: Alignment.center,
                    width: 80.0,
                    child: Text(
                      pomo_counter.toString(),
                      style: TextStyle(
                        fontSize: 50.0,
                      ),
                    )),
                SizedBox(width: 20.0),
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
                Task newTask = new Task(
                    pomo_count: pomo_counter, task_name: taskController.text);

                Navigator.pop(context, newTask);
              },
            )
          ],
        ),
      ),
    );
  }
}
