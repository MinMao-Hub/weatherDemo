//
//  BaseDB.h
//  UserDemo
//
//  Created by dan on 14-4-25.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface BaseDB : NSObject
//文件存放路径
- (NSString *) filePath;
//创建表
-(void) createTable:(NSString *) sql;
//插入、删除、修改数据
-(BOOL) dealData:(NSString *) sql paramsarray:(NSArray *) params;
//查询数据
- (NSMutableArray *) selectData:(NSString *) sql columns:(int) number;

@end
