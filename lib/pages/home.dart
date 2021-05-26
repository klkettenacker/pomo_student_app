import 'package:flutter/material.dart';
import 'package:pomo_student_app/pages/task_screen.dart';
import '../util/constants.dart';
import '../services/task.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> taskList = [];

  List<Task> _archivedTasks = [];

  Task removedTask;
  int deletedIndex;

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
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
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
                              fontSize: 30.sp,
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
                                  fontSize: 15.sp,
                                  letterSpacing: -2.0,
                                  height: 0.0)),
                          Text(_year,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  letterSpacing: -2.0))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40.0, 0.0, 00.0, 0.0),
                      child: Text(_dayOfWeek,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20.sp,
                              letterSpacing: -.5)),
                    ),
                    IconButton(
                        icon: Icon(Icons.article_sharp),
                        onPressed: () {
                          _pushArchived();
                        })
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
        floatingActionButton: Container(
          width: 15.w,
          height: 15.h,
          child: FloatingActionButton(
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
            child: Icon(
              Icons.add,
              size: 30.0,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

  ListView taskListView() {
    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (_, index) {
        if (taskList[index] == null) {
          print('NULL TASK LIST');
        } else {
          return Slidable(
            key: Key(taskList[index].task_name),
            dismissal: SlidableDismissal(
              child: SlidableDrawerDismissal(),
              onDismissed: (actionType) {
                setState(() {});
              },
            ),
            actionPane: SlidableBehindActionPane(),
            actionExtentRatio: 0.25,
            actions: <Widget>[
              IconSlideAction(
                color: Colors.grey[700],
                icon: Icons.archive,
                onTap: () {
                  setState(() {
                    removedTask = taskList[index];
                    _archivedTasks.add(removedTask);
                    taskList.removeAt(index);
                    final snackBar = SnackBar(
                      content: Text('Successfuly archived!'),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    setState(() {
                      removedTask = taskList[index];
                      taskList.removeAt(index);

                      final snackBar = SnackBar(
                        content: Text('Successfuly deleted!'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  })
            ],
            child: ListTile(
                title: Text(
                  taskList[index].task_name,
                  style: TextStyle(
                      decoration: taskList[index].isFinished
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: taskList[index].isFinished
                          ? Colors.grey
                          : Colors.black,
                      fontSize: 17.0),
                ),
                leading: CircularPercentIndicator(
                  radius: 30.0,
                  lineWidth: 5.0,
                  percent: taskList[index].task_progress,
                  progressColor: Colors.red,
                  backgroundColor: Colors.grey,
                ),
                tileColor: Theme.of(context).scaffoldBackgroundColor,
                onTap: () {
                  Navigator.pushNamed(context, '/task',
                          arguments: taskList[index])
                      .then((value) {
                    setState(() {
                      if (taskList[index].isFinished == true) {}
                    });
                  });
                }),
          );
        }
      },
    );
  }

  void _pushArchived() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _archivedTasks.map((Task task) {
        return ListTile(
            title: Text(task.task_name, style: TextStyle(fontSize: 18)));
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(title: Text('Archived Tasks')),
          body: ListView(children: divided));
    }));
  }
}
