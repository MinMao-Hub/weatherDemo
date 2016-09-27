//
//  City_WeatherViewController.m
//  WeatherReport
//
//  Created by dan on 14-4-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "City_WeatherViewController.h"
#import "WeatherModel.h"
#import "WeatherDB.h"

@implementation City_WeatherViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"城市天气";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    data = [[WeatherDB shareInstance]findWeather];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    WeatherModel *model = [data objectAtIndex:[data count]-1];

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"城市:";
            cell.detailTextLabel.text = model.city;
            break;
        case 1:
            cell.textLabel.text = @"城市ID:";
            cell.detailTextLabel.text = model.cityid;
            break;
        case 2:
            cell.textLabel.text = @"温度:";
            cell.detailTextLabel.text = model.temp;
            break;
        case 3:
            cell.textLabel.text = @"风向:";
            cell.detailTextLabel.text = model.WD;
            break;
        case 4:
            cell.textLabel.text = @"风级:";
            cell.detailTextLabel.text = model.WS;
            break;
        case 5:
            cell.textLabel.text = @"湿度:";
            cell.detailTextLabel.text = model.SD;
            break;
        case 6:
            cell.textLabel.text = @"风力:";
            cell.detailTextLabel.text = model.WSE;
            break;
        case 7:
            cell.textLabel.text = @"更新时间:";
            cell.detailTextLabel.text = model.time;
            break;
            
        default:
            break;
    }
    return cell;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
