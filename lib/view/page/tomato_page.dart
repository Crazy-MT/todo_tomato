import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture_samples/model/holder/fav_holder.dart';
import 'package:flutter_architecture_samples/utils/system_util.dart';
import 'package:flutter_architecture_samples/view/page/page_state.dart';
import 'package:flutter_architecture_samples/view/widget/custom_app_bar.dart';
import 'package:flutter_architecture_samples/view/widget/flip_panel.dart';
import 'package:flutter_architecture_samples/view/widget/loading_view.dart';
import 'package:flutter_architecture_samples/viewmodel/web_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../language.dart';

class TomatoClockPage<T> extends StatefulWidget {
  @override
  State createState() => CustomWebViewState();
}

class CustomWebViewState<T> extends PageState<TomatoClockPage> {
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
    return WillPopScope(
      child: Scaffold(
        key: scafKey,
        backgroundColor: Colors.black,
        appBar: CustomAppBar(
          title: Text(
            '番茄钟',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          color: Theme.of(context).accentColor,
          leftBtn: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () async {
              pop(context);
            },
          ),
        ),
        body: Center(
          child: SizedBox(
            height: (getScreenWidth(context) / 4 - 20) * 2 + 1,
            child: FlipClock.countdown(
              duration: Duration(minutes: 25),
              digitColor: Colors.white,
              backgroundColor: Colors.black,
              digitSize: getScreenWidth(context) / 5,
              borderRadius: const BorderRadius.all(Radius.circular(3.0)),
              width: getScreenWidth(context) / 5,
              height: (getScreenWidth(context) / 4 - 20) * 2,
              onDone: () => print('ih'),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        pop(context);
        return false;
      },
    );
  }
}
