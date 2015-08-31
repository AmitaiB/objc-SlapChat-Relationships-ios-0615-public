//
//  FISDataStore.m
//  playingWithCoreData
//
//  Created by Joe Burgess on 6/27/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISDataStore.h"
#import "Message.h"
#import "Recipient.h"

@implementation FISDataStore
@synthesize managedObjectContext = _managedObjectContext;

#pragma mark - Singleton

+ (instancetype)sharedDataStore {
    static FISDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[FISDataStore alloc] init];
    });

    return _sharedDataStore;
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"slapChat.sqlite"];
    
    NSError *error = nil;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"slapChat" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Fetch/Save

- (void)fetchData
{
        //Fetch the recipients (there can be recipients without messages, but not messages without recipients.
    NSFetchRequest *recipientsRequest = [NSFetchRequest fetchRequestWithEntityName:@"Recipient"];
    
    NSSortDescriptor *alphabeticalSorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedStandardCompare:)];
    recipientsRequest.sortDescriptors = @[alphabeticalSorter];
    
        //Fetch the messages
    NSFetchRequest *messagesRequest = [NSFetchRequest fetchRequestWithEntityName:@"Message"];
    NSSortDescriptor *createdAtSorter = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:YES];
    messagesRequest.sortDescriptors = @[createdAtSorter];

    self.messages = [self.managedObjectContext executeFetchRequest:messagesRequest error:nil];
    self.recipients = [self.managedObjectContext executeFetchRequest:recipientsRequest error:nil];
    
    

    if ([self.recipients count]==0) {
        [self generateTestData];
    }
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Test data

- (void)generateTestData
{
    Recipient *alice = [NSEntityDescription insertNewObjectForEntityForName:@"Recipient" inManagedObjectContext:self.managedObjectContext];
    alice.name = @"Alice";
    
    Recipient *bob = [NSEntityDescription insertNewObjectForEntityForName:@"Recipient" inManagedObjectContext:self.managedObjectContext];
    bob.name = @"Bob";
    
    Recipient *carlos = [NSEntityDescription insertNewObjectForEntityForName:@"Recipient" inManagedObjectContext:self.managedObjectContext];
    carlos.name = @"Carlos";
    
    
    Message *messageOne = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:self.managedObjectContext];
    
    messageOne.content = @"Message 1: [Alice] \"Hey, Bob, what's a Liger?\"";
    messageOne.createdAt = [NSDate date];
    messageOne.addressedTo = bob;
    
    
    Message *messageTwo = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:self.managedObjectContext];
    messageTwo.content = @"Message 2: [Bob] “It’s pretty much my favorite animal. It’s like a lion and a tiger mixed… bred for its skills in magic.”";
    messageTwo.createdAt = [NSDate date];
    messageTwo.addressedTo = alice;
    
    Message *messageThree = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:self.managedObjectContext];
    
    messageThree.content = @"Message 3: [Lisa] \"I\'m more than a spambot! Our love was REAL!\"";
    messageThree.createdAt = [NSDate distantFuture];
    messageThree.addressedTo = carlos;
    
    Message *messageFour = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:self.managedObjectContext];
    messageFour.content = @"Message 4: [Alice] \"Sounds like nothing can kill a liger!\"";
    messageFour.createdAt = [NSDate date];
    messageFour.addressedTo = bob;
    
    
    [self saveContext];
    [self fetchData];
}

#pragma mark - Helpers

- (Message *)createMessage
{
    return [Message messageWithContext:self.managedObjectContext];
}
@end
