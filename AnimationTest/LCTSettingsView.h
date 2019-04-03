//
//  LCTSettingsView.h
//  AnimationTest
//
//  Created by Алексей Апестин on 01.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface LCTSettingsView : UIView

@property(nonatomic, weak) ViewController *viewController;

+ (LCTSettingsView *)createSettingsView;

@end
