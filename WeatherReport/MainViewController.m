//
//  MainViewController.m
//  WeatherReport
//
//  Created by dan on 14-4-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize pickerView,pickerData,provinces,citynames;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"天气";
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建表
    [[WeatherDB shareInstance] createTable];
    
    
    UIBarButtonItem *history_item = [[UIBarButtonItem alloc] initWithTitle:@"历史记录" style:UIBarButtonItemStylePlain target:self action:@selector(itemClicked)];
    self.navigationItem.rightBarButtonItem = history_item;
    
    //添加label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 64, 120, 30)];
    label.text = @"请选择城市:";
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;
    label.layer.borderWidth = 1;
    label.layer.borderColor = [UIColor yellowColor].CGColor;
    [self.view addSubview:label];
    
    //添加选择器
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 95, self.view.frame.size.width, 200)];
    pickerView.showsSelectionIndicator = YES;
    pickerView.layer.cornerRadius = 5;
    pickerView.layer.masksToBounds = YES;
    pickerView.layer.borderWidth = 1;
    pickerView.layer.borderColor = [UIColor greenColor].CGColor;
    [self.view addSubview:pickerView];
    
    
    //为pickerView添加代理
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    
    //获取plist文件中的全部数据
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"City" ofType:@"plist"];
 
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.pickerData = dict;
    
    
    //省份名数据
    self.provinces = [self.pickerData allKeys];
    
    //默认取出第一个省的所有市的数据
    NSArray *proArr = [self.provinces objectAtIndex:0];  //取出第一个省
    NSLog(@"第一个省 : %@",proArr);
    NSArray *proArray = [self.pickerData objectForKey:proArr];//取出第一个省的array
    NSDictionary *proDic = [proArray objectAtIndex:0];//取出第一个省的array下的Dictionary
    self.citynames = [proDic allKeys];
    
    
    //添加button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 340, 100, 30);
    [btn setTitle:@"确  定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 15;
    btn.layer.masksToBounds = YES;
    
    btn.layer.borderWidth = 2;
    btn.layer.borderColor = [UIColor redColor].CGColor;
    
    [self.view addSubview:btn];

}

//点击“历史记录”按钮触发事件
-(void)itemClicked
{
    //跳转到历史记录页面
    HistoryViewController *history = [[HistoryViewController alloc] init];
    [self.navigationController pushViewController:history animated:YES];
}


//为鼠标点击添加事件
-(void)btnClicked
{
    NSInteger row1 = [self.pickerView selectedRowInComponent:0];//选的哪个省
    NSInteger row2 = [self.pickerView selectedRowInComponent:1];//选的哪个市

    NSString *selectedCity = [self.citynames objectAtIndex:row2];
    
    NSLog(@"selectedCity is %@",selectedCity);

    NSString *selectedProvince = [self.provinces objectAtIndex:row1];
    NSArray *arr2 = [self.pickerData objectForKey:selectedProvince];
    NSDictionary *dic = [arr2 objectAtIndex:0];
    NSString *cityID  = [dic objectForKey:selectedCity];
    
    NSLog(@"%@",cityID);
   
    //解析城市天气数据
    NetRequest *myRequest = [[NetRequest alloc]init];
    WeatherModel *model = [[WeatherModel alloc] init]; 
    model = [myRequest startRequest:cityID];
    
    
    //将解析后的数据存入数据库 
    [[WeatherDB shareInstance] addWeather:model];
    
   
    //跳转到显示城市天气的页面
    City_WeatherViewController *weatherVC = [[City_WeatherViewController alloc] init];
    [self.navigationController pushViewController:weatherVC animated:YES];
}

#pragma mark - UIPickerViewDelegate

//为选择器中的某个拨轮的行提供显示数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) { //选择省名
        return [self.provinces objectAtIndex:row];
    }else{//选择市名
        return [self.citynames objectAtIndex:row];
    }
}

//选中选择器中的某个拨轮的某行时调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        NSString *selectedProvince = [self.provinces objectAtIndex:row];
        NSArray *array = [self.pickerData objectForKey:selectedProvince];
        NSDictionary *dic = [array objectAtIndex:0];
        self.citynames = [dic allKeys];
        NSLog(@"cityname is %@",citynames);
        [self.pickerView reloadComponent:1];
    }
}
#pragma mark - UIpickviewDatasource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.provinces count];
    }else{
        return [self.citynames count];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

#pragma  _mark  UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if (component == 0) {
        return 40;
    }return 30;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 0) {
        return 120.0;
    }return self.view.frame.size.width - 120;
}
@end
