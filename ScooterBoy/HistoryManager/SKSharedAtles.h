//
//  SKSharedAtles.h
//  SpriteKit
//
//  Created by Ray on 14-1-20.
//  Copyright (c) 2014年 CpSoft. All rights reserved.
//

#ifndef TEST_STOREKIT
#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(int, SKTextureType) {
    SKTextureTypeBackground = 1,
    SKTextureTypeBoyNormal =2,
    SKTextureTypeBoySelected =3,
    SKTextureTypeGirlNormal =4,
    SKTextureTypeGirlSelected =5,
    SKTextureTypeResultBG=6,
    SKTextureTypeButton=7,
    SKTextureTypeLeaderboard=8,
};

typedef NS_ENUM(int, ZLSTARLEVEL) {
    ZLSTARLEVELOne = 1,
    ZLSTARLEVELTwo = 2,
    ZLSTARLEVELThree = 3,
    ZLSTARLEVELFour =4,
};

@interface SKSharedAtles : SKTextureAtlas

+ (SKTexture *)textureWithType:(SKTextureType)type;

+ (SKAction *)playerAction;

+ (SKAction *)coinRotateAction;

+ (SKTexture *)starTextureWithLevel:(ZLSTARLEVEL)starLevel;

@end
#endif