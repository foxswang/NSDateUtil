# NSDateUtil

#### 最全面NSDate Utility 没有之一 

####欢迎进群 486468672 一起探讨ios开发，共同学习技术，一起进步。

这个帮助类参考 https://github.com/billymeltdown/nsdate-helper ，并针对中国的场景做了些优化

欢迎star fork 提交新的需求

<br >
##### 常用格式化字符串 满足80% 工作使用场景
<pre><code>
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
</code></pre>

## 使用例子

#####格式化字符串

<pre><code>
//yyyy-MM-dd HH:mm:ss     2015-09-12 19:36:24
[date stringWithFormat:@"yyyy-MM-dd HH:mm:ss"] 
</code></pre>

#####类似新浪微博的 ，刚刚，1分钟前 ，1小时前，1天前，显示

<pre><code>
   [date stringWithHumanReadEasy]
   //输出刚刚，N分钟前，N小时前，昨天 HH:mm, YYYY-MM HH:mm
</code></pre>

#####获取时间的详细信息
<pre><code>
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
</code></pre>

#####对日期的修改，获得新的时间
<pre><code>
//对日期的修改
//增加年
+ (NSDate *)dateByAddingYear:(int)year toDate:(NSDate *)date;
//增加月
+ (NSDate *)dateByAddingMonth:(int)month toDate:(NSDate *)date;
//增加天数
+ (NSDate *)dateByAddingDay:(int)day toDate:(NSDate *)date;
//增加小时
+ (NSDate *)dateByAddingHour:(int)hour toDate:(NSDate *)date;
+ (NSDate *)dateByAddingMinute:(int)minute toDate:(NSDate *)date;
+ (NSDate *)dateByAddingSecond:(int)second toDate:(NSDate *)date;
</code></pre>

#####判断是今天，昨天，明天
<pre><code>
- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isTomorrow;;
</code></pre>


#####对周的一些操作
<pre><code>
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
</code></pre>

## 更多功能,请看代码
