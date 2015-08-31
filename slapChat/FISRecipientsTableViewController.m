//
//  FISRecipientsTableViewController.m
//  slapChat
//
//  Created by Amitai Blickstein on 8/30/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import "FISRecipientsTableViewController.h"
#import "FISMessagesTableViewController.h"
#import "Recipient.h"

@interface FISRecipientsTableViewController ()

@end

@implementation FISRecipientsTableViewController

//    //Is this necessary???
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//            // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sharedStore = [FISDataStore sharedDataStore];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.sharedStore fetchData];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.sharedStore.recipients count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReuseID" forIndexPath:indexPath];
    
    // Configure the cell...
    Recipient *eachRecipient = self.sharedStore.recipients[indexPath.row];
    cell.textLabel.text = eachRecipient.name;
    
    return cell;
}

    // !!!
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"recipientsToMessagesSegueID" sender:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    FISMessagesTableViewController *destinationVC = segue.destinationViewController;
    
    if ([NSStringFromClass([sender class]) isEqualToString:@"UITableViewCell"]) {
        NSLog(@"sender is: %@", [sender description]);
        UITableViewCell *cell = sender;
        destinationVC.recipientName = cell.textLabel.text;
    }
    
}



@end
