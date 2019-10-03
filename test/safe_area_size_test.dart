import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safe_area_size/safe_area_size.dart';

void main() {
  const MethodChannel channel = MethodChannel('safe_area_size');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await SafeAreaSize.platformVersion, '42');
  });
}
