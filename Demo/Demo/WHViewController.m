//
//  WHViewController.m
//  Demo
//
//  Created by 恒  王 on 2021/2/4.
//  Copyright © 2021 whbalzac. All rights reserved.
//

#import "WHViewController.h"
#import "UIViewController+WHModalPresentationStyle.h"
#import "NextViewController.h"

@interface WHViewController ()

@end

@implementation WHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(16, 100, 44, 44);
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(presentChirldVC) forControlEvents:UIControlEventTouchUpInside];

    UIButton *button2 = [[UIButton alloc] init];
    button2.frame = CGRectMake(16, 200, 44, 44);
    [self.view addSubview:button2];
    button2.backgroundColor = [UIColor redColor];
    [button2 addTarget:self action:@selector(pushChirldVC) forControlEvents:UIControlEventTouchUpInside];


    UIButton *button3 = [[UIButton alloc] init];
    button3.frame = CGRectMake(16, 300, 44, 44);
    [self.view addSubview:button3];
    button3.backgroundColor = [UIColor redColor];
    [button3 addTarget:self action:@selector(zoomChirldVC) forControlEvents:UIControlEventTouchUpInside];
}

- (void)presentChirldVC {
    NextViewController *vc = [[NextViewController alloc] init];
    [self setModalType:kModalTypePresent];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)pushChirldVC {
    NextViewController *vc = [[NextViewController alloc] init];
    [self setModalType:kModalTypePush];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)zoomChirldVC {
    NextViewController *vc = [[NextViewController alloc] init];
    [self setModalType:kModalTypeZoom];
    [self presentViewController:vc animated:YES completion:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
