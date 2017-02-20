//
//  NewsItem.h
//  NewsReader
//
//  Created by pstojcsics on 2016. 10. 11..
//  Copyright © 2016. t360. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *itemURL;

@end
