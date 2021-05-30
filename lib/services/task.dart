class Task {
  int pomo_count;
  int pomo_done = 0;
  String task_name;

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
// Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Column(
//                                             children: [
//                                               Text('focus time',
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: Colors.black)),
//                                               Container(
//                                                 width: 100,
//                                                 child: TextFormField(
//                                                   controller: _focusController,
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                     fontSize: 15.sp,
//                                                   ),
//                                                   keyboardType: TextInputType
//                                                       .numberWithOptions(
//                                                           decimal: true),
//                                                   inputFormatters: [
//                                                     FilteringTextInputFormatter
//                                                         .allow(RegExp(
//                                                             r'^\d+\.?\d{0,2}')),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             width: 40,
//                                           ),
//                                           Column(children: [
//                                             Text('break time',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.black)),
//                                             Container(
//                                               width: 100,
//                                               child: TextFormField(
//                                                 controller: _breakController,
//                                                 textAlign: TextAlign.center,
//                                                 style: TextStyle(
//                                                   fontSize: 15.sp,
//                                                 ),
//                                                 keyboardType: TextInputType
//                                                     .numberWithOptions(
//                                                         decimal: true),
//                                                 inputFormatters: [
//                                                   FilteringTextInputFormatter
//                                                       .allow(RegExp(
//                                                           r'^\d+\.?\d{0,2}')),
//                                                 ],
//                                               ),
//                                             ),
//                                           ]),
//                                         ],
//                                       ),
//                                       SizedBox(height: 30),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Column(
//                                             children: [
//                                               Text('rest time',
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: Colors.black)),
//                                               Container(
//                                                 width: 100,
//                                                 child: TextFormField(
//                                                   controller:
//                                                       _longBreakController,
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                     fontSize: 15.sp,
//                                                   ),
//                                                   keyboardType: TextInputType
//                                                       .numberWithOptions(
//                                                           decimal: true),
//                                                   inputFormatters: [
//                                                     FilteringTextInputFormatter
//                                                         .allow(RegExp(
//                                                             r'^\d+\.?\d{0,2}')),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(width: 10.w),
//                                           Column(
//                                             children: [
//                                               Text('pomo session',
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: Colors.black)),
//                                               Container(
//                                                 width: 100,
//                                                 child: TextFormField(
//                                                   controller:
//                                                       _sessionController,
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                     fontSize: 15.sp,
//                                                   ),
//                                                   keyboardType: TextInputType
//                                                       .numberWithOptions(
//                                                           decimal: true),
//                                                   inputFormatters: [
//                                                     FilteringTextInputFormatter
//                                                         .allow(RegExp(
//                                                             r'^\d+\.?\d{0,2}')),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
