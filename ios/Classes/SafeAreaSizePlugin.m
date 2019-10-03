#import "SafeAreaSizePlugin.h"
#import <safe_area_size/safe_area_size-Swift.h>

@implementation SafeAreaSizePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSafeAreaSizePlugin registerWithRegistrar:registrar];
}
@end
