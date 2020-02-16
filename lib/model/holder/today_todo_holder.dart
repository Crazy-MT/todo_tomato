import 'dart:async';
import 'dart:convert';

import 'package:flutter_architecture_samples/common/streams.dart';
import 'package:flutter_architecture_samples/model/data/read_data.dart';
import 'package:flutter_architecture_samples/model/data/today_todo_data.dart';
import 'package:flutter_architecture_samples/model/data/todo_data.dart';
import 'package:flutter_architecture_samples/model/holder/shared_depository.dart';

class TodayTodoHolder<T> {
  static final TodayTodoHolder _holder = TodayTodoHolder._internal();

  factory TodayTodoHolder() => _holder;

  final List<TodayTodoData> _cache = List();
  final _todoReadBroadcast = StreamController<List<TodayTodoData>>();
  Stream<List<TodayTodoData>> todoDataStream;

  TodayTodoHolder._internal() {
    todoDataStream = _todoReadBroadcast.stream.asBroadcastStream();

    _init();
  }

  void _init() async {
    final readValue = SharedDepository().todayData;
    if (readValue != null) {
      final list =
          (jsonDecode(readValue) as List).map((v) => TodayTodoData.fromJson(v));
      _cache.addAll(list);
    }
    streamAdd(_todoReadBroadcast, _cache);
  }

  /// 添加或取消收藏
  void addTodo(T t) async {
    if (t == null) return;

    if (t is TodayTodoData) {
        _cache.add(t);

      streamAdd(_todoReadBroadcast, _cache);
      await SharedDepository().setTodayTodoData(json.encode(_cache));
    }
  }

  void removeTodo(T t) async {
    if (t == null) return;

    if (t is TodayTodoData) {
      _cache.removeWhere((v) => v.time == t.time);

      streamAdd(_todoReadBroadcast, _cache);
      await SharedDepository().setTodayTodoData(json.encode(_cache));
    }
  }

  List<TodayTodoData> get todoData => _cache;

  void dispose() {
    _cache.clear();
    _todoReadBroadcast.close();
  }
}
