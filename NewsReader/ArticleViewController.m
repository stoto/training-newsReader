//
//  ArticleViewController.m
//  NewsReader
//
//  Created by pstojcsics on 2016. 10. 11..
//  Copyright © 2016. t360. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *articleWebView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation ArticleViewController

- (IBAction)forwardButtonTapped:(id)sender {
    [self.articleWebView goForward];
//    [self updateButtonStates];
}

- (IBAction)backButtonTapped:(id)sender {
    [self.articleWebView goBack];
//    [self updateButtonStates];
}

- (IBAction)stopButtonTapped:(id)sender {
    [self.articleWebView stopLoading];
    [self updateButtonStates];
}

- (void)updateButtonStates {
    self.backButton.enabled = [self.articleWebView canGoBack];
    self.forwardButton.enabled = [self.articleWebView canGoForward];
    self.stopButton.enabled = [self.articleWebView isLoading];
    
    self.backButton.alpha = self.backButton.enabled ? 1 : 0.3;
    self.forwardButton.alpha = self.forwardButton.enabled ? 1 : 0.3;
    self.stopButton.alpha = self.stopButton.enabled ? 1 : 0.3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.item.title;
    
    self.articleWebView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:self.item.itemURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.articleWebView loadRequest:request];
    
    [self updateButtonStates];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self updateButtonStates];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self updateButtonStates];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self updateButtonStates];
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
