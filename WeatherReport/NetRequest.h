//
//  NetRequest.h
//  WeatherReport
//
//  Created by dan on 14-4-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City_WeatherViewController.h"
#import "WeatherDB.h"

@interface NetRequest : NSObject

@property(nonatomic,strong)NSMutableArray *mutableArray;

//开始网络请求
-(WeatherModel *)startRequest:(NSString *)cityid;

@end
