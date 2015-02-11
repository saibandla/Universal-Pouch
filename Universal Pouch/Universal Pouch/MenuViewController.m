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
NSArray *section2data;
int slectedIndex=-1;
int selectedsection=-1;
-(void)viewDidLoad
{
    selectedColor=[UIColor colorWithRed:0.271778 green:0.724866 blue:0.67773 alpha:1];
    
    NSString *plistpath=[[NSBundle mainBundle] pathForResource:@"dataList" ofType:@"plist"];
    
    section1data=[NSArray arrayWithContentsOfFile:plistpath];
    section2data=@[@{@"topicname":@"Settings",@"icon":@"settings",@"selectedicon":@"selected_settings"},@{@"topicname":@"Favrouites",@"icon":@"favrouites",@"selectedicon":@"selected_favrouites"}];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1)
    {
        slectedIndex=indexPath.row;
    selectedsection=indexPath.section;
    UINavigationController *mainnav=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"mainnav"];
        NSDictionary *dic=[section1data objectAtIndex:indexPath.row];
    mainnav.navigationItem.title=[dic objectForKey:@"topicname"];
        mainnav.navigationItem.prompt=[dic objectForKey:@"url"];
    [self.revealViewController pushFrontViewController:mainnav animated:YES];
    }
    else if(indexPath.section==2)
    {
        slectedIndex=indexPath.row;
        selectedsection=indexPath.section;
        UINavigationController *mainnav=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"mainnav"];
        NSDictionary *dic=[section2data objectAtIndex:indexPath.row];
        mainnav.navigationItem.title=[dic objectForKey:@"topicname"];
        [self.revealViewController pushFrontViewController:mainnav animated:YES];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int lenght;
    if(section==0)
        lenght=1;
    else if(section==1)
        lenght=section1data.count;
    else if(section==2)
        lenght=section2data.count;
    return lenght;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString *CellIdentifier = @"Cell";
    static NSString *LogoCellIdentifier=@"Logo";
    if(indexPath.section==1)
    {
    SWUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
        NSDictionary *dic=[section1data objectAtIndex:indexPath.row];
     if(indexPath.row== slectedIndex&&indexPath.section==selectedsection)
     {
         cell.label.textColor=selectedColor;
         cell.selectionIndicator.hidden=NO;
          cell.iconimage.image=[UIImage imageNamed:[dic objectForKey:@"selectedicon"]];
     }
        else
        {
            cell.label.textColor=[UIColor darkGrayColor];
            cell.selectionIndicator.hidden=YES;
             cell.iconimage.image=[UIImage imageNamed:[dic objectForKey:@"icon"]];
        }
//    cell.label.textColor=selectedColor;
        
        cell.label.text=[dic objectForKey:@"topicname"];
       
    return cell;
    }
    else if(indexPath.section==0)
    {
        UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier: LogoCellIdentifier forIndexPath: indexPath];
        return cell;
    }
    else
    {
        SWUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
        NSDictionary *dic=[section2data objectAtIndex:indexPath.row];
        if(indexPath.row== slectedIndex&&indexPath.section==selectedsection)
        {
            cell.label.textColor=selectedColor;
            cell.selectionIndicator.hidden=NO;
            cell.iconimage.image=[UIImage imageNamed:[dic objectForKey:@"selectedicon"]];
        }
        else
        {
            cell.label.textColor=[UIColor darkGrayColor];
            cell.selectionIndicator.hidden=YES;
            cell.iconimage.image=[UIImage imageNamed:[dic objectForKey:@"icon"]];
        }
        //    cell.label.textColor=selectedColor;
        
        cell.label.text=[dic objectForKey:@"topicname"];
        return cell;

    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0)
        return 81;
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     if(indexPath.section==0)
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
