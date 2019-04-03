//
//  LCTRacketPlayer.m
//  AnimationTest
//
//  Created by Алексей Апестин on 27.03.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "LCTRacketPlayer.h"

@interface LCTRacketPlayer()

@end

@implementation LCTRacketPlayer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor brownColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.frame.size.width / 10;
        self.textAlignment = NSTextAlignmentCenter;
        self.text = @"Player";
        self.textColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)even
{
    [self racketMove:touches];
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self racketMove:touches];
}


- (void)racketMove:(NSSet<UITouch *> *)touches
{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    if (self.frame.origin.x + point.x - self.frame.size.width / 2 < 0)
    {
        point.x = self.frame.size.width / 2;
    }
    else if (self.frame.origin.x + point.x + self.frame.size.width / 2 > self.superview.frame.size.width)
    {
        point.x =  self.superview.frame.size.width - self.frame.size.width / 2;
    }
    else
    {
        point.x = self.frame.origin.x + point.x;
    }
    self.center = CGPointMake(point.x, self.center.y);
}
@end
