//
//  Message.m
//  slapChat
//
//  Created by Amitai Blickstein on 8/30/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import "Message.h"

@implementation Message

@dynamic content;
@dynamic createdAt;
@dynamic addressedTo;

+(instancetype)messageWithContext:(NSManagedObjectContext *)context
{
    Message *newMessage = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:context];
    return newMessage;
}

@end
