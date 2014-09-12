//
//  ZLHistoryManager.h
//  ScooterBoy
//
//  Created by libs on 14-3-16.
//  Copyright (c) 2014年 icow. All rights reserved.
//
/**
 历史记录保持器
 */
#import <Foundation/Foundation.h>

@interface ZLHistoryManager : NSObject

#pragma mark - 历史积分
+(NSUInteger)getHistoryScore;

+(void)setHistoryScore:(NSUInteger)score;

+(NSUInteger)getLastScore;

+(void)setLastScore:(NSUInteger)score;

#pragma mark - 连胜次数
+(NSUInteger)getHistoryWinTimes;

+(void)setHistoryWinTimes:(NSUInteger)times;

+(NSUInteger)getLastWinTimes;

+(void)setLastWinTimes:(NSUInteger)times;

#pragma mark -

//音效开关是否打开
+(BOOL)voiceOpened;

//设置音效开关
+(void)setVoiceOpened:(BOOL)open;

//背景音乐开关是否打开
+(BOOL)musicOpened;

//设置背景音乐开关
+(void)setMusicOpened:(BOOL)open;

//是否是第一次进入应用
+(BOOL)isFirstLaunch;

//设置为不是第一次进入应用
+(void)setFirstLaunch;
@end
