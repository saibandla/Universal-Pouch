//
//  DetailsViewController.h
//  Universal Pouch
//
//  Created by Sesha Sai Bhargav Bandla on 11/02/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *detilsWeb;
@property(nonatomic,strong)NSURL *webUrl;
@end
