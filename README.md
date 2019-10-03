# Safe Area Size

A plugin to get the SafeArea size using platform channels, making it easy to design around SafeArea's limitations.

## Why?

The way [SafeArea](https://api.flutter.dev/flutter/widgets/SafeArea-class.html) is designed, 
if you insert it into your root structure, you no longer have access to changes of MediaQuery Insets or Padding.

So I've made this plugin to work around this limitation, allowing access to these values anyway.

## How?

Make it a dependency inside your application: 
```
dependencies:
  safe_area_size: 0.1.0
```

Import it:

```dart
import 'package:safe_area_size/safe_area_size.dart';
```


Make one `async` method inside your widget that makes use of the included platform channel calls:

```dart
Future<void> initPlatformState() async {
    int navigationBarHeight;
    int statusBarHeigth;
    
    try {
      statusBarHeigth = await SafeAreaSize.statusBarSize;
      navigationBarHeight = await SafeAreaSize.navigationBarSize;
    } on PlatformException {
      statusBarHeigth = 0;
      navigationBarHeight = 0;
    }
    
    if (!mounted) return;

    setState(() {
      _statusBarHeight = statusBarHeigth;
      _navigationBarHeight = navigationBarHeight;
    });
  }
```

You're done!

## TODO

- [x] Android version
- [ ] iOS version



