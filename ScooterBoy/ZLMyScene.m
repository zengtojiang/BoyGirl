//
//  ZLMyScene.m
//  ScooterBoy
//
//  Created by libs on 14-3-15.
//  Copyright (c) 2014年 icow. All rights reserved.
//

#ifndef TEST_STOREKIT

#import "ZLMyScene.h"
#import "ZLHistoryManager.h"
#import <GameKit/GameKit.h>
#import "ZLAppDelegate.h"
#import "SKSharedAtles.h"

#define BOY_SELECTED_TEXTURE   [SKTexture textureWithImageNamed:@"boy.png"]
#define GIRL_SELECTED_TEXTURE   [SKTexture textureWithImageNamed:@"girl.png"]

@implementation ZLMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        [self initPhysicsWorld];
        [self initBackground];
        [self initBoyGirlNodes];
        [self initAudioAction];
        [self initPlayerNode];
        [self initScoreLabels];
        [self initStartLabel];
    }
    return self;
}

-(void)initPhysicsWorld
{
    self.physicsWorld.gravity=CGVectorMake(0, 0);
    //self.physicsWorld.contactDelegate=self;
}


- (void)initStartLabel
{
    _startLabel = [SKLabelNode labelNodeWithFontNamed:ZL_DEFAULT_FONT_NAME];
    _startLabel.text = @"Select The Boy Or Girl";
    _startLabel.name=@"startLabel";
    _startLabel.zPosition = 4;
    _startLabel.fontSize=20;
    _startLabel.fontColor = ZL_HEADVIEW_TEXTCOLOR;//HEXCOLOR(0x362e2b);///HEXCOLOR(0xe6b003);//HEXCOLOR(0x552d19);//[SKColor brownColor];
    _startLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    _startLabel.position = CGPointMake(CGRectGetMidX(self.frame),100);
    [self addChild:_startLabel];
    [_startLabel runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction fadeOutWithDuration:1],[SKAction waitForDuration:0.1],[SKAction fadeInWithDuration:1.5],[SKAction waitForDuration:0.1]]]]];
}

- (void)initScoreLabels{
    _curWinLabel=0;
    _recordWinTimes=[ZLHistoryManager getHistoryWinTimes];
    float leftMargin=30;
    float topMargin=self.size.height-60;
    _curWinLabel = [SKLabelNode labelNodeWithFontNamed:ZL_DEFAULT_FONT_NAME];
    _curWinLabel.zPosition = 4;
    _curWinLabel.fontSize=ZL_BIG_FONT_SIZE;
    _curWinLabel.fontColor = ZL_HEADVIEW_TEXTCOLOR;//HEXCOLOR(0xe6b003);//[SKColor whiteColor];
    _curWinLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    _curWinLabel.position = CGPointMake(leftMargin ,topMargin);
    [self addChild:_curWinLabel];
    
    _recordWinLabel = [SKLabelNode labelNodeWithFontNamed:ZL_DEFAULT_FONT_NAME];//@"Chalkduster"
    _recordWinLabel.zPosition = 4;
    _recordWinLabel.fontColor = ZL_HEADVIEW_TEXTCOLOR;//HEXCOLOR(0xe6b003);//[SKColor whiteColor];
    _recordWinLabel.fontSize=ZL_BIG_FONT_SIZE;
    _recordWinLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    _recordWinLabel.position = CGPointMake(CGRectGetMidX(self.frame)+30 , topMargin);
    [self addChild:_recordWinLabel];
    
    _curScoreLabel = [SKLabelNode labelNodeWithFontNamed:ZL_DEFAULT_FONT_NAME];//@"Chalkduster"
    _curScoreLabel.zPosition = 4;
    _curScoreLabel.fontColor = ZL_HEADVIEW_TEXTCOLOR;//HEXCOLOR(0xe6b003);//[SKColor whiteColor];
    _curScoreLabel.fontSize=ZL_BIG_FONT_SIZE+4;
    _curScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    _curScoreLabel.position = CGPointMake(CGRectGetMidX(self.frame) , ZL_RESULT_VIEW_Y_POSITION-70);
    [self addChild:_curScoreLabel];
    
    [self setCurrentWinTimeLabel];
    [self setHistoryWinTimeLabel];
    [self setCurrentScoreLabel];
    
    /*
     _goldsLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
     _goldsLabel.text = [NSString stringWithFormat:@"Coins:%d",_curGolds];
     _goldsLabel.zPosition = 4;
     _goldsLabel.fontSize=14;
     _goldsLabel.fontColor = HEXCOLOR(0x362e2b);//HEXCOLOR(0xe6b003);//[SKColor whiteColor];
     _goldsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
     _goldsLabel.position = CGPointMake(15 , self.size.height - 45);
     [self addChild:_goldsLabel];
     */
}

-(void)initPlayerNode
{
    _playerNode=[SKSpriteNode spriteNodeWithTexture:BOY_SELECTED_TEXTURE];
    _playerNode.zPosition=0;
    _playerNode.anchorPoint=CGPointMake(0.5, 0.5);
    _playerNode.position=CGPointMake(CGRectGetMidX(self.frame), ZL_RESULT_VIEW_Y_POSITION);
    [self addChild:_playerNode];
    [self startPlayerAction:YES];
}

-(void)startPlayerAction:(BOOL)initial
{
    [_playerNode removeActionForKey:@"runaction"];
    if (![_playerNode actionForKey:@"runaction"]) {
        SKAction *runningAction=[SKAction repeatActionForever:[SKAction animateWithTextures:[NSArray arrayWithObjects:BOY_SELECTED_TEXTURE,GIRL_SELECTED_TEXTURE, nil] timePerFrame:initial?0.5:0.1]];
        [_playerNode runAction:runningAction withKey:@"runaction"];
    }
}

-(void)resetPlayerTexture:(ZLRESULTTYPE)resultType
{
    ZLTRACE(@"resultType:%d",resultType);
    [_playerNode runAction:[SKAction setTexture:(resultType==ZLRESULTTYPEBOY)?BOY_SELECTED_TEXTURE:GIRL_SELECTED_TEXTURE]];
}

/*
-(void)startPlayerActionWithTimes:(int)times
{
    if (![_playerNode actionForKey:@"runaction"]) {
        SKAction *runningAction=[SKAction repeatAction:[SKAction animateWithTextures:[NSArray arrayWithObjects:[SKTexture textureWithImageNamed:BOY_SELECTED_TEXTURE_NAME],[SKTexture textureWithImageNamed:GIRL_SELECTED_TEXTURE_NAME], nil] timePerFrame:0.1] count:times];
        [_playerNode runAction:runningAction withKey:@"runaction"];
    }
}
 */

-(void)initBoyGirlNodes
{
    _boyNode=[SKSpriteNode spriteNodeWithTexture:[SKSharedAtles textureWithType:SKTextureTypeBoyNormal]];
    _boyNode.zPosition=0;
    _boyNode.anchorPoint=CGPointMake(0.5, 0.5);
    _boyNode.position=CGPointMake(self.size.width/3, ZL_START_BUTTON_Y_POSITION+30);
    [self addChild:_boyNode];
    
    _girlNode=[SKSpriteNode spriteNodeWithTexture:[SKSharedAtles textureWithType:SKTextureTypeGirlNormal]];
    _girlNode.zPosition=0;
    _girlNode.anchorPoint=CGPointMake(0.5, 0.5);
    _girlNode.position=CGPointMake(self.size.width/3*2, ZL_START_BUTTON_Y_POSITION+30);
    [self addChild:_girlNode];
    
    [self restartBoyGirlAction];
}

-(void)restartBoyGirlAction
{
    [_boyNode runAction:[SKAction setTexture:[SKSharedAtles textureWithType:SKTextureTypeBoyNormal]]];
    [_girlNode runAction:[SKAction setTexture:[SKSharedAtles textureWithType:SKTextureTypeGirlNormal]]];
    [_boyNode runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction scaleTo:0.8 duration:0.3],[SKAction scaleTo:1.0 duration:0.3]]]] withKey:@"flappy"];
    [_girlNode runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction scaleTo:0.8 duration:0.3],[SKAction scaleTo:1.0 duration:0.3]]]] withKey:@"flappy"];
}

-(void)setBoyNodeSelected
{
    [_boyNode removeActionForKey:@"flappy"];
    [_girlNode removeActionForKey:@"flappy"];
    [_boyNode runAction:[SKAction setTexture:[SKSharedAtles textureWithType:SKTextureTypeBoySelected]]];
}

-(void)setGirlNodeSelected
{
    [_boyNode removeActionForKey:@"flappy"];
    [_girlNode removeActionForKey:@"flappy"];
    [_girlNode runAction:[SKAction setTexture:[SKSharedAtles textureWithType:SKTextureTypeGirlSelected]]];
}

-(void)setCurrentWinTimeLabel
{
    _curWinLabel.text = [NSString stringWithFormat:@"%@:%lu",NSLocalizedString(@"Level", nil),(unsigned long)_curWinTimes];
}

-(void)setHistoryWinTimeLabel
{
    _recordWinLabel.text = [NSString stringWithFormat:@"%@:%lu",NSLocalizedString(@"Record", nil),(unsigned long)_recordWinTimes];
}

-(NSUInteger)generateScore
{
    return powf(2, _curWinTimes);
}

-(void)setCurrentScoreLabel
{
    _curScoreLabel.text = [NSString stringWithFormat:@"%@:%lu",NSLocalizedString(@"Score", nil),(unsigned long)[self generateScore]];
}

-(void)setGuessType:(ZLRESULTTYPE)type
{
    guessType=type;
    if (type==ZLRESULTTYPEBOY) {
        [self setBoyNodeSelected];
    }else{
        [self setGirlNodeSelected];
    }
}

-(void)showWinPrompt:(BOOL)win
{
    SKLabelNode *goldAnimation = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Bold"];//ChalkboardSE-Bold
    goldAnimation.text = [NSString stringWithFormat:win?@"YOU WIN":@"YOU LOSE"];
    goldAnimation.zPosition = 4;
    goldAnimation.fontSize=40;
    goldAnimation.fontColor = win?ZL_HEADVIEW_TEXTCOLOR:[SKColor whiteColor];//HEXCOLOR(0xe6b003)
    goldAnimation.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    goldAnimation.position = CGPointMake(self.size.width/2 , 120);
    [self addChild:goldAnimation];
    [goldAnimation runAction:[SKAction sequence:@[[SKAction moveToY:300 duration:1],[SKAction fadeOutWithDuration:0.2],[SKAction removeFromParent]]] completion:^{
        //[goldAnimation removeFromParent];
    }];
}

-(BOOL)startRunningWithGuessType:(ZLRESULTTYPE)type;
{
    if (bRunning) {
        return NO;
    }
    [_startLabel removeAllActions];
    [_startLabel removeFromParent];
    _startLabel=nil;
    bRunning=YES;
    [self setGuessType:type];
   // int rotateTimes=arc4random()%40+20;
    ZLRESULTTYPE resultType=(arc4random()%2);
    BOOL bWin=(guessType==resultType);
    /*
    [self runAction:_playRunningAudio withKey:@"runningaudio"];
    [self runAction:[SKAction sequence:@[[SKAction runBlock:^{
        [self startPlayerActionWithTimes:rotateTimes];
    }],[SKAction runBlock:^{
        [self removeActionForKey:@"runningaudio"];
        [self runAction:bWin?_playWinAudio:_playLoseAudio];
        [self showWinPrompt:bWin];
    }]]] completion:^{
        [self restartBoyGirlAction];
        if (bWin) {
            _curWinTimes++;
            [self setCurrentWinTimeLabel];
            [self setCurrentScoreLabel];
            [self initStartLabel];
            if (_curWinTimes>_recordWinTimes) {
                _recordWinTimes=_curWinTimes;
                [self setHistoryWinTimeLabel];
            }
        }else{
            [self onGameLose];
        }
        bRunning=NO;
    }];
    */
    [self startPlayerAction:NO];
    [self runAction:[SKAction sequence:@[_playRunningAudio,[SKAction runBlock:^{
        //[self runAction:_playRunEndAudio];
        [_playerNode removeActionForKey:@"runaction"];
        [self resetPlayerTexture:resultType];
    }],[SKAction group:@[bWin?_playWinAudio:_playLoseAudio,[SKAction runBlock:^{
        //[self runAction:bWin?_playWinAudio:_playLoseAudio];
        [self showWinPrompt:bWin];
    }]]]]] completion:^{
        [self restartBoyGirlAction];
        if (bWin) {
            _curWinTimes++;
            [self setCurrentWinTimeLabel];
            [self setCurrentScoreLabel];
            [self initStartLabel];
            [self startPlayerAction:YES];
            if (_curWinTimes>_recordWinTimes) {
                _recordWinTimes=_curWinTimes;
                [self setHistoryWinTimeLabel];
            }
        }else{
            [self onGameLose];
        }
        bRunning=NO;
    }];
    /*
    [self runAction:[SKAction sequence:@[_playRunningAudio,_playRunEndAudio,]] completion:^{
        [_playerNode removeActionForKey:@"runaction"];
        [self restartBoyGirlAction];
        int resultType=arc4random()%2;
        if (resultType==guessType) {
            //猜对了
            [self runAction:_playWinAudio];
            _curWinTimes++;
            [self setCurrentWinTimeLabel];
            [self setCurrentScoreLabel];
            if (_curWinTimes>_recordWinTimes) {
                _recordWinTimes=_curWinTimes;
                [self setHistoryWinTimeLabel];
            }
        }else{
            //猜错了
            [self onGameLose];
        }
        bRunning=NO;
    }];
     */
    return YES;
}

-(void)playTapSound;
{
    [self runAction:_playTapAudio];
}

-(void)onGameLose
{
    [self saveResultRecord];
    [[NSNotificationCenter defaultCenter] postNotificationName:ZL_RUN_OVER_NOTIFICATION object:nil userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:@"r"]];
//    [self runAction:_playLoseAudio completion:^{
//        [[NSNotificationCenter defaultCenter] postNotificationName:ZL_RUN_OVER_NOTIFICATION object:nil userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:@"r"]];
//    }];
    _curWinTimes=0;
}

-(void)saveResultRecord
{
    [ZLHistoryManager setLastWinTimes:_curWinTimes];
    [ZLHistoryManager setLastScore:[self generateScore]];
    if (_curWinTimes>[ZLHistoryManager getHistoryWinTimes]) {
        [ZLHistoryManager setHistoryWinTimes:_curWinTimes];
        [ZLHistoryManager setHistoryScore:[self generateScore]];
    }
    [self addRecordToGameCenter];
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

-(void)initAudioAction
{
    _playWinAudio=[SKAction playSoundFileNamed:@"win1.mp3" waitForCompletion:YES];
    _playTapAudio=[SKAction playSoundFileNamed:@"button.mp3" waitForCompletion:NO];
    _playLoseAudio=[SKAction playSoundFileNamed:@"lose1.mp3" waitForCompletion:YES];
   // _playRunningAudio=[SKAction repeatAction:[SKAction playSoundFileNamed:@"acTime.wav" waitForCompletion:YES] count:3];
    _playRunningAudio=[SKAction playSoundFileNamed:@"wincounter.mp3" waitForCompletion:YES];
    _playRunEndAudio=[SKAction playSoundFileNamed:@"actdone.wav" waitForCompletion:NO];
}

-(void)addRecordToGameCenter
{
    [(ZLAppDelegate *)[UIApplication sharedApplication].delegate saveRecordToGameCenter];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if(CGRectContainsPoint(_boyNode.frame, location)){
            [self startRunningWithGuessType:ZLRESULTTYPEBOY];
        }else if(CGRectContainsPoint(_girlNode.frame, location)){
            [self startRunningWithGuessType:ZLRESULTTYPEGIRL];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end

#endif
