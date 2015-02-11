//
//  MenuViewController.h
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
@interface SWUITableViewCell : UITableViewCell<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconimage;
@property (nonatomic,weak) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *selectionIndicator;
@end

@interface MenuViewController : UITableViewController

@end
