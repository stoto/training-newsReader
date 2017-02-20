//
//  ArticleListViewController.m
//  NewsReader
//
//  Created by pstojcsics on 2016. 10. 11..
//  Copyright © 2016. t360. All rights reserved.
//

#import "ArticleListViewController.h"
#import "ArticleTableViewCell.h"
#import "ArticleViewController.h"
#import "NewsService.h"
#import "NewsItem.h"

//http://tinyurl.com/iost360

@interface ArticleListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *articleTableView;

@property (nonatomic, strong) NewsService *service;
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) NSOperationQueue *imageQueue;
@property (nonatomic, strong) NSMutableDictionary *imageCache;

@end

@implementation ArticleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Hírek";
    UINib *nib = [UINib nibWithNibName:@"ArticleTableViewCell" bundle:nil];
    [self.articleTableView registerNib:nib forCellReuseIdentifier:kArticleTableViewCell];
    
    self.service = [NewsService new];
    self.imageQueue = [NSOperationQueue new];
    self.imageCache = [NSMutableDictionary new];
    [self refresh];
}

- (void)refresh {
    [self.service fetchNewsOnComplete:^(NSArray *newsItems) {
        self.items = newsItems;
        [self.articleTableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __block ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kArticleTableViewCell];
    
    NewsItem *item = self.items[indexPath.row];
    cell.articleTitleLabel.text = item.title;
    cell.articleBodyLabel.text = item.body;
    
    cell.currentImageUrl = item.imageURL;
    cell.articleImageView.image = [UIImage imageNamed:@"img2"];
    
    UIImage *cachedImage = self.imageCache[item.imageURL];
    if(cachedImage) {
        //image is in the cache
        cell.articleImageView.image = cachedImage;
        
        //image already set, cell already setup
        return cell;
    }
    
    if(item.imageURL != (NSString *)[NSNull null]) {
        [self.imageQueue addOperationWithBlock:^{
            
            UIImage *cachedImage = self.imageCache[item.imageURL];
            if(cachedImage && cell.currentImageUrl == item.imageURL) {
                cell.articleImageView.image = cachedImage;
                return;
            }
            
            
            NSURL *url = [NSURL URLWithString:item.imageURL];
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:imageData];
            self.imageCache[item.imageURL] = image;
            
            if(cell.currentImageUrl == item.imageURL) {
                cell.articleImageView.image = image;
            }
            
        }];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleViewController *detailViewController = [ArticleViewController new];
    
    NewsItem *item = self.items[indexPath.row];
    detailViewController.item = item;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
