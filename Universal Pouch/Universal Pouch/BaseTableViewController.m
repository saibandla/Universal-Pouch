//
//  BaseTableViewController.m
//  Universal Pouch
//
//  Created by Sesha Sai Bhargav Bandla on 10/02/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#import "BaseTableViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "CustomeCell.h"
@interface BaseTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;

@end

@implementation BaseTableViewController
@synthesize url;
UIView *loadscreen;
AppDelegate *app;
UIActivityIndicatorView *activity;
NSMutableArray *mainArray;
NSMutableString *strTitle;
NSMutableString *strduration;
NSMutableString *strLink;
NSMutableString  *strImg;
NSMutableString *strChanelTitle;
NSXMLParser *xmlpartser;
NSString *currentItem;
BOOL itemselected;
BOOL titleselected;
int sectionCount;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
    [self.navigationItem setTitle:self.navigationController.navigationItem.title];
    url=[NSURL URLWithString:self.navigationController.navigationItem.prompt];
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSLog(@"\n\n%@",app.latestStotes);
    
    if(url==nil)
    {
        sectionCount=3;
        
        
    }
    else
    {
        sectionCount=1;
    if (networkStatus == NotReachable) {
        
    }
    else
    {
        dispatch_async(kBgQueue, ^{
            xmlpartser=[[NSXMLParser alloc]initWithContentsOfURL:url];
            [xmlpartser setDelegate:self];
            [xmlpartser parse];
        });
    }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}
-(void)ShowLoadScreen
{
    loadscreen=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    loadscreen.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    activity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activity.frame=CGRectMake(320/2-50, 568/2-50, 100, 100);
    [loadscreen addSubview:activity];
    [activity startAnimating];
   
    [app.window addSubview:loadscreen];
    
}
-(void)hideLoadScreen
{
    [self.tableView reloadData];
    [activity stopAnimating];
    [activity removeFromSuperview];
    [loadscreen removeFromSuperview];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return sectionCount;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 164;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title;
    if(sectionCount==3)
    {
    if(section==0)
    {
        title=@"Latestes Stories";
    }
    else if(section==1)
    {
        title=@"Top Stories";
    }
    else
    {
        title=@"Technology";
        
    }
    }
    return title;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(sectionCount==3)
    {
        return 3;
    }
    return mainArray.count;
}
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    // Configure the cell...
    if(indexPath.section==0)
    {
        if(sectionCount==3)
        {
    dispatch_async(kBgQueue, ^{
        NSString *thumurl=[[app.latestStotes objectAtIndex:indexPath.row] objectForKey:@"image"];
        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:thumurl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadImageFromData:data forCell:cell];
        });
        
    });
            cell.titleLabel.text=[[app.latestStotes objectAtIndex:indexPath.row] objectForKey:@"title"];
            cell.timeLabel.text=[[app.latestStotes objectAtIndex:indexPath.row] objectForKey:@"pubDate"];

        }
        else
        {
            dispatch_async(kBgQueue, ^{
                NSString *thumurl=[[mainArray objectAtIndex:indexPath.row] objectForKey:@"image"];
                NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:thumurl]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self loadImageFromData:data forCell:cell];
                });
                
            });
            cell.titleLabel.text=[[mainArray objectAtIndex:indexPath.row] objectForKey:@"title"];
            cell.timeLabel.text=[[mainArray objectAtIndex:indexPath.row] objectForKey:@"pubDate"];

        }
           }
    if(indexPath.section==1)
    {
        dispatch_async(kBgQueue, ^{
            NSString *thumurl=[[app.topStotes objectAtIndex:indexPath.row] objectForKey:@"image"];
            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:thumurl]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loadImageFromData:data forCell:cell];
            });
            
        });
        cell.titleLabel.text=[[app.topStotes objectAtIndex:indexPath.row] objectForKey:@"title"];
        cell.timeLabel.text=[[app.topStotes objectAtIndex:indexPath.row] objectForKey:@"pubDate"];

    }
    if(indexPath.section==2)
    {
        dispatch_async(kBgQueue, ^{
            NSString *thumurl=[[app.techStotes objectAtIndex:indexPath.row] objectForKey:@"image"];
            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:thumurl]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loadImageFromData:data forCell:cell];
            });
            
        });
        cell.titleLabel.text=[[app.techStotes objectAtIndex:indexPath.row] objectForKey:@"title"];
        cell.timeLabel.text=[[app.techStotes objectAtIndex:indexPath.row] objectForKey:@"pubDate"];

    }
    return cell;
}
-(void)loadImageFromData:(NSData *)data forCell:(CustomeCell *)cell
{
    cell.thumbimage.image=[UIImage imageWithData:data];
}
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    mainArray=[[NSMutableArray alloc]init];
        [self performSelectorOnMainThread:@selector(ShowLoadScreen) withObject:nil waitUntilDone:YES];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
        [self performSelectorOnMainThread:@selector(hideLoadScreen) withObject:nil waitUntilDone:YES];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDic
{
    currentItem=elementName;
    if([elementName isEqualToString:@"item"])
    {
        itemselected=YES;
        strTitle=[[NSMutableString alloc]init];
        strduration=[[NSMutableString alloc]init];
        strLink=[[NSMutableString alloc]init];
        strImg=[[NSMutableString alloc]init];
    }
    if([elementName isEqualToString:@"channel"])
    {
        titleselected=YES;
        strChanelTitle=[[NSMutableString alloc]init];
        
    }
    if(itemselected)
    {
        if([elementName isEqualToString:@"media:thumbnail"])
        {
            [strImg setString:[attributeDic objectForKey:@"url"]];
        }
    }
}
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
        [self performSelectorOnMainThread:@selector(hideLoadScreen) withObject:nil waitUntilDone:YES];
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(itemselected)
    {
        if([currentItem isEqualToString:@"title"])
        {
            [strTitle appendString:string];
        }
        if([currentItem isEqualToString:@"pubDate"])
        {
            [strduration appendString:[string stringByReplacingOccurrencesOfString:@"GMT" withString:@""] ];
            
            
        }
        if([currentItem isEqualToString:@"link"])
        {
            [strLink appendString:string];
        }
        
    }
    if(titleselected)
    {
        if([currentItem isEqualToString:@"title"])
        {
            
            [strChanelTitle appendString: string];
        }
    }
}
+(NSString *)databasePath
{
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) firstObject] ;
    [path stringByAppendingPathComponent:@"pouch.sqlite"];
    return path;
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"item"])
    {
        itemselected=NO;
       
            NSDictionary *dic=@{@"title":strTitle,@"pubDate":strduration,@"image":strImg,@"link":strLink};
            [mainArray addObject:dic];
           
            
        
      
    }
    if([elementName isEqualToString:@"channel"])
    {
        titleselected=NO;
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
