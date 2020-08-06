import 'package:flutter/material.dart';
import 'package:gait_mobile_app/views/history.dart';
import 'package:gait_mobile_app/views/logs.dart';
import 'package:gait_mobile_app/views/settings.dart';
import 'package:gait_mobile_app/util.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isRecording = false;
  int _selectedIndex = 0;
  int referenceTime = 0;
  int durationRecorded = 0;

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
                      trailing: Text(durationRecorded.toString() + " seconds"),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('Share'),
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
            SizedBox(height: 180),
            Text(
              isRecording ? 'Collecting data ...' : '',
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
                    
                    if(!isRecording)
                    {
                      // record time in seconds since that last 'local epoch' where the
                      // the this 'local epoch' is the reference time from when recording
                      // started
                      durationRecorded = durationRecorded + (getReferenceTime() - referenceTime);
                    } 
                    else 
                    {
                      referenceTime = getReferenceTime();
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
