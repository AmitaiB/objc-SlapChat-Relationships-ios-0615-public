//
//  FISDataStore.h
//  playingWithCoreData
//
//  Created by Joe Burgess on 6/27/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@interface FISDataStore : NSObject


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray *recipients;
@property (strong, nonatomic) NSArray *messages;
@property (nonatomic, strong) NSArray *filteredMessages;

+ (instancetype) sharedDataStore;

- (void) saveContext;
- (void) generateTestData;
- (void) fetchData;
- (Message *) createMessage;
@end
