//
//  TYtisiView.m
//  网络封装
//
//  Created by dst on 15/6/15.
//  Copyright (c) 2015年 TY. All rights reserved.
//

#import "TYtisiView.h"
#import <QuartzCore/QuartzCore.h>
#define labelWidth 300.0f
#define labelHeight 50.0f
#define spacing 220.0f
@interface TYtisiView()
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, strong) UIView *backImageView;
@property (nonatomic, assign) CGRect afterFrame;
@property (nonatomic, strong) UIActivityIndicatorView *testActivityIndicator;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSTimer *myTimers;
@property (nonatomic, strong) UIView *view;
@end
@implementation TYtisiView
- (id)initWithTitle:(NSString *)label iamge:(NSString*)image
{
    if (self = [super init]) {
        int width = (int)[UIScreen mainScreen].bounds.size.width;
        
        self.backgroundColor = [UIColor clearColor];
        _view = [[UIView alloc] initWithFrame:CGRectMake(width/2 - 30,0,60,labelHeight)];
        _view.hidden = YES;
        _view.backgroundColor = [UIColor blackColor];
        _view.alpha = 0.7;
        _view.layer.cornerRadius = 5.0;
        [self addSubview:_view];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(width/2 - 30,0,60,labelHeight)];
        _label.textColor = [UIColor whiteColor];
        
        _label.layer.cornerRadius = 5.0;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:14];
        _label.text = label;
        _label.hidden = YES;
        [self addSubview:_label];
        
        _testActivityIndicator= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(width/2 - 30,0,60,labelHeight)];
        _testActivityIndicator.activityIndicatorViewStyle= UIActivityIndicatorViewStyleWhiteLarge;
        _testActivityIndicator.center = _view.center;//只能设置中心，不能设置大小
        _testActivityIndicator.color = [UIColor blackColor];
        [_testActivityIndicator startAnimating];
        [self addSubview:_testActivityIndicator];
        
    }
    return self;
}
//取消提示
-(void)CancelPicture
{
    [_testActivityIndicator stopAnimating];
    [self removeFromSuperview];
    
    [_myTimer invalidate];
    _myTimer = nil;
    
}
-(void)scrollTimer
{
    _myTimers = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(prompt) userInfo:nil repeats:NO];
    
    [_testActivityIndicator stopAnimating ];
    //    //加载失败提示
    _view.hidden = NO;
    _label.hidden = NO;
    
    [_myTimer invalidate];
    _myTimer = nil;
    
}
-(void)prompt
{
    [self removeFromSuperview];
    [_myTimers invalidate];
    _myTimers = nil;
    
}
-(void)show{
    
    UIViewController *topVC = [self appRootViewController];
    int vheight = (int)([UIScreen mainScreen].bounds.size.height);
    int vwidth = (int)([UIScreen mainScreen].bounds.size.width);
    self.frame = CGRectMake(0,vheight - 300,vwidth  , labelHeight);
    
    [topVC.view addSubview:self];
}
- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
- (void)removeFromSuperview
{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    UIViewController *topVC = [self appRootViewController];
    int vwidth = (int)([UIScreen mainScreen].bounds.size.width);
    
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - labelWidth) * 0.5, CGRectGetHeight(topVC.view.bounds) - 300, vwidth -(spacing *2), labelHeight);
    
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        
        self.backImageView.alpha = 0.1f;
        
        
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    
    
    int vheight = (int)([UIScreen mainScreen].bounds.size.height);
    int vwidth = (int)([UIScreen mainScreen].bounds.size.width);
    self.afterFrame = CGRectMake(0,vheight - 300 ,vwidth , labelHeight);
    
    
    [UIView animateWithDuration:0.0f delay:0.0 options:UIViewAnimationOptionCurveEaseIn               animations:^{
        
        self.frame = _afterFrame;
        self.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
    
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(scrollTimer) userInfo:nil repeats:NO];
}
@end