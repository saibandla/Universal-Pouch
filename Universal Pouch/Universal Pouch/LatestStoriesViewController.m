//
//  LatestStoriesViewController.m
//  Universal Pouch
//
//  Created by Sesha Sai Bhargav Bandla on 09/02/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import "LatestStoriesViewController.h"
#import "SWRevealViewController.h"

@interface LatestStoriesViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;

@end

@implementation LatestStoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];

    // Do any additional setup after loading the view.
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
