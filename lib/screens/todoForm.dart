import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class TodoForm extends StatefulWidget {
  final Todo todo;
  TodoForm(this.todo);

  @override
  State<StatefulWidget> createState() => TodoFormState(todo);
}

class TodoFormState extends State {
  Todo todo;
  TodoFormState(this.todo);
  final _priorities = ["High", "Medium", "Low"];
  String _priority = "Low";
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleCtrl.text = todo.title;
    descCtrl.text = todo.description;
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          TextField(
            controller: titleCtrl,
            style: textStyle,
            decoration: InputDecoration(
                labelText: "Title",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          ),
          TextField(
            controller: descCtrl,
            style: textStyle,
            decoration: InputDecoration(
                labelText: "Description",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          ),
          DropdownButton<String>(
              items: _priorities.map((String value) {
                return DropdownMenuItem<String>(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              style: textStyle,
              value: _priority,
              onChanged: null)
        ],
      ),
    );
  }
}
