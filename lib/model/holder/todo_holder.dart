import 'dart:async';
import 'dart:convert';

import 'package:flutter_architecture_samples/common/streams.dart';
import 'package:flutter_architecture_samples/model/data/read_data.dart';
import 'package:flutter_architecture_samples/model/data/todo_data.dart';
import 'package:flutter_architecture_samples/model/holder/shared_depository.dart';

class TodoHolder<T> {
  static final TodoHolder _holder = TodoHolder._internal();

  factory TodoHolder() => _holder;

  final List<TodoData> _cache = List();
  final _todoReadBroadcast = StreamController<List<TodoData>>();
  Stream<List<TodoData>> todoDataStream;

  TodoHolder._internal() {
    todoDataStream = _todoReadBroadcast.stream.asBroadcastStream();

    _init();
  }

  void _init() async {
    final readValue = SharedDepository().todoData;
    if (readValue != null) {
      final list =
          (jsonDecode(readValue) as List).map((v) => TodoData.fromJson(v));
      _cache.addAll(list);
    }
    streamAdd(_todoReadBroadcast, _cache);
  }

  /// 添加或取消收藏
  void addTodo(T t) async {
    if (t == null) return;

    if (t is TodoData) {
        _cache.add(t);

      streamAdd(_todoReadBroadcast, _cache);
      await SharedDepository().setTodoReadData(json.encode(_cache));
    }
  }

  void removeTodo(T t) async {
    if (t == null) return;

    if (t is TodoData) {
      _cache.removeWhere((v) => v.time == t.time);

      streamAdd(_todoReadBroadcast, _cache);
      await SharedDepository().setTodoReadData(json.encode(_cache));
    }
  }

  List<TodoData> get todoData => _cache;

  void dispose() {
    _cache.clear();
    _todoReadBroadcast.close();
  }
}
