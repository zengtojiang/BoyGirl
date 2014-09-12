//
//  ZLBannerView.h
//  BoyOrGirl
//
//  Created by libs on 14-5-22.
//  Copyright (c) 2014年 icow. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, ZLBANNERTEXTCOLOR) {
    ZL_BANNER_COLOR_BLACK=1,
    ZL_BANNER_COLOR_WHITE=2
};

@interface ZLBannerView : UIView

-(void)setTextColor:(ZLBANNERTEXTCOLOR)textColor;

@end
