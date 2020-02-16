import 'dart:async';

import 'package:flutter_architecture_samples/common/streams.dart';
import 'package:flutter_architecture_samples/model/data/read_data.dart';
import 'package:flutter_architecture_samples/model/data/todo_data.dart';
import 'package:flutter_architecture_samples/model/holder/fav_holder.dart';
import 'package:flutter_architecture_samples/model/holder/todo_holder.dart';
import 'package:flutter_architecture_samples/viewmodel/viewmodel.dart';

class AllViewModel extends ViewModel {
  final data = StreamController<List<TodoData>>();

  AllViewModel() {
    bindSub(TodoHolder().todoDataStream.listen((list) => streamAdd(data, list)));
    streamAdd(data, TodoHolder().todoData);
  }

  @override
  void dispose() {
    data.close();

    super.dispose();
  }

  removeTodo(TodoData data) {
    TodoHolder().removeTodo(data);
  }
}
