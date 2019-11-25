import 'dart:async';

import 'package:flutter/services.dart';

class SafeAreaSize {
  static const MethodChannel _channel = const MethodChannel('safe_area_size');

  /// Return the status bar size
  static Future<int> get statusBarSize async {
    final int statusBarHeight = await _channel.invokeMethod('getStatusBar');
    return statusBarHeight;
  }

  /// Return the navigationBarSize
  static Future<int> get navigationBarSize async {
    final int navigationBarSize =
        await _channel.invokeMethod('getNavigationBar');
    return navigationBarSize;
  }

  /// Return the displayCutoutSize
  static Future<int> get displayCutoutSize async {
    final int displayCutoutSize =
        await _channel.invokeMethod('getDisplayCutout');
    return displayCutoutSize;
  }
}
