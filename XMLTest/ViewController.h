//
//  ViewController.h
//  XMLTest
//
//  Created by Dmitriy Demchenko on 12/01/14.
//  Copyright (c) 2014 Organization98. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <  NSURLConnectionDelegate,
                                                NSURLConnectionDataDelegate,
                                                NSXMLParserDelegate,
                                                UITableViewDataSource,
                                                UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *newsArray;
@property (strong, nonatomic) NSMutableData *rssData;
@property (strong, nonatomic) NSString *currentElement;
@property (strong, nonatomic) NSMutableString *currentTitle;
@property (strong, nonatomic) NSMutableString *currentPubDate;
@property (strong, nonatomic) NSMutableString *descriptionRSS;

@end

