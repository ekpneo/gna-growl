/* GNAGrowl.h
 *
 * Growl - No App
 *
 * Main class.  A Growl is a notification to growl.
 */

#import <Foundation/Foundation.h>

#import <GNAGrowl/GNARegistration.h>
#import <GNAGrowl/GNAHelpers.h>

@interface GNAGrowl : NSObject  {
  GNARegistration* registration;

  NSString* name;
  NSString* message;
  NSString* title;
  NSData*   icon;
  int       priority;
}

// Initialization -- with a registration
- (id) initWithRegistration: (GNARegistration*) aRegistration withMessage: (NSString*) theMessage withTitle: (NSString*) theTitle andIconData: (NSData*) someData;
- (id) initWithRegistration: (GNARegistration*) aRegistration withMessage: (NSString*) theMessage withTitle: (NSString*) theTitle;
- (id) initWithRegistration: (GNARegistration*) aRegistration withMessage: (NSString*) theMessage withTitle: (NSString*) theTitle;
- (id) initWithRegistration: (GNARegistration*) aRegistration withMessage: (NSString*) theMessage;
- (id) initWithRegistration: (GNARegistration*) aRegistration;

// Initialization -- without a registration
- (id) initWithMessage: (NSString*) theMessage withTitle: (NSString*) theTitle andIconData: (NSData*) someData;
- (id) initWithMessage: (NSString*) theMessage withTitle: (NSString*) theTitle;
- (id) initWithMessage: (NSString*) theMessage;
- (id) init;

// Accessors
- (GNARegistration*) registration;
- (void) setRegistration: (GNARegistration*) registration;

- (int) priority;
- (void) setPriority: (int) anInt;

- (NSString*) name;
- (void) setName: (NSString*) theName;

- (NSString*) message;
- (void) setMessage: (NSString*) theMessage;

- (NSString*) title;
- (void) setTitle: (NSString*) theTitle;

- (NSData*) icon;
- (void) setIcon: (NSData*) someData;

// Growl-related
- (NSDictionary*) asGrowlDictionary;
- (BOOL) sendToGrowl;

// Destruction
- (void) dealloc;

@end
