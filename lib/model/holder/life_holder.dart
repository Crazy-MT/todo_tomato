import 'dart:async';
import 'dart:convert';

import 'package:flutter_architecture_samples/common/streams.dart';
import 'package:flutter_architecture_samples/model/data/life_todo_data.dart';
import 'package:flutter_architecture_samples/model/data/read_data.dart';
import 'package:flutter_architecture_samples/model/data/todo_data.dart';
import 'package:flutter_architecture_samples/model/holder/shared_depository.dart';

class LifeHolder<T> {
  static final LifeHolder _holder = LifeHolder._internal();

  factory LifeHolder() => _holder;

  final List<LifeData> _cache = List();
  final _todoReadBroadcast = StreamController<List<LifeData>>();
  Stream<List<LifeData>> todoDataStream;

  LifeHolder._internal() {
    todoDataStream = _todoReadBroadcast.stream.asBroadcastStream();

    _init();
  }

  void _init() async {
    final readValue = SharedDepository().lifeData;
    if (readValue != null) {
      final list =
          (jsonDecode(readValue) as List).map((v) => LifeData.fromJson(v));
      _cache.addAll(list);
    }
    streamAdd(_todoReadBroadcast, _cache);
  }

  /// 添加或取消收藏
  void addTodo(T t) async {
    if (t == null) return;

    if (t is LifeData) {
        _cache.add(t);

      streamAdd(_todoReadBroadcast, _cache);
      await SharedDepository().setLifeTodoData(json.encode(_cache));
    }
  }

  void removeTodo(T t) async {
    if (t == null) return;

    if (t is LifeData) {
      _cache.removeWhere((v) => v.time == t.time);

      streamAdd(_todoReadBroadcast, _cache);
      await SharedDepository().setLifeTodoData(json.encode(_cache));
    }
  }

  List<LifeData> get todoData => _cache;

  void dispose() {
    _cache.clear();
    _todoReadBroadcast.close();
  }
}
