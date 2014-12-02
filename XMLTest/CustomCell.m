//
//  CustomCell.m
//  XMLTest
//
//  Created by Dmitriy Demchenko on 12/02/14.
//  Copyright (c) 2014 Organization98. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

// задается конфигурация, настройки объекта (ячейки)
- (void)configForItem:(id)object {
    
    NSDictionary *newsItem = (NSDictionary *)object;
    
    self.titleLabel.text = [newsItem objectForKey:@"title"];
    
    self.pubDateLabel.text = [newsItem objectForKey:@"pubDate"];
    self.pubDateLabel.textColor = [UIColor darkGrayColor];
    
    self.descriptionLabel.text = [newsItem objectForKey:@"description"];
    self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:14];
}

@end
