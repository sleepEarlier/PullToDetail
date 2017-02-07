//
//  ViewController.m
//  PullToDetail
//
//  Created by kimiLin on 2017/2/7.
//  Copyright © 2017年 KimiLin. All rights reserved.
//

#import "ViewController.h"

#define kSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UILabel *firstStateLabel;
@property (nonatomic, weak) UILabel *secondStateLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addLabel];
}

- (void)addLabel {
    UILabel *l = [[UILabel alloc]init];
    l.text = @"下拉返回概况";
    l.textAlignment = NSTextAlignmentCenter;
    l.frame = CGRectMake(0, -20, kSCREENWIDTH, 20);
    [self.webview.scrollView addSubview:l];
    self.secondStateLabel = l;
    self.webview.scrollView.delegate = self;
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cankaoxiaoxi.com/roll10/bd/20170207/1666742.shtml"]];
    [self.webview loadRequest:req];
    
    self.webview.scrollView.backgroundColor = [UIColor colorWithRed:1 green:0.3 blue:0.7 alpha:1];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) return;
    CGFloat yPos = scrollView.contentOffset.y;
    CGFloat margin = 25.;
    if ([scrollView isEqual:self.scrollview]) {
        if (yPos > scrollView.contentSize.height - kSCREENHEIGHT + margin) {
            self.topConstraint.constant = -kSCREENHEIGHT;
            CGAffineTransform translate = CGAffineTransformMakeTranslation(0, -kSCREENHEIGHT);
            [UIView animateWithDuration:0.3 animations:^{
                [self.view layoutIfNeeded];
//                self.container.transform = translate;
            }];
        }
    }
    else if ([scrollView isEqual:self.webview.scrollView]) {
        if (yPos < -25) {
            self.topConstraint.constant = 0;
            [UIView animateWithDuration:0.3 animations:^{
                [self.view layoutIfNeeded];
//                self.container.transform = CGAffineTransformIdentity;
            }];
        }
    }
}


@end
