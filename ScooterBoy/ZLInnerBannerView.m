//
//  ZLInnerBannerView.m
//  BoyOrGirl
//
//  Created by libs on 14-5-22.
//  Copyright (c) 2014年 icow. All rights reserved.
//

#import "ZLInnerBannerView.h"


#define  ZL_BANNER_SCROLL_SPEED   60
@implementation ZLInnerBannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        mContentView=[[UIScrollView alloc] initWithFrame:self.bounds];
        mContentView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:mContentView];
        mContentView.scrollEnabled=NO;
        mContentView.showsHorizontalScrollIndicator=NO;
        mContentView.showsVerticalScrollIndicator=NO;
        mContentLabel=[[UILabel alloc] initWithFrame:self.bounds];
        //mContentLabel.backgroundColor=[UIColor grayColor];
        mContentLabel.textColor=[UIColor whiteColor];
        mContentLabel.text=@"An empty implementation adversely affects performance during animation.";
        [mContentView addSubview:mContentLabel];
        
        CGRect textRect= [mContentLabel textRectForBounds:CGRectMake(0, 0, 10000, self.bounds.size.height) limitedToNumberOfLines:1];
        mContentLabel.frame=CGRectMake(0, 0, textRect.size.width, self.bounds.size.height);
        mContentView.contentSize=CGSizeMake(textRect.size.width, self.bounds.size.height);
        
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapOnBanner:)];
        tapGesture.delegate=self;
        tapGesture.numberOfTapsRequired=1;
        [self addGestureRecognizer:tapGesture];
        
        [self onAdLoaded];
    }
    return self;
}

-(void)setTextColor:(UIColor *)textColor
{
    mContentLabel.textColor=textColor;
}

-(void)onAdLoaded
{
    [self performSelector:@selector(scrollAnimation) withObject:nil afterDelay:2];
}

//滚动动画
-(void)scrollAnimation
{
    float textWidth=mContentLabel.frame.size.width+mContentLabel.frame.origin.x;
    float interval=textWidth/ZL_BANNER_SCROLL_SPEED;
    [UIView animateWithDuration:interval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect lblRect=mContentLabel.frame;
        lblRect.origin.x= -mContentLabel.frame.size.width;
        mContentLabel.frame=lblRect;
    } completion:^(BOOL finished){
        [self onScrollFinished];
    }];
}

-(void)onScrollFinished
{
    CGRect lblRect=mContentLabel.frame;
    lblRect.origin.x= self.frame.size.width;
    mContentLabel.frame=lblRect;
    [self scrollAnimation];
}

-(void)onTapOnBanner:(UIGestureRecognizer*)gestureRecognizer
{
    if (gestureRecognizer.state==UIGestureRecognizerStateEnded) {
        if (self.bannerDelegate) {
            [self.bannerDelegate onTapBannerView];
        }
    }
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
