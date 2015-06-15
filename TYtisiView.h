//
//  TYtisiView.h
//  网络封装
//
//  Created by dst on 15/6/15.
//  Copyright (c) 2015年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYtisiView : UIView
- (id)initWithTitle:(NSString *)label iamge:(NSString*)image;
- (void)show;
-(void)CancelPicture;

@end
