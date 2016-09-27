//
//  HistoryViewController.m
//  WeatherReport
//
//  Created by dan on 14-5-3.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "HistoryViewController.h"

static HistoryViewController * instance;
static NSInteger i;

@implementation HistoryViewController

@synthesize tempArray;

+ (id) shareInstance1
{
    if (instance == nil) {
        instance = [[[self class]alloc] init];
    }
    return instance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"历史记录";
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //显示历史查询过的城市
    data = [[WeatherDB shareInstance] findWeather];
    
    [table reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //右上角添加删除按钮
    UIBarButtonItem *delete_item = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(itemClicked:)];
    
    self.navigationItem.rightBarButtonItem = delete_item;
    
    iCount = 0;   //iCount用于记录删除按钮点击次数
    
    //添加搜索栏
    search = [[UISearchBar alloc] init];
    search.frame = CGRectMake(0, 64, self.view.frame.size.width, 44);
    search.placeholder = @"请输入城市名称";    
    search.delegate = self;    
    [self.view addSubview:search];
    
    // 显示ScopeBar
//    [search setShowsScopeBar:YES];  
//    [search sizeToFit];
//    NSArray *tempArr = [NSArray arrayWithObjects:@"中文",@"英文",nil];
//    [search setScopeButtonTitles:tempArr];
//    search.selectedScopeButtonIndex = 0;
        
    //添加tableView
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-108)];
    [self.view addSubview:table];
    table.delegate = self;
    table.dataSource = self;
    table.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    //添加searchControl
    searchControl = [[UISearchDisplayController alloc] initWithSearchBar:search contentsController:self];
    searchControl.searchResultsDataSource = self;
    searchControl.searchResultsDelegate = self;
    
    
    
    //显示历史查询过的城市
    data = [[WeatherDB shareInstance] findWeather];
    
    
}

//搜索历史城市 
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //输入为空或取消输入
    if ([searchText length] == 0) {
        //查询所有
        data = [[WeatherDB shareInstance]findWeather];
        [table reloadData];
        return;
    }
    
    //输入城市进行搜索
    NSPredicate *scopePredicate;
    tempArray = [NSMutableArray array];//临时数组存放搜索后的城市所有数据
    
    NSString *searchStr = [NSString stringWithFormat:@"SELF BEGINSWITH '%@'",searchText];
    NSLog(@"searchStr :%@",searchStr);
    scopePredicate = [NSPredicate predicateWithFormat:searchStr];
    NSLog(@"scopePredicate:%@",scopePredicate);
    
    for (int j = 0; j < [data count]; j++) {
        
        model = [data objectAtIndex:j];

        BOOL boo = [scopePredicate evaluateWithObject:model.city];  //bool变量用于判断字符匹配结果
        if (boo) {
            [tempArray addObject:model];   //将与搜索内容匹配的城市相关信息存入数组tempArray中
        }

    }
    
    data = [NSMutableArray arrayWithArray:tempArray];
  
    //刷新table
    [table reloadData];
     
}


//点击cell右侧的箭头触发事件
/*- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //如果未进行搜索，则显示所有的城市内容 
    if ((search.text.length == 0)) {
        data = [[WeatherDB shareInstance]findWeather];
        model = [data objectAtIndex:indexPath.row];
        i = indexPath.row;
    }
    //如果进行了搜索，则显示搜索后的城市内容
    else{
        model = [tempArray objectAtIndex:indexPath.row];
        NSLog(@"%@",model.cityid);
        data = [[WeatherDB shareInstance]findWeather];
        for (int index = 0; index < data.count; index++) {
            WeatherModel *tempModel = [[WeatherModel alloc] init];
            tempModel = [data objectAtIndex:index];
            if ([model.cityid isEqualToString:tempModel.cityid]) {
                i = index;
            }
        }
    }
    DetailViewController *vc = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
  
}*/


//传值
-(NSInteger)equal
{
    int j;
    j=i;
    return j;
}

#pragma mark - 单元格移动、删除操作

//点击“删除”按钮触发事件
-(void)itemClicked:(UIBarButtonItem *)barBtn
{
    if (iCount % 2 == 0) {
        //启动表格的编辑模式
        [table setEditing:YES animated:YES];
        barBtn.title = @"完成";
    }
    else{
        //关闭表格的编辑模式
        [table setEditing:NO animated:YES];
        barBtn.title = @"编辑";
        
    }
    iCount ++;
    
    
}

//编辑按钮---默认设置为可删除状态
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//可移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//执行移动操作
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

//删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUInteger row = [indexPath row];
        [data removeObjectAtIndex:row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSMutableArray *array = [[WeatherDB shareInstance]findWeather];
        WeatherModel *model1 = [array objectAtIndex:indexPath.row];
        
        array = [[WeatherDB shareInstance]deleteWeather:model1.cityid];
        [tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    model = [data objectAtIndex:indexPath.row];
    
    cell.textLabel.text = model.city;
//    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //如果未进行搜索，则显示所有的城市内容
    if ((search.text.length == 0)) {
        data = [[WeatherDB shareInstance]findWeather];
        model = [data objectAtIndex:indexPath.row];
        i = indexPath.row;
    }
    //如果进行了搜索，则显示搜索后的城市内容
    else{
        model = [tempArray objectAtIndex:indexPath.row];
        NSLog(@"%@",model.cityid);
        data = [[WeatherDB shareInstance]findWeather];
        for (int index = 0; index < data.count; index++) {
            WeatherModel *tempModel = [[WeatherModel alloc] init];
            tempModel = [data objectAtIndex:index];
            if ([model.cityid isEqualToString:tempModel.cityid]) {
                i = index;
            }
        }
    }
    DetailViewController *vc = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
