//
//  LCTSettingsView.m
//  AnimationTest
//
//  Created by Алексей Апестин on 01.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "LCTSettingsView.h"
#import "ViewController.h"

@interface LCTSettingsView()

@property (nonatomic, strong) UISegmentedControl *segments;
@property (nonatomic, strong) UISwitch *switchView;

@end

@implementation LCTSettingsView

+ (LCTSettingsView *)createSettingsView
{
    LCTSettingsView *settingsView = [[LCTSettingsView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 8,
                                                                                      [UIScreen mainScreen].bounds.size.height / 4,
                                                                                      [UIScreen mainScreen].bounds.size.width * 3 / 4,
                                                                                      [UIScreen mainScreen].bounds.size.height / 2)];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(settingsView.bounds.origin.x + 40,
                                                                  settingsView.bounds.size.height - 60,
                                                                  settingsView.bounds.size.width - 80, 30)];
    [button setTitle:@"Продолжить" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius  = button.frame.size.height / 2;
    [button addTarget:settingsView action:@selector(didTapButton) forControlEvents:UIControlEventTouchUpInside];
    [settingsView addSubview:button];
    
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(settingsView.bounds.size.width / 2 - 25,
                                                                      button.frame.origin.y - 60, 50, 30)];
    [settingsView addSubview:switchView];
    settingsView.switchView = switchView;
    
    UILabel *switchLabel = [[UILabel alloc] initWithFrame:CGRectMake(switchView.frame.origin.x - 40,
                                                                     switchView.frame.origin.y - 40, 130, 30)];
    switchLabel.backgroundColor = [UIColor clearColor];
    switchLabel.textAlignment = NSTextAlignmentCenter;
    switchLabel.text = @"Обнулить счет";
    [settingsView addSubview:switchLabel];
    
    UISegmentedControl *segments = [[UISegmentedControl alloc] initWithItems:@[@"Низкая", @"Средняя", @"Высокая"]];
    segments.frame = CGRectMake(settingsView.bounds.origin.x + 10, switchLabel.frame.origin.y - 60,
                                settingsView.bounds.size.width - 20, 30);
    [settingsView addSubview:segments];
    settingsView.segments = segments;
    
    UILabel *segmentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(segments.frame.origin.x, segments.frame.origin.y - 40,
                                                                       settingsView.bounds.size.width - 20, 30)];
    segmentsLabel.backgroundColor = [UIColor clearColor];
    segmentsLabel.textAlignment = NSTextAlignmentCenter;
    segmentsLabel.text = @"Скорость игры";
    [settingsView addSubview:segmentsLabel];
    
    settingsView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 45,
                                    [UIScreen mainScreen].bounds.size.height / 2 - 5, 10, 10);
    settingsView.alpha = 0.f;
    settingsView.layer.borderColor = [UIColor blackColor].CGColor;
    settingsView.layer.borderWidth = 5.0;
    settingsView.backgroundColor = [UIColor yellowColor];
    
    return settingsView;
}


- (void)didTapButton
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 45, [UIScreen mainScreen].bounds.size.height / 2 - 5,
                                10, 10);
        self.alpha = 0.f;
    } completion: nil];
    NSTimeInterval *speedGaming = 0;
    double interval = 0.005;
    switch (self.segments.selectedSegmentIndex) {
        case 0:
            interval = 0.01;
            break;
        case 1:
            interval = 0.005;
            break;
        case 2:
            interval = 0.002;
            break;
        default:
            interval = 0.005;
            break;
    }
    speedGaming = &interval;
    [self.viewController applySettings: [self.switchView isOn] stepTimer: speedGaming];
}
@end
