#import <Foundation/Foundation.h>

#import <GNAGrowl/GNARegistration.h>
#import <GNAGrowl/GNAGrowl.h>

int main(int argc, char* argv[]) {
  NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

  GNARegistration* registration = [[GNARegistration alloc] init];
  
  GNAGrowl* growl = [[GNAGrowl alloc] initWithRegistration: registration withMessage: @"Test" withTitle: @"GNAGrowl"];

  [growl sendToGrowl];

  [growl release];
  [registration release];

  [pool drain];
  return 0;
}
