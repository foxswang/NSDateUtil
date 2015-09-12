//
// NSDate+Util.h
//
//  Created by fox on 15/9/12.
//  www.appask.cn ios开发的知乎
// ios开发交流群：486468672
//  Copyright (c) 2015年 fox. All rights reserved.
//


#import <Foundation/Foundation.h>

#pragma mark - 时间格式化举例
/*
MMM d, yyyy h:mm a      9月 12, 2015 7:36 下午
MMM d, yyyy             9月 12, 2015
MMM d h:mm a            9月 12 7:36 下午
MMM d                   9月 12
EEEE                    星期六
EEEE h:mm a             星期六 7:36 下午
'at' h:mm a             at 7:36 下午
yyyy-MM-dd              2015-09-12
HH:mm:ss                19:36:24
yyyy-MM-dd HH:mm:ss     2015-09-12 19:36:24
 */

@interface NSDate (Util)

+ (void)initializeStatics;

+ (NSCalendar *)sharedCalendar;
+ (NSDateFormatter *)sharedDateFormatter;
+ (NSDateComponents *)componentsFromDate:(NSDate *)date;

//当前秒数
- (long int)utcTimeStamp; //full seconds since


#pragma mark - 时间详细

/*
 获取时间的详细
 */
- (NSUInteger)second;
- (NSUInteger)minute;
- (NSUInteger)hour;
- (NSUInteger)day;
- (NSUInteger)weekday;
- (NSUInteger)weekNumber;
- (NSUInteger)month;
- (NSUInteger)year;

#pragma mark - 常用功能

- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isTomorrow;

#pragma mark - 星期月
+ (BOOL)dateIsSunday:(NSDate *)date;
+ (BOOL)dateIsMonday:(NSDate *)date;
+ (BOOL)dateIsTuesday:(NSDate *)date;
+ (BOOL)dateIsWednesday:(NSDate *)date;
+ (BOOL)dateIsThurday:(NSDate *)date;
+ (BOOL)dateIsFriday:(NSDate *)date;
+ (BOOL)dateIsSaturday:(NSDate *)date;

//本周第一天
- (NSDate *)beginningOfWeek;
//今天0点0分
- (NSDate *)beginningOfDay;
//本周的最后一天时间
- (NSDate *)endOfWeek;
//获取该日期所在的月的天数
+ (int)numOfDaysOnMonth:(NSDate *)date;

#pragma mark - 时间距离

+ (BOOL)date:(NSDate *)date1 isBetweenDate:(NSDate *)date2 :(NSDate *)date3;
//计算间隔天数，间隔不到24小时，如在不同的日期，相隔天数为1天
//返回负数，fromDate 在toDate之前
//返回正数，fromDate 在toDate之后
+ (NSInteger)distanceDay:(NSDate *)fromDate withDate:(NSDate *)toDate;
//距离今天多少天
//比当前时间早，返回正数
//比当前时间晚，返回负数
- (NSUInteger)distanceWithToday;

#pragma mark - 创建NSDate

+ (NSDate *)dateFromString:(NSString *)string;
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSDate *)dateFromYear:(int)yyyy month:(int)mm day:(int)dd;
+ (NSDate *)dateFromYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi;
+ (NSDate *)dateFromYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi second:(int)ss;

//对日期的修改
+ (NSDate *)dateByAddingYear:(int)year toDate:(NSDate *)date;
+ (NSDate *)dateByAddingMonth:(int)month toDate:(NSDate *)date;
+ (NSDate *)dateByAddingDay:(int)day toDate:(NSDate *)date;
+ (NSDate *)dateByAddingHour:(int)hour toDate:(NSDate *)date;
+ (NSDate *)dateByAddingMinute:(int)minute toDate:(NSDate *)date;
+ (NSDate *)dateByAddingSecond:(int)second toDate:(NSDate *)date;


#pragma mark - 日期格式化

//今天，昨天 ， N天前
- (NSString *)stringDaysAgo;
//刚刚N分钟前，N小时前，昨天 HH:mm, YYYY-MM HH:mm
- (NSString *)stringWithHumanReadEasy;

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)string;
+ (NSString *)stringFromDate:(NSDate *)date;
- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

#pragma mark - 时间格式化字符串常量

+ (NSString *)formatDateString;
+ (NSString *)formatTimeString;
+ (NSString *)formatTimestampString;
+ (NSString *)formatDbString;



@end
