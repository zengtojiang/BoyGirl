//
//  ZLHistoryManager.m
//  ScooterBoy
//
//  Created by libs on 14-3-16.
//  Copyright (c) 2014年 icow. All rights reserved.
//

#import "ZLHistoryManager.h"

@implementation ZLHistoryManager

#pragma mark - 历史积分
+(NSUInteger)getHistoryScore;
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"ZL_HISTORY_SCORE"];
}

+(void)setHistoryScore:(NSUInteger)score;
{
    [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"ZL_HISTORY_SCORE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSUInteger)getLastScore;
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"ZL_LAST_SCORE"];
}

+(void)setLastScore:(NSUInteger)score;
{
    [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"ZL_LAST_SCORE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 连胜次数
+(NSUInteger)getHistoryWinTimes;
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"ZL_HISTORY_WINS"];
}

+(void)setHistoryWinTimes:(NSUInteger)times;
{
    [[NSUserDefaults standardUserDefaults] setInteger:times forKey:@"ZL_HISTORY_WINS"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSUInteger)getLastWinTimes;
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"ZL_LAST_WINS"];
}

+(void)setLastWinTimes:(NSUInteger)times;
{
    [[NSUserDefaults standardUserDefaults] setInteger:times forKey:@"ZL_LAST_WINS"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -

//音效开关是否打开
+(BOOL)voiceOpened
{
    int voiceState=(int)[[NSUserDefaults standardUserDefaults] integerForKey:@"ZL_VOICE_STATE"];
    if (voiceState==2) {
        return NO;
    }
    return YES;
}

//设置音效开关
+(void)setVoiceOpened:(BOOL)open;
{
    [[NSUserDefaults standardUserDefaults] setInteger:open?1:2 forKey:@"ZL_VOICE_STATE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//背景音乐开关是否打开
+(BOOL)musicOpened;
{
    int voiceState=(int)[[NSUserDefaults standardUserDefaults] integerForKey:@"ZL_MUSIC_STATE"];
    if (voiceState==2) {
        return NO;
    }
    return YES;
}

//设置背景音乐开关
+(void)setMusicOpened:(BOOL)open;
{
    [[NSUserDefaults standardUserDefaults] setInteger:open?1:2 forKey:@"ZL_MUSIC_STATE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//是否是第一次进入应用
+(BOOL)isFirstLaunch
{
    BOOL launched=[[NSUserDefaults standardUserDefaults] boolForKey:@"ZL_LAUNCHED"];
    if (!launched) {
        return YES;
    }
    return NO;
}

//设置为不是第一次进入应用
+(void)setFirstLaunch
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ZL_LAUNCHED"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
