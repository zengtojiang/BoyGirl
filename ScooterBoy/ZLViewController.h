//
//  ZLViewController.h
//  ScooterBoy
//

//  Copyright (c) 2014年 icow. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifndef TEST_STOREKIT
#import <SpriteKit/SpriteKit.h>
#import "ZLMyScene.h"
#endif
#import "ZLAlertView.h"
#import <GameKit/GameKit.h>
#import <iAd/iAd.h>
#ifndef TEST_STOREKIT
#import "ZLBannerView.h"

@interface ZLViewController : UIViewController<ZLAlertViewDelegate,GKGameCenterControllerDelegate,ADBannerViewDelegate>
#else
@interface ZLViewController : UIViewController<ZLAlertViewDelegate,ADBannerViewDelegate>
#endif
{
    BOOL   bShowAlertView;
    UIButton   *btnGameCenter;
    UIButton   *btnBoy;//男孩
    UIButton   *btnGirl;//女孩
    
    ADBannerView *adView;
    
    ZLBannerView    *zlBannerView;
}
@end
