//
//  BaseDB.m
//  UserDemo
//
//  Created by dan on 14-4-25.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "BaseDB.h"

#define kFilename @"data.sqlite"

@implementation BaseDB

- (NSString *) filePath
{
    NSString * filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",kFilename];
    return filePath;
}

//创建表
-(void) createTable:(NSString *) sql
{
    sqlite3 * sqlite = nil;
    //打开数据库
    if (sqlite3_open([self.filePath UTF8String], &sqlite) != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        sqlite3_close(sqlite);
        return;
    }
    //执行创建表sql语句
    char * errmsg;
    if (sqlite3_exec(sqlite, [sql UTF8String], NULL, NULL, &errmsg)) {
        NSLog(@"创建表失败：%s",errmsg);
        sqlite3_close(sqlite);
    }
    //关闭数据库
    sqlite3_close(sqlite);
    
}

//插入、删除、修改数据
-(BOOL) dealData:(NSString *) sql paramsarray:(NSArray *) params
{
    sqlite3 * sqlite = nil;
    sqlite3_stmt * stmt = nil;
    
    //打开数据库
    if (sqlite3_open([self.filePath UTF8String], &sqlite) != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        sqlite3_close(sqlite);
        return NO;
    }
    
    //编译sql语句
    if (sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL)) {
        NSLog(@"SQL语句编译失败");
        sqlite3_close(sqlite);
        return NO;
    }
    //绑定数据
    for (int i = 0; i < params.count; i++) {
        NSString * value = [params objectAtIndex:i];
        sqlite3_bind_text(stmt, i+1, [value UTF8String], -1, NULL);
    }
    //执行SQL语句
    if (sqlite3_step(stmt) == SQLITE_ERROR) {
        NSLog(@"SQL语句执行失败");
    }
    
    //关闭数据库
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    
    return YES;
    
}

//查询数据
- (NSMutableArray *) selectData:(NSString *) sql columns:(int) number
{
    sqlite3 * sqlite = nil;
    sqlite3_stmt * stmt = nil;

    //打开数据库
    if (sqlite3_open([self.filePath UTF8String], &sqlite) != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        sqlite3_close(sqlite);
        return nil;
    }
    
    //编译sql语句
    if (sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL)) {
        NSLog(@"SQL语句编译失败");
        sqlite3_close(sqlite);
        return nil;
    }
    
    //查询数据
    int result = sqlite3_step(stmt);
    NSMutableArray *data = [NSMutableArray array];
    
    while (result == SQLITE_ROW) {
        
        NSMutableArray *row = [NSMutableArray arrayWithCapacity:3];
        
        for (int i = 0; i < number; i++) {
            char *columnText = (char *) sqlite3_column_text(stmt, i);
            NSString *string = [NSString stringWithCString:columnText encoding:NSUTF8StringEncoding];
            [row addObject:string];
        }
        
        [data addObject:row];
        result = sqlite3_step(stmt);
    }
    
    //关闭数据库
    sqlite3_finalize(stmt);
    sqlite3_close(sqlite);
    
    return data;

}

@end
