//
// NSDate+Helper.h
//
// Created by fox refer   Billy Gray's NSDate+Helper
//  www.appask.cn ios开发的知乎
//  Created by fox on 15/9/12.
//  Copyright (c) 2015年 fox. All rights reserved.
//

#import "NSDate+Util.h"

static NSString *kNSDateHelperFormatFullDateWithTime    = @"MMM d, yyyy h:mm a";
static NSString *kNSDateHelperFormatFullDate            = @"MMM d, yyyy";
static NSString *kNSDateHelperFormatShortDateWithTime   = @"MMM d h:mm a";
static NSString *kNSDateHelperFormatShortDate           = @"MMM d";
static NSString *kNSDateHelperFormatWeekday             = @"EEEE";
static NSString *kNSDateHelperFormatWeekdayWithTime     = @"EEEE h:mm a";
static NSString *kNSDateHelperFormatTime                = @"h:mm a";
static NSString *kNSDateHelperFormatTimeWithPrefix      = @"'at' h:mm a";
static NSString *kNSDateHelperFormatSQLDate             = @"yyyy-MM-dd";
static NSString *kNSDateHelperFormatSQLTime             = @"HH:mm:ss";
static NSString *kNSDateHelperFormatSQLDateWithTime     = @"yyyy-MM-dd HH:mm:ss";

@implementation NSDate (Util)

static NSCalendar *_calendar = nil;
static NSDateFormatter *_displayFormatter = nil;

+ (void)initializeStatics {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            if (_calendar == nil) {
#if __has_feature(objc_arc)
               _calendar = [NSCalendar currentCalendar];
#else
                _calendar = [[NSCalendar currentCalendar] retain];
#endif
            }
            if (_displayFormatter == nil) {
                _displayFormatter = [[NSDateFormatter alloc] init];
            }
        }
    });
}

+ (NSCalendar *)sharedCalendar
{
    [self initializeStatics];
    return _calendar;
}

+ (NSDateFormatter *)sharedDateFormatter
{
    [self initializeStatics];
    return _displayFormatter;
}

+ (NSDateComponents *)componentsFromDate:(NSDate *)date
{
    if(!date) return nil;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //	[gregorian setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];
}

- (long int)utcTimeStamp{
    return lround(floor([self timeIntervalSince1970]));
}

#pragma mark - 时间详细

//秒
- (NSUInteger)second
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:self];
    return [weekdayComponents second];
}


//分钟
- (NSUInteger)minute
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:self];
    return [weekdayComponents minute];
}

//小时
- (NSUInteger)hour
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSHourCalendarUnit) fromDate:self];
    return [weekdayComponents hour];
}

//天
- (NSUInteger)day
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSDayCalendarUnit) fromDate:self];
    return [weekdayComponents day];
}

//星期
- (NSUInteger)weekday
{
    NSDateComponents *weekdayComponents = [[[self class] sharedCalendar] components:(NSWeekdayCalendarUnit) fromDate:self];
    return [weekdayComponents weekday];
}

//本年第多少周
- (NSUInteger)weekNumber
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSWeekCalendarUnit) fromDate:self];
    return [dateComponents week];
}

//月
- (NSUInteger)month
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *monthComponents = [calendar components:(NSMonthCalendarUnit) fromDate:self];
    return [monthComponents month];
}

//年
- (NSUInteger)year
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSYearCalendarUnit) fromDate:self];
    return [weekdayComponents year];
}

#pragma mark - 常用功能
- (BOOL)isToday
{
    NSInteger dayDistance = [NSDate distanceDay:self withDate:[NSDate date]];
    return dayDistance == 0;
}
- (BOOL)isYesterday
{
    NSInteger dayDistance = [NSDate distanceDay:self withDate:[NSDate date]];
    return dayDistance == -1;
}
- (BOOL)isTomorrow
{
    NSInteger dayDistance = [NSDate distanceDay:self withDate:[NSDate date]];
    return dayDistance == 1;
}

#pragma mark - 星期判断
+ (BOOL)dateIsSunday:(NSDate *)date
{
    return date && [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday]==1;
}

+ (BOOL)dateIsMonday:(NSDate *)date
{
    return date && [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday]==2;
}

+ (BOOL)dateIsTuesday:(NSDate *)date
{
    return date && [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday]==3;
}

+ (BOOL)dateIsWednesday:(NSDate *)date
{
    return date && [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday]==4;
}

+ (BOOL)dateIsThurday:(NSDate *)date
{
    return date && [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday]==5;
}

+ (BOOL)dateIsFriday:(NSDate *)date
{
    return date && [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday]==6;
}

+ (BOOL)dateIsSaturday:(NSDate *)date
{
    return date && [[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] components:NSWeekdayCalendarUnit fromDate:date] weekday]==7;
}

- (NSDate *)beginningOfWeek
{
    // largely borrowed from "Date and Time Programming Guide for Cocoa"
    // we'll use the default calendar and hope for the best
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDate *beginningOfWeek = nil;
    BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek
                           interval:NULL forDate:self];
    if (ok) {
        return beginningOfWeek;
    }
    // couldn't calc via range, so try to grab Sunday, assuming gregorian style
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    /*
     Create a date components to represent the number of days to subtract from the current date.
     The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today's Sunday, subtract 0 days.)
     */
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 1)];
    beginningOfWeek = nil;
    beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
#if !__has_feature(objc_arc)
    [componentsToSubtract release];
#endif
    //normalize to midnight, extract the year, month, and day components and create a new date from those components.
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                               fromDate:beginningOfWeek];
    return [calendar dateFromComponents:components];
}

- (NSDate *)beginningOfDay
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    // Get the weekday component of the current date
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                               fromDate:self];
    return [calendar dateFromComponents:components];
}

- (NSDate *)endOfWeek {
    NSCalendar *calendar = [[self class] sharedCalendar];
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:(7 - [weekdayComponents weekday])];
    NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
#if !__has_feature(objc_arc)
    [componentsToAdd release];
#endif
    return endOfWeek;
}

+ (int)numOfDaysOnMonth:(NSDate *)date {
    NSDateComponents *components = [[self class] componentsFromDate:date];
    
    NSInteger month = [components month];
    if(month == 4 || month == 6 || month == 9 || month == 11)
        return 30;
    
    if(month == 2) {
        NSInteger year = [components year];
        if(((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0))
            return 29;
        else
            return 28;
    }
    return 31;
}

#pragma mark - 时间距离

+ (BOOL)date:(NSDate *)date1 isBetweenDate:(NSDate *)date2 :(NSDate *)date3
{
    return ([date2 compare:date1]==NSOrderedAscending && [date3 compare:date1]==NSOrderedDescending) ||
    ( [date2 compare:date1]!=NSOrderedDescending && [date3 compare:date1]!=NSOrderedAscending);
}

//计算间隔天数，间隔不到24小时，如在不同的日期，相隔天数为1天
//返回负数，fromDate 在toDate之前
//返回正数，fromDate 在toDate之后
+ (NSInteger)distanceDay:(NSDate *)fromDate withDate:(NSDate *)toDate
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    
    NSDateFormatter *mdf = [[self class] sharedDateFormatter];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnightFrom = [mdf dateFromString:[mdf stringFromDate:fromDate]];
    NSDate *midnightTo = [mdf dateFromString:[mdf stringFromDate:toDate]];
    
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:midnightFrom
                                                 toDate:midnightTo                                                options:0];
    return [components day]*-1;
}

//按照午夜时间比较的
//当前于现在的午夜时间比较
- (NSUInteger)distanceWithToday
{
    // get a midnight version of ourself:
    NSDateFormatter *mdf = [[self class] sharedDateFormatter];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
    return (int)[midnight timeIntervalSinceNow] / (60*60*24) *-1;
}


#pragma mark - 创建NSDate

+ (NSDate *)dateFromString:(NSString *)string
{
    return [NSDate dateFromString:string withFormat:[NSDate formatDbString]];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format
{
    NSDateFormatter *formatter = [self sharedDateFormatter];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:string];
    return date;
}


//	根据年月日创建date
//
+ (NSDate *)dateFromYear:(int)yyyy month:(int)mm day:(int)dd
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy,MM,dd,HH,mm,ss"];
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [dateFormatter dateFromString:[NSString stringWithFormat:@"%d,%d,%d,00,00,00", yyyy, mm, dd]];
}

//
//  根据年月日小时分，创建date
//
+ (NSDate *)dateFromYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy,MM,dd,HH,mm,ss"];
    //	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [dateFormatter dateFromString:[NSString stringWithFormat:@"%d,%d,%d,%d,%d,00", yyyy, mm, dd, hh, mi]];
}

//
//  根据年月日小时分秒，创建date
//
+ (NSDate *)dateFromYear:(int)yyyy month:(int)mm day:(int)dd hour:(int)hh minute:(int)mi second:(int)ss
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy,MM,dd,HH,mm,ss"];
    //	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [dateFormatter dateFromString:[NSString stringWithFormat:@"%d,%d,%d,%d,%d,%d", yyyy, mm, dd, hh, mi, ss]];
}


//
//	增加年
//
+ (NSDate *)dateByAddingYear:(int)year toDate:(NSDate *)date
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year=year;
    
    NSCalendar *calendar= [[self class] sharedCalendar];
    return [calendar dateByAddingComponents:components toDate:date options:0];
}
//
//	增加月
//
+ (NSDate *)dateByAddingMonth:(int)month toDate:(NSDate *)date
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month=month;
    
    NSCalendar *calendar= [[self class] sharedCalendar];
    return [calendar dateByAddingComponents:components toDate:date options:0];
}
//
//	增加天
//
+ (NSDate *)dateByAddingDay:(int)day toDate:(NSDate *)date
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day=day;
    
    NSCalendar *calendar=[[self class] sharedCalendar];
    return [calendar dateByAddingComponents:components toDate:date options:0];
}
//
//	增加小时
//
+ (NSDate *)dateByAddingHour:(int)hour toDate:(NSDate *)date
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour=hour;
    
    NSCalendar *calendar=[[self class] sharedCalendar];
    return [calendar dateByAddingComponents:components toDate:date options:0];
}
//
//	增加分钟
//
+ (NSDate *)dateByAddingMinute:(int)minute toDate:(NSDate *)date
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.minute=minute;
    
    NSCalendar *calendar=[[self class] sharedCalendar];
    return [calendar dateByAddingComponents:components toDate:date options:0];
}
//
//	Return a date with second added.
//
+ (NSDate *)dateByAddingSecond:(int)second toDate:(NSDate *)date
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.second=second;
    
    NSCalendar *calendar=[[self class] sharedCalendar];
    return [calendar dateByAddingComponents:components toDate:date options:0];
}

#pragma mark - 日期格式化

- (NSString *)stringDaysAgo
{
    NSUInteger daysAgo = [self distanceWithToday];
    NSString *text = nil;
    switch (daysAgo) {
        case 0:
            text = NSLocalizedString(@"今天", nil);
            break;
        case 1:
            text = NSLocalizedString(@"昨天", nil);
            break;
        default:
            text = [NSString stringWithFormat:@"%ld天前", (long)daysAgo];
    }
    return text;
}

- (NSString *)stringWithHumanReadEasy
{
    NSTimeInterval interval = [self timeIntervalSinceNow];
    if (interval > 0) {
        return [self stringWithFormat:@"yyyy-MM-dd HH:mm"];
    } else {
        interval = abs((int)interval);
    }
    
    if (interval<1*60) {
        return @"刚刚";
    } else if (interval < 60*60){
        return [NSString stringWithFormat:@"%ld分钟前",(long)(interval/60.0)];
    } else if (interval < 60*60*24 ){
        return [NSString stringWithFormat:@"%ld小时前",(long)(interval/(60*60.0))];
    }
    
    if ([NSDate distanceDay:self withDate:[NSDate date]] == -1) {
        return [self stringWithFormat:@"昨天 HH:mm"];
    }
    
    return [self stringWithFormat:@"yyyy-MM-dd HH:mm"];
}


+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format
{
	return [date stringWithFormat:format];
}

+ (NSString *)stringFromDate:(NSDate *)date
{
	return [date string];
}


- (NSString *)stringWithFormat:(NSString *)format
{
	[[[self class] sharedDateFormatter] setDateFormat:format];
	NSString *timestamp_str = [[[self class] sharedDateFormatter] stringFromDate:self];
	return timestamp_str;
}

- (NSString *)string {
	return [self stringWithFormat:[NSDate formatDbString]];
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
	[[[self class] sharedDateFormatter] setDateStyle:dateStyle];
	[[[self class] sharedDateFormatter] setTimeStyle:timeStyle];
	NSString *outputString = [[[self class] sharedDateFormatter] stringFromDate:self];
	return outputString;
}

#pragma mark - 时间格式化字符串常量

+ (NSString *)formatDateString
{
	return kNSDateHelperFormatSQLDate;
}

+ (NSString *)formatTimeString
{
	return kNSDateHelperFormatSQLTime;
}

+ (NSString *)formatTimestampString
{
	return kNSDateHelperFormatSQLDateWithTime;
}

// preserving for compatibility
+ (NSString *)formatDbString
{

	return [NSDate formatTimestampString];
}

+ (NSString *)getWeChatFormatDateStringBySourceDate:(NSDate *)sourceDate
{

    
    NSString *ret = @"";
    
    if (!sourceDate) {
        
        return ret;
    }
    
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit |NSWeekdayCalendarUnit;
    
    NSDateComponents *sourceDateComponents = [cal components:unitFlags fromDate:sourceDate];
    
    int messageWeek = [sourceDateComponents weekday];
    
    
    
    NSDateComponents *nowDateComponents = [cal components:unitFlags fromDate:[NSDate date]];
    
    int nowWeek = [nowDateComponents weekday];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeInterval second = [[NSDate date] timeIntervalSinceDate:sourceDate];
    
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-86400];
    
    NSString * nowDayString = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString * sourceDateofDayString = [dateFormatter stringFromDate:sourceDate];
    
    NSString * yesterdayString = [dateFormatter stringFromDate:yesterday];
    
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    
    //相差的小时数
    int hours = second / 3600;
    
    
    if ([nowDayString isEqualToString:sourceDateofDayString]) {
        
        [dateFormatter setDateFormat:hasAMPM?@"a h:mm":@"HH:mm"];
        ret = [dateFormatter stringFromDate:sourceDate];
    }
    else if( [yesterdayString isEqualToString:sourceDateofDayString]){
        
        [dateFormatter setDateFormat:hasAMPM?@"a h:mm":@"HH:mm"];
        ret = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:sourceDate]];
        
    }
   
    else  if(hours <= 24 * 7) {
        
        [dateFormatter setDateFormat:hasAMPM?@"a h:mm":@"HH:mm"];
        NSString *time = [dateFormatter stringFromDate:sourceDate];
        
        if (messageWeek == 1) { //周日
            
            ret = [NSString stringWithFormat:@" 周日 %@",time];
        }
        
        if (nowWeek > messageWeek) {
            
            ret = [NSString stringWithFormat:@" %@ %@",[self getWeekString:messageWeek],time];
        }
        else {
        
            ret = [NSString stringWithFormat:@" %@ %@",[self getWeekString:messageWeek],time];
        }
        
    }
    
    else {
        
        [dateFormatter setDateFormat:hasAMPM?@"yyyy年M月d日 a h:mm":@"yyyy年M月d日 HH:mm"];
        ret = [dateFormatter stringFromDate:sourceDate];
        
    }
    
    return ret;
}


+ (NSString*)getWeekString:(int)weekIndex
{
    
    NSString *ret = @"";
    
    switch (weekIndex) {
        case 1:
            ret = @"周日";
            break;
        case 2:
            ret = @"周一";
            break;
        case 3:
            ret = @"周二";
            break;
        case 4:
            ret = @"周三";
            break;
        case 5:
            ret = @"周四";
            break;
        case 6:
            ret = @"周五";
            break;
        case 7:
            ret = @"周六";
            break;
        default:
            break;
    }
    return ret;
}

@end
