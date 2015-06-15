//
//  TYOwnHttpTool.m
//  
//
//  Created by HZD on 15/3/12.
//  Copyright (c) 2015年 Admin. All rights reserved.
//

#import "TYOwnHttpTool.h"
#import "TYtisiView.h"
#define HZAccountFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"cookie.value"]
//@interface HZOwnHttpTool()
//@property (nonatomic, strong) ;
//@end
@implementation TYOwnHttpTool

+(void)setaddPOSTLoadingUrl:(NSString *)Url Dictionary:(NSDictionary *)Dictionary  success:(void (^)(id))Open
{
    //此处是网络请求时的状态和请求完后的状态，还有没有响应1分钟后的提示
    TYtisiView *prompt = [[TYtisiView alloc] initWithTitle:@"加载失败" iamge:nil];
    [prompt show];
    NSURL *url = [NSURL URLWithString:Url];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSMutableURLRequest *request =
    [NSMutableURLRequest
     requestWithURL:url
     cachePolicy:NSURLRequestUseProtocolCachePolicy
     timeoutInterval:60.0f];
 
   
    // 2.设置请求头
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
       //设置什么请求
    request.HTTPMethod = @"POST";
    
    NSError *erro;
    NSData *json = [NSJSONSerialization dataWithJSONObject:Dictionary options:NSJSONWritingPrettyPrinted error:&erro];
//
    [request setHTTPBody:json];

    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [prompt CancelPicture];
        });

        if (connectionError == nil) {
             NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if (Open) {
                Open(dict);
            }

        }
       

    }];
   

}
+(void)setaddGETNetworkParametersUrl:(NSString *)Url  success:(void (^)(id))returnDic
{
  
     NSURL *url=[NSURL URLWithString:Url];
  
    //    2.创建请求对象
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError == nil) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if (returnDic) {
                returnDic(dict);
            }
            
        }
      
    }];

    

}

@end
