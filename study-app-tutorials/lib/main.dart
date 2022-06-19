import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tutorials/component/permission/PermissionHelper.dart';
import 'package:tutorials/constant/route_constant.dart';
import 'package:tutorials/locale/SupportedLocales.dart';
import 'package:tutorials/locale/Translations.dart';
import 'package:tutorials/route/route.dart';
import 'package:tutorials/startup/Application.dart';
import 'package:tutorials/component/log/Logs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '小陆'),
      // routes: RouteConfiguration.routes,

      // 路由
      onGenerateRoute: RouteConfiguration.onGenerateRoute,

      locale: SupportedLocales.defaultLocale, //手动指定locale

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        TranslationsDelegate.delegate,
      ],
      supportedLocales: SupportedLocales.locales,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key,required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPermission();
  }

  void checkPermission() async {
    bool isGranted = await PermissionHelper.requestPermissions()??false;
    Logs.info('isGranted0 = ' + isGranted.toString());

    if (isGranted) {
      Application.init(context);
      Navigator.of(context).pop(1);
      toDefaultPage();
    } else {
      Navigator.of(context).pop(1);
    }
  }

  void toDefaultPage() {
    Navigator.of(context).pushNamed(RouteNameConstant.route_name_login, arguments: "hi");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the toHome method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(Translations.textOf(context,"main.title"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toDefaultPage,
        tooltip: 'Main',
        child: Icon(Icons.arrow_forward_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}