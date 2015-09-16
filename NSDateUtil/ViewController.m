//
//  ViewController.m
//  NSDateUtil
//
//  Created by fox on 15/9/12.
//  Copyright (c) 2015年 fox. All rights reserved.
//

#import "ViewController.h"
#import "NSDate+Util.h"

@interface ViewController ()
{
    UITextView *_txtView;
    
    UIScrollView *_scrollView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height*2);
    
    CGSize contentSize = CGSizeMake(frame.size.width, frame.size.height*2 +1);
    _scrollView = [[UIScrollView alloc] initWithFrame:frame];
    _scrollView.contentSize = contentSize;
    _txtView = [[UITextView alloc] initWithFrame:frame];
    _txtView.editable = NO;
    [_scrollView addSubview:_txtView];
    
    [self.view addSubview:_scrollView];
    
    [self timeTest];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)timeTest
{
    NSString *kNSDateHelperFormatFullDateWithTime    = @"MMM d, yyyy h:mm a";
    NSString *kNSDateHelperFormatFullDate            = @"MMM d, yyyy";
    NSString *kNSDateHelperFormatShortDateWithTime   = @"MMM d h:mm a";
    NSString *kNSDateHelperFormatShortDate           = @"MMM d";
    NSString *kNSDateHelperFormatWeekday             = @"EEEE";
    NSString *kNSDateHelperFormatWeekdayWithTime     = @"EEEE h:mm a";
    NSString *kNSDateHelperFormatTime                = @"h:mm a";
    NSString *kNSDateHelperFormatTimeWithPrefix      = @"'at' h:mm a";
    NSString *kNSDateHelperFormatSQLDate             = @"yyyy-MM-dd";
    NSString *kNSDateHelperFormatSQLTime             = @"HH:mm:ss";
    NSString *kNSDateHelperFormatSQLDateWithTime     = @"yyyy-MM-dd HH:mm:ss";
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:kNSDateHelperFormatFullDateWithTime];
    [array addObject:kNSDateHelperFormatFullDate];
    [array addObject:kNSDateHelperFormatShortDateWithTime];
    [array addObject:kNSDateHelperFormatShortDate];
    [array addObject:kNSDateHelperFormatWeekday];
    [array addObject:kNSDateHelperFormatWeekdayWithTime];
    [array addObject:kNSDateHelperFormatTime];
    [array addObject:kNSDateHelperFormatTimeWithPrefix];
    [array addObject:kNSDateHelperFormatSQLDate];
    [array addObject:kNSDateHelperFormatSQLTime];
    [array addObject:kNSDateHelperFormatSQLDateWithTime];
    
    NSDate *date = [NSDate date];
    
    for (NSString *str in array) {
        NSString *timeStr = [NSString stringWithFormat:@"%@-->%@",str, [NSDate stringFromDate:date withFormat:str]];
         NSLog(@"%@",timeStr);
        _txtView.text = [NSString stringWithFormat:@"%@\n%@",_txtView.text,timeStr];
    }
    
    //刚刚
    date  = [[NSDate alloc] initWithTimeInterval:-59 sinceDate:[NSDate date]];
    NSString *str  = [NSString stringWithFormat:@"%@-->%@",[date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"], [date stringWithHumanReadEasy]];
     _txtView.text = [NSString stringWithFormat:@"%@\n%@",_txtView.text,str];
   
   //2分钟前
    date  = [[NSDate alloc] initWithTimeInterval:-60*2 sinceDate:[NSDate date]];
    str  = [NSString stringWithFormat:@"%@-->%@",[date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"], [date stringWithHumanReadEasy]];
    _txtView.text = [NSString stringWithFormat:@"%@\n%@",_txtView.text,str];
    
    //2小时前
    date  = [[NSDate alloc] initWithTimeInterval:-60*60*2 sinceDate:[NSDate date]];
    str  = [NSString stringWithFormat:@"%@-->%@",[date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"], [date stringWithHumanReadEasy]];
    _txtView.text = [NSString stringWithFormat:@"%@\n%@",_txtView.text,str];
    
    //昨天
    date  = [[NSDate alloc] initWithTimeInterval:((-60*60*24)-6) sinceDate:[NSDate date]];
    str  = [NSString stringWithFormat:@"%@-->%@",[date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"], [date stringWithHumanReadEasy]];
    _txtView.text = [NSString stringWithFormat:@"%@\n%@",_txtView.text,str];
    
    //具体时间
    date  = [[NSDate alloc] initWithTimeInterval:-2*60*60*24 sinceDate:[NSDate date]];
    str  = [NSString stringWithFormat:@"%@-->%@",[date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"], [date stringWithHumanReadEasy]];
    _txtView.text = [NSString stringWithFormat:@"%@\n%@",_txtView.text,str];
    
    
    NSDate *tomorrowDate  = [NSDate dateByAddingDay:1 toDate:[NSDate date]];
    
    NSDate *yestodayDate  = [NSDate dateByAddingDay:-1 toDate:[NSDate date]];
    
    NSDate *date1 = [NSDate date];
    
   
    
    
    NSLog(@"%@",date1);
    
    NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
    NSDate *dateInLocalTimezone = [date1 dateByAddingTimeInterval:timeZoneSeconds];
    
     NSLog(@"%@",dateInLocalTimezone);
    
     NSDate *date2  = [NSDate dateByAddingDay:0 toDate:[NSDate date]];
     NSLog(@"%@",date2);

    
    NSLog(@"是否是明天%@,%d",tomorrowDate,[tomorrowDate isTomorrow]);
    NSLog(@"是否是昨天%@,%d",yestodayDate,[yestodayDate isYesterday]);
    NSLog(@"是否是今天%@,%d",[NSDate date],[[NSDate date] isToday]);
    
    //微信时间测试
    for (int i = 0; i < 10; i++)
    {
        NSDate *date  = [NSDate dateByAddingDay:-1*i toDate:[NSDate date]];
        

        NSLog(@"--- %@",[NSDate getWeChatFormatDateStringBySourceDate:date]);
    }
    
    
}

@end
