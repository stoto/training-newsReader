//
//  NewsService.m
//  NewsReader
//
//  Created by pstojcsics on 2016. 10. 11..
//  Copyright © 2016. t360. All rights reserved.
//

#import "NewsService.h"
#import <AFNetworking/AFNetworking.h>
#import "NewsItem.h"

#define kServiceURL @"https://dl.dropboxusercontent.com/u/1986074/t360/news.json"

@implementation NewsService

- (NSArray *)parseData:(NSData *)data {
    NSError *error;
    NSArray *rawNews = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"%@", error);
    } else {
        NSMutableArray *elements = [NSMutableArray new];
        for (NSDictionary *actItem in rawNews) {
            NewsItem *item = [NewsItem new];
            item.itemId = actItem[@"id"];
            item.title = actItem[@"title"];
            item.body = actItem[@"body"];
            item.type = actItem[@"type"];
            item.itemURL = actItem[@"url"];
            item.imageURL = actItem[@"image"];
            
            [elements addObject:item];
        }
        return elements;
    }
    
    return nil;
}

- (void)fetchNewsOnComplete:(NewsFetchOnComplete)onComplete {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [manager GET:kServiceURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *models = [self parseData:[operation responseData]];
        onComplete(models);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
