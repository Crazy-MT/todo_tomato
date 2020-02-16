import 'dart:async';

import 'package:flutter_architecture_samples/common/streams.dart';
import 'package:flutter_architecture_samples/model/data/life_todo_data.dart';
import 'package:flutter_architecture_samples/model/data/read_data.dart';
import 'package:flutter_architecture_samples/model/data/today_todo_data.dart';
import 'package:flutter_architecture_samples/model/data/todo_data.dart';
import 'package:flutter_architecture_samples/model/holder/fav_holder.dart';
import 'package:flutter_architecture_samples/model/holder/life_holder.dart';
import 'package:flutter_architecture_samples/model/holder/today_todo_holder.dart';
import 'package:flutter_architecture_samples/model/holder/todo_holder.dart';
import 'package:flutter_architecture_samples/viewmodel/viewmodel.dart';

class TodayViewModel extends ViewModel {
  final data = StreamController<List<TodayTodoData>>();

  TodayViewModel() {
    bindSub(TodayTodoHolder().todoDataStream.listen((list) => streamAdd(data, list)));
    streamAdd(data, TodayTodoHolder().todoData);
  }

  @override
  void dispose() {
    data.close();

    super.dispose();
  }

  removeTodo(TodayTodoData data) {
    TodayTodoHolder().removeTodo(data);
  }
}
