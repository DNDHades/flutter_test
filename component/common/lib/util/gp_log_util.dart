import 'package:flutter/foundation.dart';

class GpLogUtil {
  static const String _tagDefault = 'LOG=====';
  static const String _tagDnd = 'Dnd=====';


  // 通用的私有静态方法
  static void _printLog(String tag, String message) {
      if (kDebugMode) {
        print('[$tag] $message');
    }
  }
  // 公开的日志输出方法
  static void d(String message, {String tag = _tagDnd}) {
    _printLog(tag, message);
  }

  static void e(String message, {String tag = _tagDnd}) {
    _printLog(tag, message);
  }

  static void ld(String message, {String tag = _tagDefault}) {
    _printLog(tag, message);
  }

  static void le(String message, {String tag = _tagDefault}) {
    _printLog(tag, message);
  }

}