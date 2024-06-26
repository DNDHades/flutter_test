import 'package:common/util/gp_log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter02/widget/appbar.dart';
import 'package:hi_base/string_util.dart';
import 'package:hi_net/core/hi_error.dart';

import '../http/dao/login_dao.dart';
import '../util/toast.dart';
import '../widget/login_button.dart';
import '../widget/login_effect.dart';
import '../widget/login_input.dart';

///登录页面
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('密码登录', '注册', () {
        // HiNavigator.getInstance().onJumpTo(RouteStatus.registration);
      }, key: const Key('registration')),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              onChanged: (text) {
                userName = text;
                checkInput();
              },
              title: '用户名',
              hint: '请输入用户',
            ),
            LoginInput(
              obscureText: true,
              onChanged: (text) {
                password = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
              title: '密码',
              hint: '请输入密码',
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: LoginButton(
                  '登录',
                  enable: loginEnable,
                  onPressed: send,
                ))
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    try {
      var result = await LoginDao.login(userName!, password!);
      GpLogUtil.ld(result);
      if (result['code'] == 0) {
        GpLogUtil.ld("登录成功");
        showToast('登录成功');
        // HiNavigator.getInstance().onJumpTo(RouteStatus.home);
      } else {
        GpLogUtil.ld(result['msg']);
        showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      GpLogUtil.ld(e.message);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      GpLogUtil.ld(e.message);
      showWarnToast(e.message);
    }
  }
}
