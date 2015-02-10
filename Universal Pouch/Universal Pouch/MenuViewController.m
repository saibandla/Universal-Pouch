//
//  MenuViewController.m
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import "MenuViewController.h"

@implementation SWUITableViewCell
@end

@implementation MenuViewController

UIColor *selectedColor;
NSArray *section1data;
int slectedIndex=-1;
-(void)viewDidLoad
{
    selectedColor=[UIColor colorWithRed:0.271778 green:0.724866 blue:0.67773 alpha:1];
    
    NSString *plistpath=[[NSBundle mainBundle] pathForResource:@"dataList" ofType:@"plist"];
    
    section1data=[NSArray arrayWithContentsOfFile:plistpath];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1)
    {
        slectedIndex=indexPath.row;
    UINavigationController *mainnav=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"mainnav"];
    mainnav.navigationItem.title=@"News";
    [self.revealViewController pushFrontViewController:mainnav animated:YES];
    }
    [tableView reloadData];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int lenght;
    if(section==0)
        lenght=1;
    else
        lenght=section1data.count;
    
    return lenght;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString *CellIdentifier = @"Cell";
    static NSString *LogoCellIdentifier=@"Logo";
    if(indexPath.section==1)
    {
    SWUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
     if(indexPath.row== slectedIndex)
     {
         cell.label.textColor=selectedColor;
         cell.selectionIndicator.hidden=NO;
     }
//    cell.label.textColor=selectedColor;
        NSDictionary *dic=[section1data objectAtIndex:indexPath.row];
        cell.label.text=[dic objectForKey:@"topicname"];
        cell.iconimage.image=[UIImage imageNamed:[dic objectForKey:@"icon"]];
    return cell;
    }
    else if(indexPath.section==0)
    {
        UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier: LogoCellIdentifier forIndexPath: indexPath];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==1)
    return 44;
    else if(indexPath.section==0)
        return 81;
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==1)
        return 44;
    else if(indexPath.section==0)
        return 81;
    return 44;
}
#pragma mark state preservation / restoration
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO save what you need here
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO restore what you need here
    
    [super decodeRestorableStateWithCoder:coder];
}

- (void)applicationFinishedRestoringState {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO call whatever function you need to visually restore
}

@end
