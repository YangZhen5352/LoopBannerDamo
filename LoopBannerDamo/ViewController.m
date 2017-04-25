//
//  ViewController.m
//  LoopBannerDamo
//
//  Created by edz on 2017/4/24.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "ViewController.h"
#import "YSLoopBanner.h"
#import "YYLoopBanner_Scroll.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加观察者：监控offset的变化，进行从新计算下标的方式
    YSLoopBanner *loop1 = [[YSLoopBanner alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 260) scrollDuration:3.f];
    [self.view addSubview:loop1];
    loop1.imageURLStrings = @[@"1.jpg", @"2.jpg", @"3.jpg"];
    loop1.selectedColor = [UIColor blueColor];
    loop1.normalColor = [UIColor orangeColor];
    loop1.clickAction = ^(NSInteger index) {
        NSLog(@"curIndex: %ld", index);
    };
    
    // 取消添加观察者
    // 通过系统方法（scrollViewDidScroll）：监控offset的变化，进行从新计算下标的方式
    // 达到精简代码的方式，实现同样的效果
    YYLoopBanner_Scroll *loop = [[YYLoopBanner_Scroll alloc] initWithFrame:CGRectMake(0, 400, ScreenWidth, 260) scrollDuration:3.f];
    [self.view addSubview:loop];
    loop.imageURLStrings = @[@"1.jpg", @"2.jpg", @"3.jpg"];
    loop.selectedColor = [UIColor blueColor];
    loop.normalColor = [UIColor yellowColor];
    loop.clickAction = ^(NSInteger index) {
        NSLog(@"curIndex: %ld", index);
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
