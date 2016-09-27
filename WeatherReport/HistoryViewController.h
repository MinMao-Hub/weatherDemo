//
//  HistoryViewController.h
//  WeatherReport
//
//  Created by dan on 14-5-3.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherDB.h"
#import "WeatherModel.h"
#import "DetailViewController.h"

@interface HistoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,UISearchBarDelegate>
{
    NSMutableArray *data;
    WeatherModel *model;
    
    UITableView *table;
    UISearchBar *search;
    UISearchDisplayController *searchControl;
    
    int iCount;   //记录删除按钮点击次数
}

@property (nonatomic ,retain)NSMutableArray *tempArray;//临时数组存放搜索后的城市所有数据

+ (id) shareInstance1;

-(NSInteger)equal;//传值


@end
