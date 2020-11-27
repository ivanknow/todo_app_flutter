import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/util/dbhelper.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();
}

class TodoListState extends State {
  DBHelper _helper = DBHelper();
  List<Todo> todos;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (todos == null) {
      todos = List<Todo>();
      getData();
    }

    return Scaffold(
      body: todoListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: "new",
        child: Icon(Icons.add),
      ),
    );
  }

  ListView todoListItems() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int position) {
        return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text(this.todos[position].id.toString()),
                ),
                title: Text(this.todos[position].title),
                subtitle: Text(
                  this.todos[position].date,
                ),
                onTap: () {
                  debugPrint("TAP ID:" + this.todos[position].id.toString());
                }));
      },
      itemCount: count,
    );
  }

  void getData() {
    final dbFuture = _helper.initDB();
    dbFuture.then((result) {
      final todosFuture = _helper.getTodoItems();
      todosFuture.then((result) {
        List<Todo> todoList = List<Todo>();

        for (int i = 0; i < result.length - 1; i++) {
          var item = result[i];
          todoList.add(Todo.fromObject(item));
          debugPrint(todoList[i].title);
        }

        setState(() {
          todos = todoList;
          count = todoList.length;
          debugPrint("count:" + count.toString());
        });

        debugPrint("total:" + todoList.length.toString());
      });
    });
  }
}
