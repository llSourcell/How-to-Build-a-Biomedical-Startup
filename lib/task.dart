import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Task {
  int taskId;
  String label;
  bool complete;

  Task({this.taskId, this.label, this.complete = false});
}

class TaskWidget extends StatelessWidget {
  final String label;
  final VoidCallback onDelete;
  final VoidCallback onComplete;

  TaskWidget({this.label, this.onDelete, this.onComplete});

  Widget _buildDissmissibleBackground(
    {Color color,
      IconData icon,
      FractionalOffset align = FractionalOffset.centerLeft}) =>
    new Container(
      height: 42.0,
      color: color,
      child: new Icon(icon, color: Colors.white70),
      alignment: align,
    );

  bool test = false;

  @override
  Widget build(BuildContext context) {

    if(test = false) {
      test = true;
      return new Container(
          height: 42.0,
          child: new Dismissible(
              direction: DismissDirection.horizontal,
              child: new Align(
                  alignment: FractionalOffset.centerLeft,
                  child:
                  new Padding(
                      padding: new EdgeInsets.all(10.0), child: new Text(label, style: TextStyle(color: Colors.blue)))),
              key: new Key(label),
              background: _buildDissmissibleBackground(
                  color: Colors.lime, icon: Icons.check),
              secondaryBackground: _buildDissmissibleBackground(
                  color: Colors.red,
                  icon: Icons.delete,
                  align: FractionalOffset.centerRight),
              onDismissed: (direction) => direction == DismissDirection.startToEnd
                  ? onComplete()
                  : onDelete()));

    }
    else {
      test = false;
      return new Container(
          height: 42.0,
          child: new Dismissible(
              direction: DismissDirection.horizontal,
              child: new Align(
                  alignment: FractionalOffset.centerLeft,
                  child:
                  new Padding(
                      padding: new EdgeInsets.all(10.0), child: new Text(label, style: TextStyle(color: Colors.black)))),
              key: new Key(label),
              background: _buildDissmissibleBackground(
                  color: Colors.lime, icon: Icons.check),
              secondaryBackground: _buildDissmissibleBackground(
                  color: Colors.red,
                  icon: Icons.delete,
                  align: FractionalOffset.centerRight),
              onDismissed: (direction) => direction == DismissDirection.startToEnd
                  ? onComplete()
                  : onDelete()));


    }

  }
}
