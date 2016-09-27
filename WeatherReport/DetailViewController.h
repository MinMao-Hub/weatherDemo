//
//  DetailViewController.h
//  WeatherReport
//
//  Created by dan on 14-5-1.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetRequest.h"
#import "HistoryViewController.h"
#import "WeatherDB.h"

@interface DetailViewController : UITableViewController
{
    NSArray *data;

    NSInteger iCount;
}


@property (nonatomic, strong) NSArray *array;
@end
