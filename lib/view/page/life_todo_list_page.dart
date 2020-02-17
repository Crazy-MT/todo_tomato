import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/common/colors.dart';
import 'package:flutter_architecture_samples/common/keep_alive_mixin.dart';
import 'package:flutter_architecture_samples/language.dart';
import 'package:flutter_architecture_samples/model/data/life_todo_data.dart';
import 'package:flutter_architecture_samples/model/data/read_data.dart';
import 'package:flutter_architecture_samples/model/data/todo_data.dart';
import 'package:flutter_architecture_samples/utils/system_util.dart';
import 'package:flutter_architecture_samples/view/page/page_state.dart';
import 'package:flutter_architecture_samples/view/page/webview_page.dart';
import 'package:flutter_architecture_samples/view/widget/create_todog_dialog.dart';
import 'package:flutter_architecture_samples/view/widget/loading_view.dart';
import 'package:flutter_architecture_samples/view/widget/net_image.dart';
import 'package:flutter_architecture_samples/viewmodel/life_viewmodel.dart';
import 'package:flutter_architecture_samples/viewmodel/read_viewmodel.dart';
import 'package:flutter_architecture_samples/viewmodel/all_viewmodel.dart';
import 'package:flutter_architecture_samples/viewmodel/viewmodel.dart';

class LifeTodoListPage extends StatefulWidget {
  final String type;

  LifeTodoListPage({Key key, @required this.type}) : super(key: key);

  @override
  State createState() => ReadContentState();
}

/// 继承[MustKeepAliveMixin]实现页面切换不被清理
class ReadContentState extends PageState<LifeTodoListPage>
    with MustKeepAliveMixin {
  final _viewModel = LifeViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _viewModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      key: scafKey,
      body: StreamBuilder(
        stream: _viewModel.data.stream,
        builder: (context, snapshot) {
          final List<LifeData> datas = snapshot.data ?? [];

          return Stack(
            children: <Widget>[
              // 有内容时的显示
              datas.isNotEmpty
                  ? ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: const ClampingScrollPhysics()),
                padding: const EdgeInsets.only(),
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key("Dismissible${datas[index].time}"),
                    child: _buildReadItem(
                        data: datas[index], index: index + 1),
                    onDismissed: (_) => _viewModel.removeTodo(datas[index]),
                  );
                },
              )
                  : Container(),

              // 占位
              datas.isEmpty
                  ? Container(
                alignment: Alignment.center,
                child: Text(
                  AppText.of(context).listEmpty,
                  style:
                  TextStyle(fontSize: 16, color: AppColor.colorText3),
                ),
              )
                  : Container()
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _onActionTap,
        tooltip: 'Increment',
        child: Icon(Icons.add),
        heroTag: "life_list_page",
      ), // This tra
    );
  }

  _onActionTap() {
    showDialog(
        context: context,
        builder: (context) {
          return CreateToDoDialog(type: widget.type);
        });
  }

  Widget _buildReadItem({@required LifeData data, @required int index}) {
    return Card(
      color: Colors.white,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.fromLTRB(8, 6, 8, 6),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${data.content}",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 16, color: AppColor.colorText1),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: data.time),
                        ],
                        style:
                            TextStyle(fontSize: 12, color: AppColor.colorText2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
