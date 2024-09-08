import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart'as tz;
import 'package:permission_handler/permission_handler.dart';

final notifications = FlutterLocalNotificationsPlugin();

initNotification(context) async {
  var androidSetting = AndroidInitializationSettings('app_icon');
//안드로이드용 알림 아이콘 파일 이름
  var iosSetting = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true
  );

  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
  var initializationSettings = InitializationSettings(
    android: androidSetting,
    iOS: iosSetting
  );
  await notifications.initialize(
      initializationSettings,
      onSelectNotification: (payload){//알람 눌렀을때 이 코드 실행.
        Navigator.push(
            context,
        MaterialPageRoute(
            builder: (context) => Text('새로운페이지 ')
        )
        );
  }
  );
}

/////
showNotification() async {
  var androidDetails = AndroidNotificationDetails(
      '유니크한 알림 ID',//and의 경우 알림채널 ID 기입 해주면 됨 .
      '알림종류 설명',//설명도 기입 해주면 됨 .
      priority: Priority.high,
      importance: Importance.max,
    //중요도. 에 따라서 소리여부, 팝업여부 결정가능
    color:  Color.fromARGB(255, 255, 0, 0),//알림 아이콘 색상.

  );
  var iosDetails = IOSNotificationDetails(
    presentAlert: true,//보여줄지
    presentBadge: true,//배지로 표현할지
    presentSound: true//소리 할지
  );
  notifications.show(
      1,//개별알림의 ID 숫자
      '제목',//알림의 제목과 내용
      '내용',
      NotificationDetails(android: androidDetails,iOS: iosDetails)
      ,payload: '부가정보'
  );
}

showNotification2() async{

  tz.initializeTimeZones();

  var androidDetails = const AndroidNotificationDetails(
  '유니크한 알림 ID',
  '알림 종류 설명',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0)
  );
  var iosDetails  = const IOSNotificationDetails(
      presentAlert: true,//보여줄지
      presentBadge: true,//배지로 표현할지
      presentSound: true//소리 할지
  );
  notifications.zonedSchedule(
      2,//개별알림의 ID 숫자
      '제목',//알림의 제목과 내용
      '내용',
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
      NotificationDetails(android: androidDetails,iOS: iosDetails),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time
  );

}
makeData(hour, min, sec){
  var now = tz.TZDateTime.now(tz.local);
  var when = tz.TZDateTime(tz.local,now.year, now.month, now.day, hour ,min, sec);
  if(when.isBefore(now)){
    return when.add(Duration(days: 1));
  }
  else{
    return when;
  }
}