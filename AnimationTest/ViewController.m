//
//  ViewController.m
//  AnimationTest
//
//  Created by Алексей Апестин on 26.03.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "ViewController.h"
#import "LCTRacketPlayer.h"
#import "LCTSettingsView.h"

@interface ViewController () <CAAnimationDelegate>

@property(nonatomic, strong) UIView *puck;
@property(nonatomic, strong) LCTRacketPlayer *racketPlayer;
@property(nonatomic, strong) UILabel *racketComputer;
@property(nonatomic, strong) LCTSettingsView *settingsView;
@property(nonatomic, assign) CGFloat motionVectorX;
@property(nonatomic, assign) CGFloat motionVectorY;
@property(nonatomic, assign) NSInteger scorePlayer;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) UILabel *score;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}


- (void)createUI
{
    self.view.backgroundColor = [UIColor orangeColor];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(puckMovement)
                                                userInfo:nil repeats:YES];
    self.motionVectorX = 1;
    self.motionVectorY = 1;
    
    self.score = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2 - 100, 70, 200)];
    self.score.backgroundColor = [UIColor clearColor];
    self.score.textAlignment = NSTextAlignmentCenter;
    self.score.textColor = [UIColor blackColor];
    self.score.numberOfLines = 0;
    self.scorePlayer = 0;
    [self.score setFont:[UIFont fontWithName:@"Arial" size:30]];
    self.score.text = [NSString stringWithFormat:@" %d \n === \n 0 ", self.scorePlayer];
    [self.view addSubview:self.score];
    
    UITapGestureRecognizer *tapOnOverImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    UIImageView *coverImageView = [UIImageView new];
    coverImageView.backgroundColor = [UIColor clearColor];
    coverImageView.userInteractionEnabled = YES;
    coverImageView.frame = CGRectMake(self.view.frame.size.width - 70, self.view.center.y - 30, 60, 60);
    coverImageView.image = [UIImage imageNamed:@"settings"];
    [coverImageView addGestureRecognizer:tapOnOverImage];
    [self.view addSubview: coverImageView];
    
    self.puck = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 35, 35)];
    self.puck.backgroundColor = [UIColor cyanColor];
    self.puck.layer.masksToBounds = YES;
    self.puck.layer.cornerRadius = self.puck.frame.size.width / 2;
    [self.view addSubview:self.puck];
    
    self.settingsView = [LCTSettingsView createSettingsView];
    self.settingsView.viewController = self;
    [self.view addSubview:self.settingsView];
    
    self.racketPlayer = [[LCTRacketPlayer alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50,
                                                                          self.view.frame.size.height - 30, 100, 30)];
    [self.view addSubview:self.racketPlayer];
    
    self.racketComputer = [[UILabel alloc] initWithFrame:CGRectMake(65, 20, 100, 30)];
    self.racketComputer.backgroundColor = [UIColor blackColor];
    self.racketComputer.layer.masksToBounds = YES;
    self.racketComputer.layer.cornerRadius = self.racketPlayer.frame.size.width / 10;
    self.racketComputer.textAlignment = NSTextAlignmentCenter;
    self.racketComputer.text = @"Computer";
    self.racketComputer.textColor = [UIColor whiteColor];
    [self.view addSubview:self.racketComputer];
}


-(void)puckMovement
{
    if (self.puck.frame.origin.y + self.puck.frame.size.height + self.motionVectorY > self.view.frame.size.height - 30
        && (self.puck.center.x < self.racketPlayer.frame.origin.x
            || self.puck.center.x > self.racketPlayer.frame.origin.x + self.racketPlayer.frame.size.width))
    {
        self.scorePlayer += 1;
        self.score.text = [NSString stringWithFormat:@" %d \n === \n 0 ", self.scorePlayer];
    }

    if (self.puck.frame.origin.x + self.puck.frame.size.width + self.motionVectorX > self.view.frame.size.width
        || self.puck.frame.origin.x + self.motionVectorX < 0)
    {
        self.motionVectorX *= -1;
    }
    
    if (self.puck.frame.origin.y + self.puck.frame.size.height + self.motionVectorY > self.view.frame.size.height - 30
        || self.puck.frame.origin.y + self.motionVectorY < 50)
    {
        self.motionVectorY *= -1;
    }
    
    self.puck.center = CGPointMake(self.puck.center.x + self.motionVectorX, self.puck.center.y + self.motionVectorY);
    
    if (self.racketComputer.frame.size.width / 2 < self.puck.center.x
        && self.view.frame.size.width - self.racketComputer.frame.size.width / 2 > self.puck.center.x)
    {
        self.racketComputer.center = CGPointMake(self.puck.center.x, self.racketComputer.center.y);
    }
}


- (void)didTap
{
    [self.timer invalidate];
    self.timer = nil;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.settingsView.frame = CGRectMake(self.view.frame.size.width / 8, self.view.frame.size.height / 4,
                                             self.view.frame.size.width * 3 / 4, self.view.frame.size.height / 2);
        self.settingsView.alpha = 1.f;
        self.settingsView.layer.masksToBounds = YES;
        self.settingsView.layer.cornerRadius  = self.settingsView.frame.size.width / 10;
    } completion: nil];
}


- (void) applySettings: (BOOL) clear stepTimer: (NSTimeInterval*) stepTimer
{
    if (clear) {
        self.scorePlayer = 0;
        self.score.text = [NSString stringWithFormat:@" %d \n === \n 0 ", self.scorePlayer];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:*stepTimer target:self selector:@selector(puckMovement)
                                                userInfo:nil repeats:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
