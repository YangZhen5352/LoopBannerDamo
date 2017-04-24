//
//  ViewController.m
//  LoopBannerDamo
//
//  Created by edz on 2017/4/24.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "ViewController.h"
#import "YSLoopBanner.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    YSLoopBanner *loop = [[YSLoopBanner alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 260) scrollDuration:3.f];
    [self.view addSubview:loop];
    loop.imageURLStrings = @[@"1.jpg", @"2.jpg", @"3.jpg"];
    loop.selectedColor = [UIColor redColor];
    loop.normalColor = [UIColor whiteColor];
    loop.clickAction = ^(NSInteger index) {
        NSLog(@"curIndex: %ld", index);
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
