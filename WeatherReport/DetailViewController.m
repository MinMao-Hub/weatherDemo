//
//  DetailViewController.m
//  WeatherReport
//
//  Created by dan on 14-5-1.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"


@implementation DetailViewController

@synthesize array = _array;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"城市天气";
            
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    //右上角添加刷新按钮
    UIBarButtonItem *refresh_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];

    self.navigationItem.rightBarButtonItem = refresh_item;
    
    UIImageView *bjView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bj.jpg"]];
    self.tableView.backgroundView = bjView;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self refresh];
    
}


//点击“刷新”按钮触发事件
-(void)refresh
{
   // 找到该城市的天气情况
    HistoryViewController * myHistory =[[HistoryViewController alloc]init];        
    NSMutableArray *data1 = [[WeatherDB shareInstance] findWeather];
    WeatherModel * model= [data1 objectAtIndex:[myHistory equal]]; 
    
        
    //重新请求网络数据
    NetRequest *netRequest = [[NetRequest alloc] init];
    [netRequest startRequestWithCityId:model.cityid andCompletinonhandler:^(WeatherModel *model) {
        //更新数据库中的数据
        [[WeatherDB shareInstance] updateWeather:model];
        [self.tableView reloadData];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    //显示具体城市天气
    data = [[WeatherDB shareInstance] findWeather];

    WeatherModel * model = [[WeatherModel alloc]init];

    model= [data objectAtIndex:[[HistoryViewController shareInstance1] equal]];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"城市:";
            cell.detailTextLabel.text = model.city;
            break;
//        case 1:
//            cell.textLabel.text = @"城市ID:";
//            cell.detailTextLabel.text = model.cityid;
//            break;
        case 1:
            cell.textLabel.text = @"温度:";
            cell.detailTextLabel.text = model.temp;
            break;
        case 2:
            cell.textLabel.text = @"风向:";
            cell.detailTextLabel.text = model.WD;
            break;
        case 3:
            cell.textLabel.text = @"风级:";
            cell.detailTextLabel.text = model.WS;
            break;
        case 4:
            cell.textLabel.text = @"湿度:";
            cell.detailTextLabel.text = model.SD;
            break;
        case 5:
            cell.textLabel.text = @"风力:";
            cell.detailTextLabel.text = model.WSE;
            break;
        case 6:
            cell.textLabel.text = @"更新时间:";
            cell.detailTextLabel.text = model.time;
            break;
        case 7:
            cell.textLabel.text = @"能见度:";
            cell.detailTextLabel.text = model.njd;
            break;
        case 8:
            cell.textLabel.text = @"气压:";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@百帕",model.qy];
            break;
        case 9:
            cell.textLabel.text = @"雨:";
            cell.detailTextLabel.text = [model.rain isEqualToString:@"1"] ? @"有雨" : @"无";
            break;
            
        default:
            break;
    }

    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
