//
//  WeatherDB.m
//  WeatherReport
//
//  Created by dan on 14-4-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "WeatherDB.h"
static WeatherDB * instance;

@implementation WeatherDB

+ (id) shareInstance
{
    if (instance == nil) {
        instance = [[[self class]alloc] init];
    }
    return instance;
}

- (void) createTable
{
    NSString * sql = @"CREATE TABLE IF NOT EXISTS Weather(city TEXT,cityid TEXT primary key,temp TEXT,WD TEXT,WS TEXT,SD TEXT,WSE TEXT,time TEXT,njd TEXT,qy TEXT,rain TEXT)";
    [self createTable:sql];
}

- (BOOL) addWeather:(WeatherModel *)weatherModel
{
    NSString * sql = @"INSERT OR REPLACE INTO Weather(city,cityid,temp,WD,WS,SD,WSE,time,njd,qy,rain) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
    
    NSArray * params = [NSArray arrayWithObjects:weatherModel.city,weatherModel.cityid,weatherModel.temp,weatherModel.WD,weatherModel.WS,weatherModel.SD,weatherModel.WSE,weatherModel.time,weatherModel.njd,weatherModel.qy,weatherModel.rain, nil];
    return [self dealData:sql paramsarray:params];
    
}

//更新天气
- (BOOL) updateWeather:(WeatherModel *)weatherModel
{
   NSString * sql = [NSString stringWithFormat:@"UPDATE Weather SET temp = '%@',WD = '%@',WS = '%@',SD = '%@',WSE = '%@',time = '%@',njd = '%@',qy = '%@',rain = '%@' WHERE cityid = '%@'",weatherModel.temp,weatherModel.WD,weatherModel.WS,weatherModel.SD,weatherModel.WSE,weatherModel.time,weatherModel.njd,weatherModel.qy,weatherModel.rain,weatherModel.cityid];
    
    NSArray * params = [NSArray arrayWithObjects:weatherModel.city,weatherModel.cityid,weatherModel.temp,weatherModel.WD,weatherModel.WS,weatherModel.SD,weatherModel.WSE,weatherModel.time,weatherModel.njd,weatherModel.qy,weatherModel.rain, nil];
    return [self dealData:sql paramsarray:params];
    
}

-(NSMutableArray *) findWeather
{
    NSString * sql = @"SELECT city,cityid,temp,WD,WS,SD,WSE,time,njd,qy,rain FROM Weather";
    NSArray * data = [self selectData:sql columns:11];
    
    NSMutableArray * weathers = [[NSMutableArray alloc] init];
    
    for (NSArray * row in data) {
        NSString * city = [row objectAtIndex:0];
        NSString * cityid = [row objectAtIndex:1];
        NSString * temp = [row objectAtIndex:2];
        NSString * WD = [row objectAtIndex:3];
        NSString * WS = [row objectAtIndex:4];
        NSString * SD = [row objectAtIndex:5];
        NSString * WSE = [row objectAtIndex:6];
        NSString * time = [row objectAtIndex:7];
        NSString * njd = [row objectAtIndex:8];
        NSString * qy = [row objectAtIndex:9];
        NSString * rain = [row objectAtIndex:10];
        
        
        WeatherModel * weather = [[WeatherModel alloc] init];
        weather.city = city;
        weather.cityid = cityid;
        weather.temp = temp;
        weather.WD = WD;
        weather.WS = WS;
        weather.SD = SD;
        weather.WSE = WSE;
        weather.time = time;
        weather.njd = njd;
        weather.qy = qy;
        weather.rain = rain;
        
        [weathers addObject:weather];
    }
    
    return weathers;
}

//根据城市名查询天气
-(NSMutableArray *) findWeatherByCity:(NSString *)city
{
    NSString * sql = [NSString stringWithFormat:@"SELECT cityid,temp,WD,WS,SD,WSE,timenjd,qy,rain FROM Weather WHERE city = '%@'",city];
    NSArray * data = [self selectData:sql columns:8];
    
    NSMutableArray * weathers = [[NSMutableArray alloc] init];
    
    for (NSArray * row in data) {
        NSString * city = [row objectAtIndex:0];
        NSString * cityid = [row objectAtIndex:1];
        NSString * temp = [row objectAtIndex:2];
        NSString * WD = [row objectAtIndex:3];
        NSString * WS = [row objectAtIndex:4];
        NSString * SD = [row objectAtIndex:5];
        NSString * WSE = [row objectAtIndex:6];
        NSString * time = [row objectAtIndex:7];
        NSString * njd = [row objectAtIndex:8];
        NSString * qy = [row objectAtIndex:9];
        NSString * rain = [row objectAtIndex:10];
        
        
        WeatherModel * weather = [[WeatherModel alloc] init];
        weather.city = city;
        weather.cityid = cityid;
        weather.temp = temp;
        weather.WD = WD;
        weather.WS = WS;
        weather.SD = SD;
        weather.WSE = WSE;
        weather.time = time;
        weather.njd = njd;
        weather.qy = qy;
        weather.rain = rain;
        
        [weathers addObject:weather];
    }
    
    return weathers;

}

//删除天气
-(NSMutableArray *) deleteWeather:(NSString *)cityid
{
    NSString * sql =  [NSString stringWithFormat: @"DELETE FROM Weather WHERE cityid = '%@'",cityid];
    NSArray * data = [self selectData:sql columns:8];
    
    NSMutableArray * weathers = [[NSMutableArray alloc] init];
    
    for (NSArray * row in data) {
        NSString * city = [row objectAtIndex:0];
        NSString * cityid = [row objectAtIndex:1];
        NSString * temp = [row objectAtIndex:2];
        NSString * WD = [row objectAtIndex:3];
        NSString * WS = [row objectAtIndex:4];
        NSString * SD = [row objectAtIndex:5];
        NSString * WSE = [row objectAtIndex:6];
        NSString * time = [row objectAtIndex:7];
        NSString * njd = [row objectAtIndex:8];
        NSString * qy = [row objectAtIndex:9];
        NSString * rain = [row objectAtIndex:10];
        
        
        WeatherModel * weather = [[WeatherModel alloc] init];
        weather.city = city;
        weather.cityid = cityid;
        weather.temp = temp;
        weather.WD = WD;
        weather.WS = WS;
        weather.SD = SD;
        weather.WSE = WSE;
        weather.time = time;
        weather.njd = njd;
        weather.qy = qy;
        weather.rain = rain;
        
        
        [weathers addObject:weather];
    }
    
    return weathers;

}


@end
