import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_upgrade/flutter_app_upgrade.dart';
import 'package:flutter_study/component/http/HttpRequests.dart';
import 'package:flutter_study/component/log/Logs.dart';
import 'package:flutter_study/constant/HttpConstant.dart';
import 'package:flutter_study/constant/RouteNameConstant.dart';
import 'package:flutter_study/model/AppVersionResult.dart';

class Settings extends StatefulWidget {
  @override
  _Settings createState() => new _Settings();
}

class _Settings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage("assets/images/user_null.png"))
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text("[未登录]")],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ListTile(
              title: Text("检查更新"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                AppUpgrade.appUpgrade(
                  context,
                  _checkAppInfo(),
                  iosAppId: 'id1345678',
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ListTile(
              title: Text("开发者工具"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(RouteNameConstant.route_name_setting_develop);
              },
            ),
          ),
        ]),
      ),
    );
  }

  Future<AppUpgradeInfo> _checkAppInfo() async {
    int version = 0;
    String url = HttpConstant.url_tv_version_check
        .replaceAll("{version}", version.toString());
    Logs.info('_checkAppInfo url=' + url);
    return await HttpRequests
        .get(url, null, null)
        .then((restResult) {
      Logs.info('_onRefresh responseBody=' + restResult?.responseBody);
      if (restResult.responseBody.isNotEmpty) {
        AppVersionResult result =
        AppVersionResult.fromJson(json.decode(restResult?.responseBody));
        if (result?.code == 200) {
          return AppUpgradeInfo(
            title: result.data.versionName,
            contents: result.data.description.split("|"),
            force: false,
            apkDownloadUrl: HttpRequests.rebuildUrl(result.data.fileUrl),
          );
        }
      }
      return AppUpgradeInfo(
        title: '检查更新',
        contents: ['此版本已是最新版本'],
        force: false,
      );
    });
  }

}
