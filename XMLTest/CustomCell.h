//
//  CustomCell.h
//  XMLTest
//
//  Created by Dmitriy Demchenko on 12/02/14.
//  Copyright (c) 2014 Organization98. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

+ (NSString *)cellID;
- (void)configForItem:(id)object;

@end
