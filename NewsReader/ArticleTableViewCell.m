//
//  ArticleTableViewCell.m
//  NewsReader
//
//  Created by pstojcsics on 2016. 10. 11..
//  Copyright © 2016. t360. All rights reserved.
//

#import "ArticleTableViewCell.h"

@implementation ArticleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSLog(@"ArticleTableViewCell awakeFromNib");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)init {
    self = [super init];
    if (self) {
        NSLog(@"ArticleTableViewCell init");
    }
    return self;
}

- (void)dealloc {
    NSLog(@"ArticleTableViewCell dealloc");
}

@end
