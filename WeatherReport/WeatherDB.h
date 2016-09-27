//
//  WeatherDB.h
//  WeatherReport
//
//  Created by dan on 14-4-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "BaseDB.h"
#import "WeatherModel.h"

@interface WeatherDB : BaseDB

+ (id) shareInstance;

//创建用户表
- (void) createTable;
//添加天气
- (BOOL) addWeather:(WeatherModel *)weatherModel;
//查询天气
-(NSMutableArray *) findWeather;
//根据城市名查询天气
-(NSMutableArray *) findWeatherByCity:(NSString *)city;
//删除天气
-(NSMutableArray *) deleteWeather:(NSString *)cityid;
//更新天气
- (BOOL) updateWeather:(WeatherModel *)weatherModel;


@end
