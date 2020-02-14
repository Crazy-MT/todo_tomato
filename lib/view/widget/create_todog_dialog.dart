import 'package:flutter/material.dart';

class CreateToDogDialog extends StatefulWidget {
  @override
  _CreateToDogDialogState createState() => _CreateToDogDialogState();
}

class _CreateToDogDialogState extends State<CreateToDogDialog> {
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
              onChanged: (text) {//内容改变的回调
                print('change $text');
                todoContent = text;
              },
              onSubmitted: (text) {//内容提交(按回车)的回调
                print('submit $text');
                todoContent = text;
              },
              decoration: InputDecoration(hintText: 'Enter what to do ...'),
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
