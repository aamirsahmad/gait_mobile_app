import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _userId;
  double _samplingRate = 50;
  double _sensorDelay = 0;
  String _ip;
  String _port;
  bool _isStreaming = false;

  // text field controllers
  final userIdCtl = TextEditingController();
  final ipCtl = TextEditingController();
  final portCtl = TextEditingController();

  void displayBottomSheet(BuildContext context, Widget widget) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: widget,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      backgroundColor: Theme.of(context).canvasColor,
      sections: [
        SettingsSection(
          title: 'User information',
          tiles: [
            SettingsTile(
              title: 'User ID',
              subtitle: userIdCtl.text,
              leading: Icon(Icons.language),
              onTap: () {
                Widget innerWidget = TextField(
                  controller: userIdCtl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: userIdCtl.text),
                );
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('User ID'),
                        content: innerWidget,
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          new FlatButton(
                            child: new Text("Save"),
                            onPressed: () {
                              setState(() {
                                _userId = userIdCtl.text;
                              });
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'Sensor',
          tiles: [
            SettingsTile(
              title: 'Sampling Rate (Hz)',
              subtitle: _samplingRate.floor().toString(),
              leading: Icon(Icons.autorenew),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Slider(
                    value: _samplingRate,
                    onChanged: (newSamplingRate) {
                      setState(() {
                        _samplingRate = newSamplingRate;
                      });
                    },
                    label: "$_samplingRate",
//                  divisions: 5,
                    min: 1,
                    max: 120,
                  )
                ],
              ),
              onTap: () {},
            ),
            SettingsTile(
                title: 'Sensor Initial Delay (s)',
                subtitle: _sensorDelay.floor().toString(),
                leading: Icon(Icons.access_time),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Slider(
                      value: _sensorDelay,
                      onChanged: (newSensorDelay) {
                        setState(() {
                          _sensorDelay = newSensorDelay;
                        });
                      },
                      label: "$_sensorDelay",
                      divisions: 10,
                      min: 0,
                      max: 10,
                    )
                  ],
                )),
          ],
        ),
        SettingsSection(
          title: 'Connection',
          tiles: [
            SettingsTile(
                title: 'IP Address',
                subtitle: ipCtl.text,
                leading: Icon(Icons.settings_input_antenna),
                onTap: () {
                  Widget innerWidget = TextField(
                    controller: ipCtl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: ipCtl.text),
                  );
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('IP Address'),
                          content: innerWidget,
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            new FlatButton(
                              child: new Text("Save"),
                              onPressed: () {
                                setState(() {
                                  _ip = ipCtl.text;
                                });
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                }),
            SettingsTile(
                title: 'Port',
                subtitle: portCtl.text,
                leading: Icon(Icons.import_export),
                onTap: () {
                  Widget innerWidget = TextField(
                    controller: portCtl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: portCtl.text),
                  );
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Port'),
                          content: innerWidget,
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            new FlatButton(
                              child: new Text("Save"),
                              onPressed: () {
                                setState(() {
                                  _port = portCtl.text;
                                });
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                }),
            SettingsTile.switchTile(
              title: 'Stream to cloud',
              leading: Icon(Icons.cloud_upload),
              switchValue: _isStreaming,
              onToggle: (bool value) {
                setState(() {
                  _isStreaming = !_isStreaming;
                });
              },
            ),
          ],
        ),
        SettingsSection(title: 'About', tiles: [
          SettingsTile(
            title: 'Version',
            subtitle: '0.0.1',
          )
        ])
      ],
    );
  }
}
