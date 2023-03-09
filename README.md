# onscreen_logger
This package helps log your exceptions and results to your UI Screen.

[![](https://media.giphy.com/media/KatEI8Ayd47Z6F3FRG/giphy.gif)](https://media.giphy.com/media/KatEI8Ayd47Z6F3FRG/giphy.gif)



### Onscreen Logger Integration.

------------

Implement OnScreen Logger with very minimal lines of code. Follow Below steps?





### Steps 1 : Changes In Main.dart .
------------
```OnScreenDebugWidget``` should be added to ```builder``` property of   ```Material App```. should look similar to below code.
```dart
builder: (context, child) {
        return OnScreenDebugWidget(
          child: child ?? const SizedBox(),
        );
},
```
Once your done with this changes, your ```MyApp``` will look something like this.

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Example',
      builder: (context, child) {
        return OnScreenDebugWidget(
          child: child ?? const SizedBox(),
        );
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.homeScreen,
      routes: AppRoutes.getRoutes(),
    );
  }
}
```
### Steps 2 : Log your Results To Screen.
------------
You can log anything to Onscreen. As given In below code
```dart
DebugLog debugLog = DebugLog(logTitle: "Title Of Log",dateTime: DateTime.now());
debugLog.logStrings.add(DebugLogString(logTitle: "Url",logsDescription: "dioUrl"));
debugLog.logStrings.add(DebugLogString(logTitle: "request",logsDescription: "request"));
debugLog.setAsRed();
OnScreenDebugUtils.onScreenDebugLogController.addDebugLog(debugLog);
```
In above code ```setAsRed()``` sets the log in red color. There are few more options to it ```setAsRed()```,```setAsGreen()```,```setAsBlue()```,```setAsYellow()```
#### Help.

------------

You can email me to nikhilishwar2@gmail.com if any update or suggestion required and also support me with this project.

