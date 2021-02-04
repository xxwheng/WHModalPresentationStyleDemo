//
//  WHCustomPercentDrivenInteractiveTransition.m
//  swipeDismiss
//
//  Created by whbalzac on 27/02/2018.
//  Copyright © 2018 Zac. All rights reserved.
//

#import "WHCustomPercentDrivenInteractiveTransition.h"

@interface WHCustomPercentDrivenInteractiveTransition ()
@property (nonatomic, assign) kWHCustomAnimationType type;
@end

@implementation WHCustomPercentDrivenInteractiveTransition

- (instancetype)initWithVc:(UIViewController *)vc type:(kWHCustomAnimationType)type
{
    self = [super init];
    if (self) {
        _vc = vc;
        _type = type;
        switch (type) {
            case kModalTypePush: {
                UIScreenEdgePanGestureRecognizer *panGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self                           action:@selector(panGestureHander:)];
                panGesture.edges = UIRectEdgeLeft;
                [vc.view addGestureRecognizer:panGesture];
                break;
            }
            case kModalTypeZoom: {
                UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self               action:@selector(panGestureHander:)];
                [vc.view addGestureRecognizer:panGesture];
                break;
            }
            default:
                break;
        }
    }
    return self;
}

#pragma mark -
#pragma mark - kWHCustomAnimationTypePush
- (void)panGestureHander:(UIScreenEdgePanGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            _isInteracting = YES;
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGFloat fraction;
            switch (self.type) {
                case kModalTypePush: {
                    CGFloat point_x = WHCustomScreenWidth + [gesture locationInView:_vc.view].x;
                    fraction = (point_x / WHCustomScreenWidth);
                    break;
                }
                case kModalTypeZoom: {
                    CGFloat point_y = WHCustomScreenHeight + [gesture locationInView:_vc.view].y;
                    fraction = (point_y / WHCustomScreenHeight);
                    break;
                }
                default:
                    fraction = 0;
                    break;
            }
            fraction = fmin(fmaxf(fraction, 0.0), 1.0);
            _shouldComplete = fraction > 0.5;
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            _isInteracting = NO;
            if (!_shouldComplete || gesture.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            }else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

@end

