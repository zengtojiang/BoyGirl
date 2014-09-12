//
//  ZLBeginScene.h
//  BoyOrGirl
//
//  Created by libs on 14-4-24.
//  Copyright (c) 2014年 icow. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "HSStretchableButton.h"

@interface ZLBeginScene : SKScene
{
    SKSpriteNode *_startNode;
    SKSpriteNode *_leaderboardNode;
    SKLabelNode  *_levelNode;
    SKLabelNode  *_scoreNode;
    
    SKAction        *_playTapAudio;//点击控件声音
}
@end
