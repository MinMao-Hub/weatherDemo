//
//  WeatherModel.h
//  WeatherReport
//
//  Created by dan on 14-4-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

@property(nonatomic,copy)NSString *city;  //城市
@property(nonatomic,copy)NSString *cityid;//城市ID
@property(nonatomic,copy)NSString *temp;  //天气
@property(nonatomic,copy)NSString *WD;    //风向
@property(nonatomic,copy)NSString *WS;    //风级
@property(nonatomic,copy)NSString *SD;    //湿度
@property(nonatomic,copy)NSString *WSE;   //风力
@property(nonatomic,copy)NSString *time;  //时间

@end
