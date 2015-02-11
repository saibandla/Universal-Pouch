//
//  CustomeCell.h
//  Universal Pouch
//
//  Created by Sesha Sai Bhargav Bandla on 11/02/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbimage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
