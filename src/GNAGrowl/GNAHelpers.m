
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

#import <GNAGrowl/GNAHelpers.h>

#import <GNAGrowl/Private/CFGrowlAdditions.h>

NSData* GNAIconFromApp(NSString* applicationIdentifier) {
  NSString* appPath =
    [[NSWorkspace sharedWorkspace]
      absolutePathForAppBundleWithIdentifier: applicationIdentifier];
  if (appPath) {
    NSURL* appUrl = [NSURL fileURLWithPath: appPath];
    if (appUrl) {
      NSData* iconData = copyIconDataForURL(appUrl);
      return [iconData autorelease];
    }
  }
  return nil;
}

NSData* GNAIconFromFile(NSString* iconPath) {
  return [NSData dataWithContentsOfFile: iconPath];
}

NSString * GNAUUIDString(void) {
  CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
  NSString *str =
    (NSString*) CFMakeCollectable(CFUUIDCreateString(kCFAllocatorDefault, uuid));
  CFRelease(uuid);
  return [str autorelease];
}
