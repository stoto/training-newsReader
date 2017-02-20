//
//  NewsService.h
//  NewsReader
//
//  Created by pstojcsics on 2016. 10. 11..
//  Copyright © 2016. t360. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^NewsFetchOnComplete)(NSArray *newsItems);

@interface NewsService : NSObject

- (void)fetchNewsOnComplete:(NewsFetchOnComplete)onComplete;

@end
