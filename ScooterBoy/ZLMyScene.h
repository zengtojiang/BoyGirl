//
//  ZLMyScene.h
//  ScooterBoy
//

//  Copyright (c) 2014年 icow. All rights reserved.
//

#ifndef TEST_STOREKIT

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(int, ZLRESULTTYPE) {
    ZLRESULTTYPEBOY=0,
    ZLRESULTTYPEGIRL=1,
};

@interface ZLMyScene : SKScene
{
    SKSpriteNode  *_playerNode;
    
    BOOL          bRunning;
    ZLRESULTTYPE  guessType;
    
    SKSpriteNode   *_boyNode;
    SKSpriteNode   *_girlNode;
    
    SKLabelNode *_startLabel;
    //成就
    NSUInteger         _curWinTimes;//当前胜利次数
    NSUInteger         _recordWinTimes;//记录胜利次数
    SKLabelNode     *_curWinLabel;
    SKLabelNode     *_recordWinLabel;
    SKLabelNode     *_curScoreLabel;//当前积分数
    
    //音效加载
    SKAction        *_playWinAudio;//成功声音
    SKAction        *_playTapAudio;//点击控件声音
    SKAction        *_playLoseAudio;//失败声音
    SKAction        *_playRunningAudio;//
    SKAction        *_playRunEndAudio;
}

-(BOOL)startRunningWithGuessType:(ZLRESULTTYPE)type;


-(void)playTapSound;
@end

#endif