
#import <GNAGrowl/GNAHelpers.h>
#import <GNAGrowl/GNARegistration.h>

#import <GNAGrowl/Private/GrowlDefines.h>

#define DEFAULT_APP_NAME @"Growl - No App"
#define DEFAULT_NOTIFICATION_NAME @"Default"
#define DEFAULT_ICON_APP @"com.apple.Terminal"

@implementation GNARegistration

+ (GNARegistration*) registrationAsApp: (NSString*) appName withIcon: (NSData*) icon {
  return [[[GNARegistration alloc] initAs: appName withIconData: icon] autorelease];
}
+ (GNARegistration*) registrationAsApp: (NSString*) appName {
  return [[[GNARegistration alloc] initAs: appName] autorelease];
}
+ (GNARegistration*) registration {
  return [[[GNARegistration alloc] init] autorelease];
}

- (id) initAs: (NSString*) appName withNotificationsArray: (NSArray*) notesArray andIconData: (NSData*) icon
{
  if ((self = [super init])) {
    applicationName = [appName copy];
    notificationNames = [[NSMutableSet alloc] initWithArray: notesArray];
    applicationIcon = [icon retain];
    boolRegistered = NO;
  }
  return self;
}

- (id) initAs: (NSString*) appName withNotificationNamed: (NSString*) noteName andIconData: (NSData*) icon
{
  return [self initAs: appName 
	       withNotificationsArray: [NSArray arrayWithObjects: noteName, nil] 
	       andIconData: icon];
}

- (id) initAs: (NSString*) appName withNotificationsArray: (NSArray*) notesArray {
  NSData* icon = GNAIconFromApp(DEFAULT_ICON_APP);
  if (icon == nil) {
    [self release];
    return nil;
  }
  return [self initAs: appName 
	       withNotificationsArray: notesArray 
	       andIconData: icon];
}

- (id) initAs: (NSString*) appName withNotificationNamed: (NSString*) noteName {
  return [self initAs: appName 
	       withNotificationsArray: [NSArray arrayWithObjects: noteName, nil]];
}

- (id) initAs: (NSString*) appName withIconData: (NSData*) icon {
  return [self initAs: appName 
	       withNotificationNamed: DEFAULT_NOTIFICATION_NAME 
	       andIconData: icon];
}

- (id) initAs: (NSString*) appName {
  return [self initAs: appName 
	       withNotificationNamed: DEFAULT_NOTIFICATION_NAME];
}

- (id) init {
  return [self initAs: DEFAULT_APP_NAME];
}

- (NSString*) applicationName {
  return applicationName;
}

- (NSArray*) notificationNames {
  return [notificationNames allObjects];
}

- (void) setNotificationNames: (NSArray*) notificationsArray {
  [notificationNames removeAllObjects];
  [notificationNames addObjectsFromArray: notificationsArray];
  if ([notificationNames count] == 0) {
    [notificationNames addObject: DEFAULT_NOTIFICATION_NAME];
  }
  boolRegistered = NO;
}

- (void) removeNotificationNamed: (NSString*) name {
  [notificationNames removeObject: name];
  boolRegistered = NO;
}
- (void) addNotificationNamed: (NSString*) name {
  [notificationNames addObject: name];
  boolRegistered = NO;
}

- (void) addNotifications: (NSArray*) namesArray {
  [notificationNames addObjectsFromArray: namesArray];
  boolRegistered = NO;
}

- (NSString*) aNotificationName {
  return (NSString*) [notificationNames anyObject];
}

- (NSData*) iconData {
  return applicationIcon;
}

- (void) setIconData: (NSData*) iconData {
  [applicationIcon autorelease];
  applicationIcon = [iconData retain];
  boolRegistered = NO;
}

- (BOOL) isRegistered {
  return boolRegistered;
}

- (void) setRegistered: (BOOL) isRegistered {
  boolRegistered = isRegistered;
}

- (NSDictionary*) asGrowlDictionary {
  NSArray* notifications = [notificationNames allObjects];
  return [NSDictionary dictionaryWithObjects:
			 [NSArray arrayWithObjects:
				    applicationName,
				    notifications,
				    notifications,
				    applicationIcon,
				    nil]
		       forKeys:
			 [NSArray arrayWithObjects:
				    GROWL_APP_NAME,
				    GROWL_NOTIFICATIONS_ALL,
				    GROWL_NOTIFICATIONS_DEFAULT,
   				    GROWL_APP_ICON,
				    nil]];
}

- (void) dealloc {
  [applicationName release];
  [notificationNames release];
  [applicationIcon release];
  [super dealloc];
}

@end
