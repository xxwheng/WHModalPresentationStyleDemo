//
//  UIViewController+VCModalType.m
//  Demo
//
//  Created by 恒  王 on 2021/2/3.
//  Copyright © 2021 whbalzac. All rights reserved.
//

#import "WHCustomDismissAnimation.h"
#import "WHCustomPresentedAnimation.h"
#import "WHCustomPercentDrivenInteractiveTransition.h"
#import "UIViewController+WHModalPresentationStyle.h"
#import <objc/runtime.h>

static char *_modalTypeKey = "WH_MODAL_TYPE_KEY";

static char *_transitionKey = "WH_TRANSITION_KEY";

@interface UIViewController (WHModalPresentationStyle) <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong)WHCustomPercentDrivenInteractiveTransition *whTransition;

@end

@implementation UIViewController (WHModalPresentationStyle)

+ (void)load {
    [super load];
    Method fromMethod = class_getInstanceMethod([self class], @selector(presentViewController:animated:completion:));
    Method toMethod = class_getInstanceMethod([self class], @selector(swizzlingPresentViewController:animated:completion:));
    if (!class_addMethod([self class], @selector(presentViewController:animated:completion:), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

- (void)swizzlingPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    NSLog(@"********");
    NSLog(@"******** %ld", (long)self.modalType);
    if (self.modalType != kModalTypePresent) {
        NSLog(@"32324");
        viewControllerToPresent.transitioningDelegate = self;
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationCustom;
        self.whTransition = [[WHCustomPercentDrivenInteractiveTransition alloc] initWithVc:viewControllerToPresent type:self.modalType];
    }
    [self swizzlingPresentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return (self.whTransition.isInteracting ? self.whTransition : nil);
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    switch (self.modalType) {
        case kModalTypePush:
            return [[WHCustomDismissAnimation alloc] initWithType:kModalTypePush];
        case kModalTypeZoom:
            return [[WHCustomDismissAnimation alloc] initWithType:kModalTypeZoom];
        default:
            return nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    switch (self.modalType) {
        case kModalTypePush:
            return [[WHCustomPresentedAnimation alloc] initWithType:kModalTypePush];
        case kModalTypeZoom:
            return [[WHCustomPresentedAnimation alloc] initWithType:kModalTypeZoom];
        default:
            return nil;
    }
}

- (void)setWhTransition:(WHCustomPercentDrivenInteractiveTransition *)whTransition {
    objc_setAssociatedObject(self, _transitionKey, whTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WHCustomPercentDrivenInteractiveTransition *)whTransition {
    return objc_getAssociatedObject(self, _transitionKey);
}

- (void)setModalType:(kWHCustomAnimationType)modalType {
    NSString *typeValue = @"-1";
    switch (modalType) {
        case kModalTypePresent:
            typeValue = @"0";
            break;
        case kModalTypePush:
            typeValue = @"1";
            break;
        case kModalTypeZoom:
            typeValue = @"2";
            break;
    }
    objc_setAssociatedObject(self, _modalTypeKey, typeValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (kWHCustomAnimationType)modalType {
    NSString *value = objc_getAssociatedObject(self, _modalTypeKey);
    switch (value.intValue) {
        case 0:
            return kModalTypePresent;
        case 1:
            return kModalTypePush;
        case 2:
            return kModalTypeZoom;
        default:
            return kModalTypePresent;
    }
}

@end
