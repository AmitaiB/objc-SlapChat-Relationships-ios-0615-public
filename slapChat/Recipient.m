//
//  Recipient.m
//  slapChat
//
//  Created by Amitai Blickstein on 8/30/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import "Recipient.h"
#import "Message.h"


@implementation Recipient

@dynamic name;
@dynamic email;
@dynamic phoneNumber;
@dynamic twitterHandle;
@dynamic addressedBy;

+(instancetype)recipientWithContext:(NSManagedObjectContext *)context
{
    Recipient *newRecipient = [NSEntityDescription insertNewObjectForEntityForName:@"Recipient" inManagedObjectContext:context];
    return newRecipient;
}



@end
