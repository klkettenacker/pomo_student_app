class Task {
  int pomo_count;
  int pomo_done = 0;
  String task_name;

  Duration focusTimeDuration = Duration(seconds: 3);
  Duration breakTimeDuration = Duration(seconds: 2);
  Duration longBreakTimeDuration = Duration(minutes: 30);

  bool isFinished = false;
  bool isBreakTime = false;

  double task_progress = 0.0;

  Task({this.pomo_count, this.task_name});

  Map taskSettings = {
    'focusTimeDuration': Duration(minutes: 25),
    'breakTimeDuration': Duration(minutes: 5),
    'longBreakTimeDuration': Duration(minutes: 30),
    'pomoSession': 4
  };
}
