//
//  YSLoopBanner.h
//  TestLoopScrollView
//
//  Created by zys on 2016/10/13.
//  Copyright © 2016年 张永帅. All rights reserved.
//

/** 
 *  Infinite loop banner：only use three imageViews 
 */

#import <UIKit/UIKit.h>

#define SelectedColor [UIColor redColor]
#define NormalColor [UIColor whiteColor]

#define Margin 5

@interface YSLoopBanner : UIView

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
