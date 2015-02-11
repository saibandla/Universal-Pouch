//
//  AppDelegate.h
//  Universal Pouch
//
//  Created by Sesha Sai Bhargav Bandla on 09/02/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,NSXMLParserDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong,nonatomic)NSMutableArray *latestStotes;
@property(strong,nonatomic)NSMutableArray *topStotes;
@property(strong,nonatomic)NSMutableArray *techStotes;
@end

