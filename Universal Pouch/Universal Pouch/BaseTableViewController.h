//
//  BaseTableViewController.h
//  Universal Pouch
//
//  Created by Sesha Sai Bhargav Bandla on 10/02/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface BaseTableViewController : UITableViewController<NSXMLParserDelegate>
{
    NSMutableArray *arraytitle;
    NSMutableArray *arrayduration;
    NSMutableArray *arrayLinks;
    NSMutableString *strTitle;
    NSMutableString *strduration;
    NSMutableString *strLink;
    NSXMLParser *xmlpartser;
    NSString *currentItem;
    BOOL itemselected;
}
@property(nonatomic,strong)NSURL *url;
@end
