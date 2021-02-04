//
//  WHCustomHeader.h
//  swipeDismiss
//
//  Created by whbalzac on 27/02/2018.
//  Copyright © 2018 Zac. All rights reserved.
//

#ifndef WHCustomHeader_h
#define WHCustomHeader_h

#define WHCustomScreenWidth [[UIScreen mainScreen] bounds].size.width
#define WHCustomScreenHeight [[UIScreen mainScreen] bounds].size.height
#define KTrastionDuration 0.35

typedef NS_ENUM(NSInteger, kWHCustomAnimationType) {
    /// 常态 底部弹出 不全屏
    kModalTypePresent = 0,
    /// 类似 push
    kModalTypePush = 1,
    /// 底部弹出 全屏
    kModalTypeZoom = 2
};

#endif /* WHCustomHeader_h */
