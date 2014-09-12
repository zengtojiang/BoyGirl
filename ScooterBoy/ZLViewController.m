//
//  ZLViewController.m
//  ScooterBoy
//
//  Created by libs on 14-3-15.
//  Copyright (c) 2014年 icow. All rights reserved.
//

#import "ZLViewController.h"
#import "ZLHistoryManager.h"
#import "ZLAppDelegate.h"
#import "HSStretchableButton.h"
#import "ZLBeginScene.h"


#define GAMECENTER_ALERTVIEW_TAG   1000

#define  AD_LOADED_FRAME CGRectMake(0, self.view.frame.size.height-adView.frame.size.height, self.view.frame.size.width, adView.frame.size.height)
#define  AD_LOAD_ERROR_FRAME CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, adView.frame.size.height)

@implementation ZLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

#ifndef TEST_STOREKIT
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;//YES;
    skView.showsNodeCount = NO;
    
    ZLBeginScene * scene = [ZLBeginScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
     [self registerNotification];
#else
    self.view.backgroundColor=[UIColor greenColor];
#endif
//    if ([ZLHistoryManager musicOpened]) {
//        [(ZLAppDelegate *)([UIApplication sharedApplication].delegate) startBGAudio];
//    }
    
   /*
    btnGameCenter = [UIButton buttonWithType:UIButtonTypeCustom];
    float buttonWidth=50;
    float buttonMargin=15;
    //[btnGameCenter setFrame:CGRectMake(self.view.frame.size.width-60, 25, image.size.width,image.size.height)];
    [btnGameCenter setFrame:CGRectMake(self.view.frame.size.width-buttonMargin-buttonWidth, buttonMargin, buttonWidth,buttonWidth)];
    [btnGameCenter setImage:[UIImage imageNamed:@"gamecenter.png"] forState:UIControlStateNormal];
    [btnGameCenter addTarget:self action:@selector(onTapGameCenter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnGameCenter];
    */
    //[self initPlayButtons];
    [self setGameCenterAuthontication];
    
    [self loadAdBanner];
    
    float bannerHeight=20;
    //zlBannerView=[[ZLBannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, bannerHeight)];
    
    zlBannerView=[[ZLBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-bannerHeight, self.view.frame.size.width, bannerHeight)];
    [self.view addSubview:zlBannerView];
}

-(void)initPlayButtons
{
    btnBoy = [UIButton buttonWithType:UIButtonTypeCustom];
    float topmargin=300;
    float buttonWith=60;
    //[btnGameCenter setFrame:CGRectMake(self.view.frame.size.width-60, 25, image.size.width,image.size.height)];
    [btnBoy setFrame:CGRectMake(50,topmargin,buttonWith,buttonWith)];
    [btnBoy setImage:[UIImage imageNamed:@"boy.png"] forState:UIControlStateNormal];
    [btnBoy addTarget:self action:@selector(onTapBoyButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBoy];
    
    btnGirl = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnGirl setFrame:CGRectMake(180,topmargin,buttonWith,buttonWith)];
    [btnGirl setImage:[UIImage imageNamed:@"girl.png"] forState:UIControlStateNormal];
    [btnGirl addTarget:self action:@selector(onTapGirlButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnGirl];
}

-(void)onTapBoyButton
{
    [self playTapAudio];
    [self disableButtons];
    [(ZLMyScene *)((SKView *)self.view).scene startRunningWithGuessType:ZLRESULTTYPEBOY];
}

-(void)onTapGirlButton
{
    [self playTapAudio];
    [self disableButtons];
     [(ZLMyScene *)((SKView *)self.view).scene startRunningWithGuessType:ZLRESULTTYPEGIRL];
}

-(void)disableButtons
{
    btnGirl.enabled=NO;
    btnBoy.enabled=NO;
    btnGameCenter.enabled=NO;
}

-(void)reEnableButtons
{
    btnGirl.enabled=YES;
    btnBoy.enabled=YES;
    btnGameCenter.enabled=YES;
}

-(void)playTapAudio
{
    //[(ZLMyScene *)((SKView *)self.view).scene playTapSound];
}

-(void)onStartGame
{
    ZLMyScene * scene = [ZLMyScene sceneWithSize:self.view.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    // Present the scene.
    [(SKView *)self.view presentScene:scene transition:[SKTransition moveInWithDirection:SKTransitionDirectionRight duration:0.5]];
}

#pragma mark - gamekit

-(void)setGameCenterAuthontication
{
    [[GKLocalPlayer localPlayer] setAuthenticateHandler:^(UIViewController *viewcontroll, NSError *error) {
        if (viewcontroll) {
            [self presentViewController:viewcontroll animated:YES completion:^{
                
            }];
        }
    }];
    
}

#ifndef TEST_STOREKIT
-(void)onTapGameCenter
{
    [self playTapAudio];
    bShowAlertView=YES;
    ((SKView *)self.view).paused = YES;
    if ([GKLocalPlayer localPlayer].isAuthenticated) {
        GKGameCenterViewController *gameVC=[[GKGameCenterViewController alloc] init];
        //gameVC.viewState=GKGameCenterViewControllerStateLeaderboards;
        gameVC.viewState=GKGameCenterViewControllerStateDefault;
        gameVC.gameCenterDelegate=self;
        //gameVC.leaderboardIdentifier=ZL_DEFAULT_GAMECENTER_LEADERBOARD_IDENTIFIER;
        [self presentViewController:gameVC animated:YES completion:NULL];
    }else{
        //[self setGameCenterAuthontication];
        ZLAlertView *alertView=[[ZLAlertView alloc] initWithMessage:NSLocalizedString(@"Please login game center first", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) confirmButtonTitles:nil];
        alertView.tag=GAMECENTER_ALERTVIEW_TAG;
        [alertView show];
        
    }
}

-(void)resetGameCenterStatus
{
    bShowAlertView=NO;
    ((SKView *)self.view).paused = NO;
}

#endif

#pragma mark - ad banner

-(void)loadAdBanner
{
    ZLTRACE(@"can display banner ad:%d",[self canDisplayBannerAds]);
    adView=[[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    adView.delegate=self;
    adView.frame=AD_LOAD_ERROR_FRAME;
    [self.view addSubview:adView];
}

- (void)bannerViewWillLoadAd:(ADBannerView *)banner  NS_AVAILABLE_IOS(5_0);
{
    ZLTRACE(@"");
}
/*!
 * @method bannerViewDidLoadAd:
 *
 * @discussion
 * Called each time a banner loads a new ad. Once a banner has loaded an ad, it
 * will display it until another ad is available.
 *
 * It's generally recommended to show the banner view when this method is called,
 * and hide it again when bannerView:didFailToReceiveAdWithError: is called.
 */
- (void)bannerViewDidLoadAd:(ADBannerView *)banner;
{
    ZLTRACE(@"");
    [UIView animateWithDuration:0.3 animations:^{
        adView.frame=AD_LOADED_FRAME;
    }];
}
/*!
 * @method bannerView:didFailToReceiveAdWithError:
 *
 * @discussion
 * Called when an error has occurred while attempting to get ad content. If the
 * banner is being displayed when an error occurs, it should be hidden
 * to prevent display of a banner view with no ad content.
 *
 * @see ADError for a list of possible error codes.
 */
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error;
{
    ZLTRACE(@"error:%@",error);
    [UIView animateWithDuration:0.1 animations:^{
        adView.frame=AD_LOAD_ERROR_FRAME;
    }];
}
/*!
 * @method bannerViewActionShouldBegin:willLeaveApplication:
 *
 * Called when the user taps on the banner and some action is to be taken.
 * Actions either display full screen content modally, or take the user to a
 * different application.
 *
 * The delegate may return NO to block the action from taking place, but this
 * should be avoided if possible because most ads pay significantly more when
 * the action takes place and, over the longer term, repeatedly blocking actions
 * will decrease the ad inventory available to the application.
 *
 * Applications should reduce their own activity while the advertisement's action
 * executes.
 */
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave;
{
    ZLTRACE(@"");
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner;
{
    ZLTRACE(@"");
}

#ifndef TEST_STOREKIT

#pragma mark - @protocol GKGameCenterControllerDelegate <NSObject>

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self playTapAudio];
    [self dismissViewControllerAnimated:YES completion:^{
        [self resetGameCenterStatus];
    }];
}

#endif
#pragma mark - rotation
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
       return UIInterfaceOrientationMaskPortrait;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#ifndef TEST_STOREKIT
-(void)registerNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onRunOverNotification:) name:ZL_RUN_OVER_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onReceiveTapButtonNotification:) name:ZL_TAP_BUTTON_NOTIFICATION object:nil];
}

-(void)onRunOverNotification:(NSNotification *)notification
{
    //[self reEnableButtons];
    NSDictionary *resultDict=[notification userInfo];
    BOOL result=[[resultDict objectForKey:@"r"] boolValue];
    if (!result) {
        ZLBeginScene * scene = [ZLBeginScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        // Present the scene.
        [(SKView *)self.view presentScene:scene transition:[SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:0.5]];
    }
    ZLTRACE(@"result:%d",result);
}

-(void)onReceiveTapButtonNotification:(NSNotification *)notification
{
    NSDictionary *dataDict=[notification userInfo];
    int buttonIndex=[[dataDict objectForKey:@"button"] intValue];
    if (buttonIndex==0) {
        //start
        [self onStartGame];
    }else{
        [self onTapGameCenter];
    }
}

#pragma mark - ZLAlertViewDelegate
- (void)alertView:(ZLAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    bShowAlertView=NO;
    [self playTapAudio];
    if (alertView.tag==GAMECENTER_ALERTVIEW_TAG) {
         [self resetGameCenterStatus];
    }
}

#endif
@end
