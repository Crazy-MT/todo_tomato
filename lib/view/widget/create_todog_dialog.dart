import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/model/data/life_todo_data.dart';
import 'package:flutter_architecture_samples/model/data/today_todo_data.dart';
import 'package:flutter_architecture_samples/model/data/todo_data.dart';
import 'package:flutter_architecture_samples/model/holder/life_holder.dart';
import 'package:flutter_architecture_samples/model/holder/today_todo_holder.dart';
import 'package:flutter_architecture_samples/model/holder/todo_holder.dart';
import 'package:flutter_architecture_samples/utils/system_util.dart';

class CreateToDoDialog extends StatefulWidget {

  String type;

  CreateToDoDialog({@required this.type});

  @override
  _CreateToDoDialogState createState() => _CreateToDoDialogState();
}

class _CreateToDoDialogState extends State<CreateToDoDialog> {
  String todoContent;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              onChanged: (text) { //内容改变的回调
                print('change $text');
                todoContent = text;
              },
              onSubmitted: (text) { //内容提交(按回车)的回调
                print('submit $text');
                todoContent = text;
              },
              decoration: InputDecoration(hintText: '输入待办事情'),
            ),
            Center(
              child: StreamBuilder<bool>(
                  builder: (context, snapshot) {
                    return RaisedButton.icon(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      icon: Icon(
                        Icons.add,
                        size: 14,
                      ),
                      label: Text('添加待办'),
                      onPressed: () {
                        print(todoContent);
                        switch(widget.type) {
                          case "today":
                            TodayTodoHolder().addTodo(TodayTodoData(currentTimeMillis(), todoContent));
                            TodoHolder().addTodo(TodoData(currentTimeMillis(), todoContent));
                            break;

                          case "all":
                            TodoHolder().addTodo(TodoData(currentTimeMillis(), todoContent));
                            break;

                          case "life":
                            LifeHolder().addTodo(LifeData(currentTimeMillis(), todoContent));
                            break;
                        }
                        pop(context);
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
