//
//  Recipient.h
//  slapChat
//
//  Created by Amitai Blickstein on 8/30/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Message;

@interface Recipient : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * twitterHandle;
@property (nonatomic, retain) NSSet *addressedBy;
@end

@interface Recipient (CoreDataGeneratedAccessors)

- (void)addAddressedByObject:(Message    * )value;
- (void)removeAddressedByObject:(Message * )value;
- (void)addAddressedBy:(NSSet            * )values;
- (void)removeAddressedBy:(NSSet         * )values;

@end
