//
//  UIViewController+WHPresentModal.h
//  Demo
//
//  Created by 恒  王 on 2021/2/4.
//  Copyright © 2021 whbalzac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHCustomHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (WHModalPresentationStyle)

@property(nonatomic, assign)kWHCustomAnimationType modalType;

@end

NS_ASSUME_NONNULL_END
