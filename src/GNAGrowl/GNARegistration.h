/* GNARegistration.h
 *
 * Growl - No App
 * 
 * Registration class.  Represents a certain application registration with
 * the Growl application.   Passed to GNAGrowl.
 */

#import <Foundation/Foundation.h>

@interface GNARegistration : NSObject {
  NSString*     applicationName;
  NSData*       applicationIcon;
  NSMutableSet* notificationNames;

  BOOL          boolRegistered;
}

// Creation
+ (GNARegistration*) registrationAsApp: (NSString*) appName withIcon: (NSData*) icon;
+ (GNARegistration*) registrationAsApp: (NSString*) appName;
+ (GNARegistration*) registration;

// Initialization
- (id) initAs: (NSString*) appName withNotificationsArray: (NSArray*) notesArray andIconData: (NSData*) icon;
- (id) initAs: (NSString*) appName withNotificationsArray: (NSArray*) notesArray;

- (id) initAs: (NSString*) appName withNotificationNamed: (NSString*) noteName andIconData: (NSData*) icon;
- (id) initAs: (NSString*) appName withNotificationNamed: (NSString*) noteName;
- (id) initAs: (NSString*) appName withIconData: (NSData*) icon;
- (id) initAs: (NSString*) appName;
- (id) init;

// Accessors
- (NSString*) applicationName;

- (NSArray*) notificationNames;
- (void) setNotificationNames: (NSArray*) notificationsArray;

- (NSData*) iconData;
- (void) setIconData: (NSData*) iconData;

- (BOOL) isRegistered;
- (void) setRegistered: (BOOL) isRegistered;

// Notification setters/getters
- (void) removeNotificationNamed: (NSString*) name;
- (void) addNotificationNamed: (NSString*) name;
- (void) addNotifications: (NSArray*) namesArray;
- (NSString*) aNotificationName;

// Growl-related
- (NSDictionary*) asGrowlDictionary;

// Destruction
- (void) dealloc;

@end
