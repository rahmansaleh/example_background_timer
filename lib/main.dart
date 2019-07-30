import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      ),
      home: MyHomePageLess(),
    );
  }
}

class MyHomePageLess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePageFul();
  }
}

class MyHomePageFul extends StatefulWidget {
  @override
  _MyHomePageFulState createState() => _MyHomePageFulState();
}

class _MyHomePageFulState extends State<MyHomePageFul> with WidgetsBindingObserver {

  Timer _timer;

  

  Future<bool> post(int value) async {

    // var response = await http.get("http://demokab.rujukan.net/api/STIJesika/xpushLocation.php?data=a");
    // print("response.statusCode:${response.statusCode}");
    // print("response.body:${response.body}");

    var client = new http.Client();
    
    try {

      var uriResponse  = await client.get("http://demokab.rujukan.net/api/STIJesika/xpushLocation.php?data=$value");
      print(uriResponse.body);
    } finally {
      client.close();
    }

    return true;
  }

  postLocation() {

    int value = new Random().nextInt(100);
    print("Function loaded with value :$value");
    post(value);
  }

  void stop_timer() {
    _timer.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if( state != AppLifecycleState.resumed ) {
      _timer.cancel();
    } else {
      if(!_timer.isActive) {
        _timer = Timer.periodic(Duration(seconds: 3), (timer) {
          postLocation();
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      postLocation();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: (){
        print("timer stopped");
        _timer.cancel();
        return Future.value(true);
      },
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: const Color(0x00000000),
          title: new Text("Fisrt Activity"),
          leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            color: const Color(0xFFFFFFFF),
            onPressed: () => Navigator.pop(context),
          ),
        ),

        body: new Center(
          child: new FlatButton(
            child: new Text(
              "Move To Second Activity"
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext _) => ActivitySecondLess())),
          ),
        ),
        
      ),
    );
    
  }
}

class ActivitySecondLess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ActivitySecondFul();
  }
}

class ActivitySecondFul extends StatefulWidget {
  @override
  _ActivitySecondFulState createState() => _ActivitySecondFulState();
}

class _ActivitySecondFulState extends State<ActivitySecondFul> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: const Color(0x00000000),
        title: new Text("Second Activity"),
        leading: new IconButton(
          icon: Icon(Icons.arrow_back),
          color: const Color(0xFFFFFFFF),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: new Center(
        child: new FlatButton(
          child: new Text(
            'Move to Activity Thrird'
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext _) => new ActivityThirdLess())),
        )
      ),
      
    );
  }
}

class ActivityThirdLess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ActivityThirdFul(
      
    );
  }
}

class ActivityThirdFul extends StatefulWidget {
  @override
  _ActivityThirdFulState createState() => _ActivityThirdFulState();
}

class _ActivityThirdFulState extends State<ActivityThirdFul> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: const Color(0x00000000),
        title: new Text("Third Activity"),
        leading: new IconButton(
          icon: Icon(Icons.arrow_back),
          color: const Color(0xFFFFFFFF),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: new Center(
        child: new Text(
          'BODY CENTER'
        ),
      ),
      
    );
  }
}