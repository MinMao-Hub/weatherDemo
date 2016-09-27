//
//  NetRequest.m
//  WeatherReport
//
//  Created by dan on 14-4-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "NetRequest.h"
#import "WeatherModel.h"
#import "WeatherDB.h"
#import "MainViewController.h"

@implementation NetRequest

@synthesize mutableArray;

//开始网络请求
- (void)startRequestWithCityId:(NSString *)cityid andCompletinonhandler:(void (^)(WeatherModel *model))complete
{
    WeatherModel *model = [[WeatherModel alloc] init]; 
    model.cityid = cityid;
 
    NSString *str = @"http://www.weather.com.cn/data/sk/";
    NSString *strURL = [str stringByAppendingFormat:@"%@.html",cityid];
    NSURL * url = [[NSURL alloc] initWithString:strURL];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionTask *dataTask = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSDictionary *dict = [dic objectForKey:@"weatherinfo"];
            self.mutableArray = [NSMutableArray array];
            
            model.city = [dict objectForKey:@"city"];
            model.cityid = [dict objectForKey:@"cityid"];
            model.temp = [dict objectForKey:@"temp"];
            model.WD = [dict objectForKey:@"WD"];
            model.WS = [dict objectForKey:@"WS"];
            model.SD = [dict objectForKey:@"SD"];
            model.WSE = [dict objectForKey:@"WSE"];
            model.time = [dict objectForKey:@"time"];
            model.njd = [dict objectForKey:@"njd"];
            model.qy  = [dict objectForKey:@"qy"];
            model.rain  = [dict objectForKey:@"rain"];
            
            complete(model);
        }else{
            complete(nil);
        }
        
    }];
    
    [dataTask resume];
}


@end
