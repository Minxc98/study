import 'package:flutter/material.dart';
import 'package:tutorials/component/log/logs.dart';
import 'package:tutorials/locale/translations.dart';
import 'package:tutorials/request/model/profile/ProfileAcitvityRequest.dart';
import 'package:tutorials/request/origin/profile_activity_result.dart';
import 'package:tutorials/request/profile_activity_request.dart';
import 'package:tutorials/utils/log_utils.dart';

class ProfileActivity extends StatefulWidget {
  const ProfileActivity({Key? key}) : super(key: key);

  @override
  _ProfileActivityState createState() => _ProfileActivityState();
}

class _ProfileActivityState extends State<ProfileActivity> {
  List<String> images = [];
  bool _isLoading = false;
  Profile? _profileInfo = null;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  Future<Null> _onRefresh() async {
    showLoading();
    ProfileAcitvityRequest requestParam = new ProfileAcitvityRequest();
    ProfileActivityRequests.query(requestParam).then((result) {
      Logs.info('_onRefresh responseBody=' + (result?.toString() ?? ""));
      hideLoading();
      setState(() {
        if (result.code == 200) {
          _profileInfo = result.data?.profile;
        }
      });
    }).catchError((error) {
      LogUtils.info(error.toString());
      hideLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.textOf(context, "profile.title")),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
          children: <Widget>[
            ListView(
              children: [
                SizedBox(height: 8),
                Padding(
                  padding:
                      EdgeInsets.only(left: 48, right: 168, top: 16, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Logs.info("GetIt.I.get<NavigationService>().back();");
                        },
                        child: ClipOval(
                          child: Image(
                              image: AssetImage("assets/images/user_null.png")),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _profileInfo?.name ?? '未登录',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.location_on),
                                Text(
                                  _profileInfo?.location ?? '上海',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _profileInfo?.starCounts?.toString() ?? '10',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "关注",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _profileInfo?.followerCounts?.toString() ?? '100',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "粉丝",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _profileInfo?.feedbackCounts?.toString() ?? '120',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "留言",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 32),
                Container(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Text(
                    "简介",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffA8A8A8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  padding: EdgeInsets.only(left: 24, right: 25, bottom: 18),
                  child: Text(
                    _profileInfo?.desc ??
                        "看了这组照片,网友们也明白了,为什么很多大牌商品喜欢请神仙姐姐去做代言了,因为她只要站在那里,隔着屏幕都能感受到满满的高级感。 别看这次出游,刘亦菲表现得十分欢脱,吃了很多美食...",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.57,
                      color: Color(0XFF000000),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.only(left: 24, right: 25, bottom: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.photo),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    "最新动态",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Container(
                              height: 2,
                              width: 76,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 13, right: 11),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                    children: List.generate(
                      images.length,
                      (index) {
                        return Container(
                          height: 122,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(images[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Container(
              child: _isLoading
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}