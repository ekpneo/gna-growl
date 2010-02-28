
#import <Foundation/Foundation.h>

#import <GNAGrowl/Private/GrowlDefines.h>
#import <GNAGrowl/Private/GrowlPathway.h>

#import <GNAGrowl/GNARegistration.h>
#import <GNAGrowl/GNAGrowl.h>

#define GROWL_APP_PATHWAY @"GrowlApplicationBridgePathway"

@implementation GNAGrowl

- (id) initWithRegistration: (GNARegistration*) aRegistration withMessage: (NSString*) theMessage withTitle: (NSString*) theTitle andIconData: (NSData*) someData 
{
  if ((self = [super init])) {
    name = [[aRegistration aNotificationName] retain];
    priority = 0;
    registration = [aRegistration retain];
    message = [theMessage retain];
    title = [theTitle retain];
    icon = [someData retain];
  }
  return self;
}

- (id) initWithRegistration: (GNARegistration*) aRegistration withMessage: (NSString*) theMessage withTitle: (NSString*) theTitle
{
  return [self initWithRegistration: aRegistration 
	       withMessage: theMessage 
	       withTitle: theTitle 
	       andIconData: [aRegistration iconData]];
}

- (id) initWithRegistration: (GNARegistration*) aRegistration withMessage: (NSString*) theMessage
{
  return [self initWithRegistration: aRegistration 
	       withMessage: theMessage 
	       withTitle: @""];
}

- (id) initWithRegistration: (GNARegistration*) aRegistration 
{
  return [self initWithRegistration: aRegistration 
	       withMessage: @""];
}

- (id) initWithMessage: (NSString*) theMessage withTitle: (NSString*) theTitle andIconData: (NSData*) someData
{
  return [self initWithRegistration: [GNARegistration registration] 
	       withMessage: theMessage 
	       withTitle: theTitle 
	       andIconData: someData];
}

- (id) initWithMessage: (NSString*) theMessage withTitle: (NSString*) theTitle
{
  return [self initWithRegistration: [GNARegistration registration] 
	       withMessage: theMessage 
	       withTitle: theTitle];
}

- (id) initWithMessage: (NSString*) theMessage 
{
  return [self initWithRegistration: [GNARegistration registration] 
	       withMessage: theMessage];
}

- (id) init {
  return [self initWithRegistration: [GNARegistration registration]];
}

- (GNARegistration*) registration { return registration; }
- (void) setRegistration: (GNARegistration*) aRegistration {
  [registration release];
  registration = [aRegistration retain];
}

- (int) priority { return priority; }
- (void) setPriority: (int) anInt {
  priority = anInt;
  if (priority < -2) priority = -2;
  if (priority > 2) priority = 2;
}

- (NSString*) name { return name; }
- (void) setName: (NSString*) theName {
  [name release];
  name = [theName retain];
}

- (NSString*) message { return message; }
- (void) setMessage: (NSString*) theMessage {
  [message release];
  message = [theMessage retain];
}

- (NSString*) title { return title; }
- (void) setTitle: (NSString*) theTitle {
  [title release];
  title = [theTitle retain];
}

- (NSData*) icon { return icon; }
- (void) setIcon: (NSData*) someData {
  [icon release];
  icon = [someData retain];
}

- (NSDictionary*) asGrowlDictionary {
  NSString* uuid = GNAUUIDString();
  return [NSDictionary dictionaryWithObjects:
			 [NSArray arrayWithObjects:
				    [registration applicationName],
				    name,
				    title,
				    message,
				    icon,
				    [NSNumber numberWithInt: priority],
				    [NSNumber numberWithBool: NO],
				    uuid,
				    nil]
		       forKeys:
			 [NSArray arrayWithObjects:
				    GROWL_APP_NAME,
				    GROWL_NOTIFICATION_NAME,
				    GROWL_NOTIFICATION_TITLE,
				    GROWL_NOTIFICATION_DESCRIPTION,
				    GROWL_NOTIFICATION_ICON,
				    GROWL_NOTIFICATION_PRIORITY,
				    GROWL_NOTIFICATION_STICKY,
				    GROWL_NOTIFICATION_CLICK_CONTEXT,
				    nil]];
}

- (BOOL) sendToGrowl {
  NSConnection *connection =
    [NSConnection connectionWithRegisteredName: GROWL_APP_PATHWAY host: nil];
  if (connection) {
    @try {
      NSDistantObject *proxy = [connection rootProxy];
      [proxy setProtocolForProxy: @protocol(GrowlNotificationProtocol) ];
      id<GrowlNotificationProtocol> growlProxy = (id)proxy;

      if([registration isRegistered] == NO) {
	[growlProxy registerApplicationWithDictionary: [registration asGrowlDictionary]];
	[registration setRegistered: YES];
      }

      [growlProxy postNotificationWithDictionary: [self asGrowlDictionary]];

    } @catch(NSException *e) {
      NSLog(@"Exception while sending: %@", e);
      return NO;
    }
  } else {
    NSLog(@"No connection.\n");
    return NO;
  }

  NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
  while ([runLoop runMode: NSDefaultRunLoopMode
                  beforeDate: [NSDate distantFuture]] == NO);

  return YES;
}

- (void) dealloc {
  [registration release];
  [name release];
  [message release];
  [title release];
  [icon release];
  [super dealloc];
}

@end
