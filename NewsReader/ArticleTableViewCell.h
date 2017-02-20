//
//  ArticleTableViewCell.h
//  NewsReader
//
//  Created by pstojcsics on 2016. 10. 11..
//  Copyright © 2016. t360. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kArticleTableViewCell @"kArticleTableViewCell"

@interface ArticleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleBodyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;

@property (strong, nonatomic) NSString *currentImageUrl;



@end
