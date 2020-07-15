import 'package:flutter/material.dart';

class History extends StatelessWidget {
  final List<String> litems = ["1", "2", "Third", "4"];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: litems.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    title: Text('Username'),
                    trailing: Text('Lorem ipsum'),
                  ),
                  const ListTile(
                    title: Text('Date'),
                    trailing: Text('2020 07 14'),
                  ),
                  const ListTile(
                    title: Text('Duration'),
                    trailing: Text('5 minutes and 10 seconds'),
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
          );
        });
  }
}
