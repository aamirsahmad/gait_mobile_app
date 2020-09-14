import 'package:flutter/material.dart';
import 'package:gait_mobile_app/views/history.dart';
import 'package:gait_mobile_app/views/logs.dart';
import 'package:gait_mobile_app/views/settings.dart';

import 'package:gait_mobile_app/util.dart';
import 'package:flutter/services.dart';

import 'dart:io' show Platform;

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isRecording = false;
  int _selectedIndex = 0;

  // used to dynamically track recorded time
  int referenceTime = 0;
  int timeDurationRecorded = 0;

  var iOSChannel = const MethodChannel("flutter.dev/accelerometerData");

  String _displayedMessage = "";

  Future<void> _storeAccelerometerInformation() async {
    String result = "";
    // 1. commit request to retreive accelerometer information from the IOS platform
    try {
      if (Platform.isAndroid) {
        // Android-specific code
      } else if (Platform.isIOS) {
        result = await iOSChannel.invokeMethod("storeAccelerometerData");
      }
    } on PlatformException catch (e) {
      result = e.message;
      // if there is an error, specify the appropriate error code
    }
    // 2. update the displayMessage based on the return from the IOS platform
    setState(() {
      _displayedMessage = result.toString();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _views = [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      title: Text('Last Data Collected'),
                    ),
                    const ListTile(
                      title: Text('Username'),
                      trailing: Text('Aamir Ahmad'),
                    ),
                    ListTile(
                      title: Text('Duration Recorded'),
                      trailing:
                          Text("${timeDurationRecorded.toString()} seconds"),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Text('Share'),
                          onPressed: () {},
                        ),
                        FlatButton(
                          child: const Text('Open'),
                          onPressed: () {},
                        ),
                        FlatButton(
                          child: const Text('Delete'),
                          textColor: Colors.red,
                          onPressed: () {},
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              isRecording ? 'Collecting data ...' : _displayedMessage,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 20),
            Transform.scale(
              scale: 2.0,
              child: Switch(
                value: isRecording,
                onChanged: (value) {
                  setState(() {
                    isRecording = !isRecording;

                    if (!isRecording) {
                      // record time in seconds since that last 'local epoch' where the
                      // the this 'local epoch' is the reference time from when recording
                      // started
                      timeDurationRecorded = timeDurationRecorded +
                          (getReferenceTime() - referenceTime);
                      // store and end the access to the acceleromter device
                      _storeAccelerometerInformation();

                      if (Platform.isAndroid) {
                        var androidMethodChannel = MethodChannel(
                            "com.example.gait_mobile_app.sensor");
                        Future result =
                            androidMethodChannel.invokeMethod("stopService");
                        result.then(
                            (value) => debugPrint("sensor service stopped"));
                      }
                    } else {
                      // write to the referenceTime variable
                      referenceTime = getReferenceTime();
                      // write an access event to the data access channel
//                      iOSChannel.invokeMethod("accessAccelerometerData");

                      if (Platform.isAndroid) {
                        // Android-specific code
                        var androidMethodChannel = MethodChannel(
                            "com.example.gait_mobile_app.sensor");
                        Future result =
                            androidMethodChannel.invokeMethod("startService");
                        result.then(
                            (value) => debugPrint("sensor service started"));
                      }
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
      History(),
      Logs(),
      Settings()
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor:
            isRecording ? Colors.green : Theme.of(context).appBarTheme.color,
      ),
      body: _views[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black45,
        elevation: 16,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('History'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bug_report),
            title: Text('Logs'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.greenAccent,
        onTap: _onItemTapped,
        iconSize: 35,
      ),
    );
  }
}
