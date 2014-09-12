//
//  ZLInnerBannerView.h
//  BoyOrGirl
//
//  Created by libs on 14-5-22.
//  Copyright (c) 2014年 icow. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLInnerBannerViewDelegate;

@interface ZLInnerBannerView : UIView<UIGestureRecognizerDelegate>
{
    UIScrollView    *mContentView;
    UILabel         *mContentLabel;
}

@property(nonatomic,assign)id<ZLInnerBannerViewDelegate> bannerDelegate;

-(void)setTextColor:(UIColor *)textColor;
@end

@protocol ZLInnerBannerViewDelegate <NSObject>

-(void)onTapBannerView;

@end