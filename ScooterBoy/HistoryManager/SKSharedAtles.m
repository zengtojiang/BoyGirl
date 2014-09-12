//
//  SKSharedAtles.m
//  SpriteKit
//
//  Created by Ray on 14-1-20.
//  Copyright (c) 2014年 CpSoft. All rights reserved.
//
#ifndef TEST_STOREKIT
#import "SKSharedAtles.h"

static SKSharedAtles *_shared = nil;

@implementation SKSharedAtles


+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = (SKSharedAtles *)[SKSharedAtles atlasNamed:@"play"];
    });
    return _shared;
}


+ (SKTexture *)textureWithType:(SKTextureType)type{
    
    switch (type) {
        case SKTextureTypeBackground:
        {
            return [[[self class] shared] textureNamed:@"bg-568h.png"];
        }
            break;
        case SKTextureTypeBoyNormal:
            return [[[self class] shared] textureNamed:@"boy2.png"];
            break;
        case SKTextureTypeBoySelected:
            return [[[self class] shared] textureNamed:@"boy1.png"];
            break;
        case SKTextureTypeGirlNormal:
            return [[[self class] shared] textureNamed:@"girl2.png"];
            break;
        case SKTextureTypeGirlSelected:
            return [[[self class] shared] textureNamed:@"girl1.png"];
            break;
        case SKTextureTypeResultBG:
            return [[[self class] shared] textureNamed:@"result2.png"];
            break;
        case SKTextureTypeButton:
            return [[[self class] shared] textureNamed:@"scroll.png"];
            break;
        case SKTextureTypeLeaderboard:
            return [[[self class] shared] textureNamed:@"leader.png"];
            break;
        default:
            break;
    }
    return nil;
}

+ (SKTexture *)starTextureWithLevel:(ZLSTARLEVEL)starLevel;
{
    switch (starLevel) {
        case ZLSTARLEVELOne:
             return [[[self class] shared] textureNamed:@"star1.png"];
            break;
        case ZLSTARLEVELTwo:
            return [[[self class] shared] textureNamed:@"star2.png"];
            break;
        case ZLSTARLEVELThree:
            return [[[self class] shared] textureNamed:@"star3.png"];
            break;
        case ZLSTARLEVELFour:
            return [[[self class] shared] textureNamed:@"star4.png"];
            break;
        default:
            break;
    }
    return nil;
}

+ (SKTexture *)playerTextureWithIndex:(int)index{
    //return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"player1-n%d.png",index]];
    return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"Player%d.png",index]];
}

+ (SKTexture *)coinTextureWithIndex:(int)index{
    //ZLTRACE(@"coinTextName:%@",[NSString stringWithFormat:@"Coins_%02d.png",index]);
    return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"Coins_%02d.png",index]];
}

//+ (SKAction *)playerAction
//{
//    //    NSMutableArray *textures = [[NSMutableArray alloc]init];
//    //
//    //    for (int i= 1; i<=3; i++) {
//    //        SKTexture *texture = [[self class] playerTextureWithIndex:i];
//    //
//    //        [textures addObject:texture];
//    //    }
//    return [SKAction repeatActionForever:[SKAction sequence:@[[SKAction setTexture:[[self class] playerTextureWithIndex:1]],[SKAction waitForDuration:0.2],[SKAction setTexture:[[self class] playerTextureWithIndex:2]],[SKAction waitForDuration:0.1],[SKAction setTexture:[[self class] playerTextureWithIndex:3]],[SKAction waitForDuration:0.1]]]];
//    // return [SKAction repeatActionForever:[SKAction animateWithTextures:textures timePerFrame:0.1]];
//}


+ (SKAction *)playerAction
{
    NSMutableArray *textures = [[NSMutableArray alloc]init];
    
    for (int i= 1; i<=3; i++) {
        SKTexture *texture = [[self class] playerTextureWithIndex:i];
        
        [textures addObject:texture];
    }
    return [SKAction repeatActionForever:[SKAction animateWithTextures:textures timePerFrame:0.1]];
}

+ (SKAction *)coinRotateAction
{
    NSMutableArray *textures = [[NSMutableArray alloc]init];
    
    for (int i= 0; i<=5; i++) {
        SKTexture *texture = [[self class] coinTextureWithIndex:i];
        
        [textures addObject:texture];
    }
    return [SKAction repeatActionForever:[SKAction animateWithTextures:textures timePerFrame:0.1]];
}

@end
#endif