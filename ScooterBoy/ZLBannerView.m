//
//  ZLBannerView.m
//  BoyOrGirl
//
//  Created by libs on 14-5-22.
//  Copyright (c) 2014年 icow. All rights reserved.
//

#import "ZLBannerView.h"
#import "ZLInnerBannerView.h"

#define ZL_BANNER_COLOR_BLACK__   [UIColor blackColor]
#define ZL_BANNER_COLOR_WHITE__   [UIColor whiteColor]

@interface ZLBannerView()<ZLInnerBannerViewDelegate>{
    ZLBANNERTEXTCOLOR bannerTextColor;
    ZLInnerBannerView *innerBanner;
}

@end

@implementation ZLBannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        bannerTextColor=ZL_BANNER_COLOR_WHITE;
        // Initialization code
        //self.backgroundColor=[UIColor redColor];
        innerBanner=[[ZLInnerBannerView alloc] initWithFrame:self.bounds];
        innerBanner.backgroundColor=[UIColor clearColor];
        [self addSubview:innerBanner];
        innerBanner.bannerDelegate=self;
    }
    return self;
}

-(void)setTextColor:(ZLBANNERTEXTCOLOR)textColor
{
    if (textColor>=1&&textColor<=2) {
        bannerTextColor=textColor;
    }
    [self setBannerTextColor];
}

-(void)resetTextColor
{
    if (bannerTextColor==ZL_BANNER_COLOR_BLACK) {
        bannerTextColor=ZL_BANNER_COLOR_WHITE;
    }else{
        bannerTextColor=ZL_BANNER_COLOR_BLACK;
    }
    [self setBannerTextColor];
}

-(void)setBannerTextColor
{
    if (bannerTextColor==ZL_BANNER_COLOR_BLACK) {
        [innerBanner setTextColor:ZL_BANNER_COLOR_BLACK__];
    }else{
        [innerBanner setTextColor:ZL_BANNER_COLOR_WHITE__];
    }
}

#pragma mark - @protocol ZLInnerBannerViewDelegate <NSObject>

-(void)onTapBannerView
{
    [self resetTextColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
