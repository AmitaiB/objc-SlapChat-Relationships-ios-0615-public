//
//  FISMessagesTableViewController.h
//  slapChat
//
//  Created by Joe Burgess on 6/27/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISDataStore.h"
#import "Recipient.h"


@interface FISMessagesTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *managedMessageObjects;
@property (strong, nonatomic) FISDataStore *store;
@property (nonatomic, strong) NSString *recipientName;


@end
