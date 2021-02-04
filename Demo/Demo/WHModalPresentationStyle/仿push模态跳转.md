## iOS仿push模态跳转



1. 引入头文件

```
#import "UIViewController+WHModalPresentationStyle.h"
```

2. 模态跳转前，赋值跳转方式

```
ViewController *vc = [[ViewController alloc] init];
[self setModalType:kModalTypePush];
[self presentViewController:vc animated:YES completion:nil];
```

3. 返回

```
[self dismissViewControllerAnimated:YES completion:nil];
```



---



#### 跳转方式

```
typedef NS_ENUM(NSInteger, kWHCustomAnimationType) {
    /// 常态 底部弹出 不全屏
    kModalTypePresent = 0,
    /// 类似 push
    kModalTypePush = 1,
    /// 底部弹出 全屏
    kModalTypeZoom = 2
};
```

