//
//  YYLoopBanner_Scroll.h
//  LoopBannerDamo
//
//  Created by edz on 2017/4/25.
//  Copyright © 2017年 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SelectedColor [UIColor redColor]
#define NormalColor [UIColor whiteColor]

#define Margin 2

@interface YYLoopBanner_Scroll : UIView

/// click action
@property (nonatomic, copy) void (^clickAction) (NSInteger curIndex) ;

/// data source
@property (nonatomic, copy) NSArray *imageURLStrings;

/// selectedColor
@property (nonatomic, copy) UIColor *selectedColor;

/// normalColor
@property (nonatomic, copy) UIColor *normalColor;

- (instancetype)initWithFrame:(CGRect)frame scrollDuration:(NSTimeInterval)duration;
@end
