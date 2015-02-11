//
//  AppDelegate.m
//  Universal Pouch
//
//  Created by Sesha Sai Bhargav Bandla on 09/02/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import <sqlite3.h>
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize latestStotes,topStotes,techStotes;
NSMutableString *strTitle;
NSMutableString *strduration;
NSMutableString *strLink;
NSMutableString  *strImg;
NSMutableString *strChanelTitle;
NSXMLParser *xmlpartser;
NSString *currentItem;
BOOL itemselected;
BOOL titleselected;
int count=0;
sqlite3 *db;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return YES;
    }
    else
    {
        latestStotes=[[NSMutableArray alloc]init];
        topStotes=[[NSMutableArray alloc]init];
        techStotes=[[NSMutableArray alloc]init];
        xmlpartser=[[NSXMLParser alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://feeds.bbci.co.uk/news/system/latest_published_content/rss.xml"]];
        [xmlpartser setDelegate:self];
        [xmlpartser parse];
        
        xmlpartser=[[NSXMLParser alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://feeds.bbci.co.uk/news/rss.xml"]];
        [xmlpartser setDelegate:self];
        [xmlpartser parse];
        
        xmlpartser=[[NSXMLParser alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://feeds.bbci.co.uk/news/technology/rss.xml"]];
        [xmlpartser setDelegate:self];
        [xmlpartser parse];
        NSLog(@"%@",latestStotes);
    }
    return YES;
}
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    count=0;
    //    [self performSelectorOnMainThread:@selector(ShowLoadScreen) withObject:nil waitUntilDone:YES];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
//    [self performSelectorOnMainThread:@selector(hideLoadScreen) withObject:nil waitUntilDone:YES];
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
//    [self performSelectorOnMainThread:@selector(hideLoadScreen) withObject:nil waitUntilDone:YES];
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
        if([strChanelTitle containsString:@"BBC News - Latest Published Content"])
        {
            NSDictionary *dic=@{@"title":strTitle,@"pubDate":strduration,@"image":strImg,@"link":strLink};
            [latestStotes addObject:dic];
            count++;
            if(count==3)
            {
                [parser abortParsing];
            }
            
        }
        if([strChanelTitle containsString:@"BBC News - Home"])
        {
            NSDictionary *dic=@{@"title":strTitle,@"pubDate":strduration,@"image":strImg,@"link":strLink};
            [topStotes addObject:dic];
            count++;
            if(count==3)
            {
                [parser abortParsing];
            }
            
        }
        if([strChanelTitle containsString:@"BBC News - Technology"])
        {
            NSDictionary *dic=@{@"title":strTitle,@"pubDate":strduration,@"image":strImg,@"link":strLink};
            [techStotes addObject:dic];
            count++;
            if(count==3)
            {
                [parser abortParsing];
            }
            
        }
//        [arraytitle addObject:strTitle];
//        [arrayduration addObject:strduration];
//        [arrayLinks addObject:strLink];
//        prefs=[NSUserDefaults standardUserDefaults];
//        [prefs setObject:arraytitle forKey:[NSString stringWithFormat:@"%@titlesKey",pubkey]];
//        [prefs setObject:arrayduration forKey:[NSString stringWithFormat:@"%@durationsKey",pubkey]];
//        [prefs setObject:arrayLinks forKey:[NSString stringWithFormat:@"%@linksKey",pubkey]];
        
//        if(![prefs synchronize])
//        {
//            NSLog(@"Failed to sync");
//        }
        //        NSLog(@"Parse count : %d",count);
        //        if(count==4)
        //        {
        //            [parser abortParsing];
        //        }
    }
    if([elementName isEqualToString:@"channel"])
    {
        titleselected=NO;
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
