//
//  MainViewController.h
//  WeatherReport
//
//  Created by dan on 14-4-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetRequest.h"
#import "HistoryViewController.h"

@interface MainViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong) UIPickerView *pickerView;   //选择器
@property(nonatomic,strong) NSDictionary *pickerData;   //保存全部数据
@property(nonatomic,strong) NSArray *provinces;         //当前的省数据
@property(nonatomic,strong) NSArray *citynames;         //当前省下面的城市名称

@end
