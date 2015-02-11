//
//  DetailsViewController.m
//  Universal Pouch
//
//  Created by Sesha Sai Bhargav Bandla on 11/02/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController
@synthesize webUrl;
UIView *loadscreen;
UIActivityIndicatorView *activity;

- (void)viewDidLoad {
    [super viewDidLoad];
    loadscreen=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    loadscreen.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    activity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activity.frame=CGRectMake(320/2-50, 568/2-50, 100, 100);
    [loadscreen addSubview:activity];
    self.navigationItem.title=@"Details";
    [activity startAnimating];
    [self.detilsWeb setDelegate:self];
    [self.view addSubview:loadscreen];
    [self.detilsWeb loadRequest:[NSURLRequest requestWithURL:webUrl]];
    
//    self.navigationController.navigationBarHidden=YES;
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activity stopAnimating];
    [activity removeFromSuperview];
    [loadscreen removeFromSuperview];
    
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
