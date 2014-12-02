//
//  ViewController.m
//  XMLTest
//
//  Created by Dmitriy Demchenko on 12/01/14.
//  Copyright (c) 2014 Organization98. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

@interface ViewController ()

@end


// 1) xml документ
// 2) ищем нужные элементы
// 3) создаем нужные элементы
// 4) создаем словарь (очистить данные для этого item) из элементов, ложим в массив news

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://news.yandex.ua/music.rss"]];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (connection) {
        self.rssData = [NSMutableData data]; // data == alloc init, упрощенная инициализация
    } else {
        NSLog(@"No connection");
    }
    
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    
    self.newsArray = [NSMutableArray array];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.rssData appendData:data]; //  получение новых данных, собираем
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *result = [[NSString alloc] initWithData:self.rssData encoding:NSUTF8StringEncoding]; // результирующая строка
    NSLog(@"%@", result);
    NSXMLParser *rssParser = [[NSXMLParser alloc] initWithData:self.rssData];
    rssParser.delegate = self;
    [rssParser parse];
    [self.tableView reloadData];

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription] message:[[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey] delegate:self cancelButtonTitle:@"Hide alert" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    // нас интересуют только <item>
    self.currentElement = elementName;
    // проверяеи
    if ([elementName isEqualToString:@"item"]) {
        self.currentTitle = [NSMutableString string];
        self.currentPubDate = [NSMutableString string];
        self.descriptionRSS = [NSMutableString string];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // находит символы между символами
    if ([self.currentElement isEqualToString:@"title"]) {
        [self.currentTitle appendString:string];
    }
    
    if ([self.currentElement isEqualToString:@"pubDate"]) {
        [self.currentPubDate appendString:string];
    }
    
    if ([self.currentElement isEqualToString:@"description"]) {
        [self.descriptionRSS appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"item"]) {
        NSDictionary *newsItem = @{@"title" : self.currentTitle,
                                   @"pubDate" : self.currentPubDate,
                                   @"description" : self.descriptionRSS};
        
        [self.newsArray addObject:newsItem];
        self.currentTitle = nil;
        self.currentPubDate = nil;
        self.descriptionRSS = nil;
        self.currentElement = nil;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    // когда весь документ распарсен
    NSLog(@"%@", self.newsArray);
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:[CustomCell cellID] forIndexPath:indexPath];
    if (!cell) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[CustomCell cellID]];
    }
    [cell configForItem:[self.newsArray objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end