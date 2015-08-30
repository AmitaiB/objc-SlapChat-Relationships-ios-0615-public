//
//  FISRecipientsTableViewController.h
//  slapChat
//
//  Created by Amitai Blickstein on 8/30/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FISDataStore.h"

@interface FISRecipientsTableViewController : UITableViewController

@property (nonatomic, strong) FISDataStore *sharedStore;
@property (nonatomic, strong) NSArray *managedRecipientObjects;


@end
