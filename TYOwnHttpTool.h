//
//  TYOwnHttpTool.h
//  
//
//  Created by HZD on 15/3/12.
//  Copyright (c) 2015年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
// 成功的回调类型,传一个返回数据给你

typedef void(^HttpSuccessOpen)(id responseOpen);
typedef void(^HttpGETrequest)(id GETrequest);
@interface TYOwnHttpTool : NSObject


+(void)setaddPOSTLoadingUrl:(NSString *)Url Dictionary:(NSDictionary *)Dictionary success:(HttpSuccessOpen)Open;

+(void)setaddGETNetworkParametersUrl:(NSString *)Url  success:(HttpGETrequest)returnDic;
@end
