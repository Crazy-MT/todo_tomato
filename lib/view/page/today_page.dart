import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/common/colors.dart';
import 'package:flutter_architecture_samples/language.dart';
import 'package:flutter_architecture_samples/model/holder/event_send_holder.dart';
import 'package:flutter_architecture_samples/view/page/read_content_page.dart';
import 'package:flutter_architecture_samples/view/page/today_list_page.dart';
import 'package:flutter_architecture_samples/view/widget/custom_app_bar.dart';

class TodayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: <Widget>[
          CustomAppBar(
            title: Text(
              AppText.of(context).today,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            color: Theme.of(context).accentColor,
            leftBtn: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () => EventSendHolder()
                  .sendEvent(tag: "homeDrawerOpen", event: true),
            ),
            bottom: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              isScrollable: true,
              tabs: [
                Tab(text: AppText.of(context).todayTodoList),
                Tab(text: AppText.of(context).todayAllList),
                Tab(text: AppText.of(context).todayLifeList),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColor.colorRead,
              child: TabBarView(
                children: [
                  TodayListPage(
                    key: Key("ReadContentPagewow"),
                    typeUrl: "wow",
                  ),
                  ReadContentPage(
                    key: Key("ReadContentPageapps"),
                    typeUrl: "apps",
                  ),
                  ReadContentPage(
                    key: Key("ReadContentPageimrich"),
                    typeUrl: "imrich",
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
