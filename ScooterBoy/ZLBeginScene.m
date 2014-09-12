//
//  ZLBeginScene.m
//  BoyOrGirl
//
//  Created by libs on 14-4-24.
//  Copyright (c) 2014年 icow. All rights reserved.
//

#import "ZLBeginScene.h"
#import "ZLHistoryManager.h"
#import "SKSharedAtles.h"

@implementation ZLBeginScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        [self initPhysicsWorld];
        [self initBackground];
        [self initButtons];
        
        [self initScoreLabel];
        
        _playTapAudio=[SKAction playSoundFileNamed:@"button.mp3" waitForCompletion:NO];
    }
    return self;
}

-(void)initBackground
{
    //self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
    SKSpriteNode *spriteBG = [SKSpriteNode spriteNodeWithTexture:[SKSharedAtles textureWithType:SKTextureTypeBackground]];//iPhone5?@"Default-568h.png":@"Default.png"
    spriteBG.zPosition=0;
    spriteBG.anchorPoint=CGPointMake(0, 0);
    spriteBG.position = CGPointZero;//CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    
    [self addChild:spriteBG];
}

-(void)initButtons
{
    _startNode=[SKSpriteNode spriteNodeWithTexture:[SKSharedAtles textureWithType:SKTextureTypeButton]];
    _startNode.zPosition=0;
    _startNode.anchorPoint=CGPointMake(0.5, 0.5);
    _startNode.position=CGPointMake(self.size.width/3-20, ZL_START_BUTTON_Y_POSITION);
    _startNode.size=CGSizeMake(self.size.width/3, 40);
    [self addChild:_startNode];
    
    SKLabelNode *startLabel=[SKLabelNode labelNodeWithFontNamed:ZL_DEFAULT_FONT_NAME];
    startLabel.fontColor=ZL_HEADVIEW_TEXTCOLOR;
    startLabel.position=CGPointMake(0,0);
    startLabel.horizontalAlignmentMode=SKLabelHorizontalAlignmentModeCenter;
    startLabel.verticalAlignmentMode=SKLabelVerticalAlignmentModeCenter;
    startLabel.fontSize=ZL_MIDDLE_FONT_SIZE;
    [_startNode addChild:startLabel];
    startLabel.text=@"START";
    
    _leaderboardNode=[SKSpriteNode spriteNodeWithTexture:[SKSharedAtles textureWithType:SKTextureTypeButton]];
    _leaderboardNode.zPosition=0;
    _leaderboardNode.anchorPoint=CGPointMake(0.5, 0.5);
    _leaderboardNode.position=CGPointMake(self.size.width/3*2+20, ZL_START_BUTTON_Y_POSITION);
    _leaderboardNode.size=CGSizeMake(self.size.width/3, 40);
    [self addChild:_leaderboardNode];
    
    SKSpriteNode* leaderNode=[SKSpriteNode spriteNodeWithTexture:[SKSharedAtles textureWithType:SKTextureTypeLeaderboard]];
    //leaderNode.zPosition=0;
    leaderNode.anchorPoint=CGPointMake(0.5, 0.5);
    leaderNode.position=CGPointMake(0, 0);
    leaderNode.size=CGSizeMake(leaderNode.size.width*0.8, leaderNode.size.height*0.8);
    [_leaderboardNode addChild:leaderNode];
    /*
    SKLabelNode *leadLabel=[SKLabelNode labelNodeWithFontNamed:ZL_DEFAULT_FONT_NAME];
    leadLabel.fontColor=ZL_HEADVIEW_TEXTCOLOR;
    leadLabel.position=CGPointMake(0,0);
    leadLabel.horizontalAlignmentMode=SKLabelHorizontalAlignmentModeCenter;
    leadLabel.verticalAlignmentMode=SKLabelVerticalAlignmentModeCenter;
    leadLabel.fontSize=ZL_MIDDLE_FONT_SIZE;
    [_leaderboardNode addChild:leadLabel];
    leadLabel.text=@"LEADERBOARD";
     */
}

-(void)initScoreLabel
{
    float bgWidth=220;
    SKSpriteNode *resultBG=[SKSpriteNode spriteNodeWithTexture:[SKSharedAtles textureWithType:SKTextureTypeResultBG]];
    resultBG.zPosition=0;
    resultBG.anchorPoint=CGPointMake(0.5, 0.5);
    resultBG.position=CGPointMake(CGRectGetMidX(self.frame), ZL_RESULT_VIEW_Y_POSITION);
    resultBG.size=CGSizeMake(bgWidth, 100);
    [self addChild:resultBG];
    
    _levelNode=[SKLabelNode labelNodeWithFontNamed:ZL_DEFAULT_FONT_NAME];
    _levelNode.fontColor=HEXCOLOR(0x30a9b3);//ZL_HEADVIEW_TEXTCOLOR;
    _levelNode.position=CGPointMake(0, 20);
    _levelNode.horizontalAlignmentMode=SKLabelHorizontalAlignmentModeCenter;
    _levelNode.verticalAlignmentMode=SKLabelVerticalAlignmentModeCenter;
    _levelNode.fontSize=ZL_BIG_FONT_SIZE;
    [resultBG addChild:_levelNode];
    _levelNode.text=[NSString stringWithFormat:@"Level: %lu",(unsigned long)[ZLHistoryManager getLastWinTimes]];
    
    _scoreNode=[SKLabelNode labelNodeWithFontNamed:ZL_DEFAULT_FONT_NAME];
    _scoreNode.fontColor=HEXCOLOR(0x30a9b3);//ZL_HEADVIEW_TEXTCOLOR;
    _scoreNode.position=CGPointMake(0,-20);
    _scoreNode.horizontalAlignmentMode=SKLabelHorizontalAlignmentModeCenter;
    _scoreNode.verticalAlignmentMode=SKLabelVerticalAlignmentModeCenter;
    _scoreNode.fontSize=ZL_BIG_FONT_SIZE;
    [resultBG addChild:_scoreNode];
    _scoreNode.text=[NSString stringWithFormat:@"Score: %lu",(unsigned long)[ZLHistoryManager getLastScore]];
}

-(void)initPhysicsWorld
{
    self.physicsWorld.gravity=CGVectorMake(0, 0);
    //self.physicsWorld.contactDelegate=self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
     for (UITouch *touch in touches) {
     CGPoint location = [touch locationInNode:self];
     if(CGRectContainsPoint(_startNode.frame, location)){
         [self runAction:_playTapAudio];
         [[NSNotificationCenter defaultCenter] postNotificationName:ZL_TAP_BUTTON_NOTIFICATION object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"button",nil]];
     }else if(CGRectContainsPoint(_leaderboardNode.frame, location)){
         [self runAction:_playTapAudio];
         [[NSNotificationCenter defaultCenter] postNotificationName:ZL_TAP_BUTTON_NOTIFICATION object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1],@"button",nil]];
     }
     }
}
@end
