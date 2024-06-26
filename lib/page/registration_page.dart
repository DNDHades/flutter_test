import 'package:flutter/material.dart';
import 'package:flutter02/http/dao/login_dao.dart';
import 'package:flutter02/util/toast.dart';
import 'package:flutter02/widget/appbar.dart';
import 'package:flutter02/widget/login_button.dart';
import 'package:flutter02/widget/login_effect.dart';
import 'package:flutter02/widget/login_input.dart';
import 'package:hi_base/string_util.dart';
import 'package:hi_net/core/hi_error.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;
  String? rePassword;
  String? imoocId;
  String? orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        // HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      }),
      body: Container(
        child: ListView(
          //自适应键盘弹起，防止遮挡
          children: [
            LoginEffect(
              protect: protect,
            ),
            LoginInput(
              onChanged: (text) {
                userName = text;
                checkInput();
              },
              title: '用户名',
              hint: '请输入用户名',
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
            LoginInput(
              title: '确认密码',
              hint: '请再次输入密码',
              lineStretch: true,
              obscureText: true,
              onChanged: (text) {
                rePassword = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            LoginInput(
              title: '慕课网ID',
              hint: '请输入你的慕课网用户ID',
              keyboardType: TextInputType.number,
              onChanged: (text) {
                imoocId = text;
                checkInput();
              },
            ),
            LoginInput(
              title: '课程订单号',
              hint: '请输入课程订单号后四位',
              keyboardType: TextInputType.number,
              lineStretch: true,
              onChanged: (text) {
                orderId = text;
                checkInput();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton('注册',
                  enable: loginEnable, onPressed: checkParams),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
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
      var result =
          await LoginDao.registration(userName!, password!, imoocId!, orderId!);
      print(result);
      if (result['code'] == 0) {
        print('注册成功');
        showToast('注册成功');
        // HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      } else {
        print(result['msg']);
        showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = '两次密码不一致';
    } else if (orderId?.length != 4) {
      tips = "请输入订单号的后四位";
    }
    if (tips != null) {
      print(tips);
      return;
    }
    send();
  }
}
