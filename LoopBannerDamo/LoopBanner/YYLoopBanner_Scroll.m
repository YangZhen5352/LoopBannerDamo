//
//  YYLoopBanner_Scroll.m
//  LoopBannerDamo
//
//  Created by edz on 2017/4/25.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "YYLoopBanner_Scroll.h"

@interface YYLoopBanner_Scroll ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, assign) NSInteger curIndex;

/// scroll timer
@property (nonatomic, strong) NSTimer *scrollTimer;

/// scroll duration
@property (nonatomic, assign) NSTimeInterval scrollDuration;


@end

@implementation YYLoopBanner_Scroll

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame scrollDuration:(NSTimeInterval)duration
{
    if (self = [super initWithFrame:frame]) {
        
        // 滚动时间
        self.scrollDuration = 0.f;
        // 设置界面
        [self setupViews];
        // 如果用户设置的滚动时间大于0.0秒的时候：调用定时器
        if (duration > 0.f) {
            self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:(self.scrollDuration = duration)
                                                                target:self
                                                              selector:@selector(scrollTimerDidFired:)
                                                              userInfo:nil
                                                               repeats:YES];
            [self.scrollTimer setFireDate:[NSDate distantFuture]];
            [[NSRunLoop currentRunLoop] addTimer:self.scrollTimer forMode:NSRunLoopCommonModes];
        }
    }
    return self;
}
#pragma mark - 设置frame
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.scrollDuration = 0.f;
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    [self.scrollView addSubview:self.leftImageView];
    [self.scrollView addSubview:self.middleImageView];
    [self.scrollView addSubview:self.rightImageView];
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
    self.selectedColor = self.pageControl.currentPageIndicatorTintColor;
    self.normalColor = self.pageControl.pageIndicatorTintColor;
    
    [self placeSubviews];
}

- (void)placeSubviews {
    CGRect frame = self.bounds;
    self.scrollView.frame = CGRectMake(frame.origin.x - Margin * 4, frame.origin.y, frame.size.width+Margin * 4, frame.size.height);
    self.pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.bounds) - 30.f, CGRectGetWidth(self.bounds), 20.f);
    
    CGFloat imageWidth = CGRectGetWidth(self.scrollView.bounds);
    CGFloat imageHeight = CGRectGetHeight(self.scrollView.bounds);
    self.leftImageView.frame    = CGRectMake(imageWidth * 0 + Margin, 0, imageWidth, imageHeight);
    self.middleImageView.frame  = CGRectMake(imageWidth * 1 + Margin*2, 0, imageWidth, imageHeight);
    self.rightImageView.frame   = CGRectMake(imageWidth * 2 + Margin*3, 0, imageWidth, imageHeight);
    self.scrollView.contentSize = CGSizeMake(imageWidth * 3 + Margin * 6, 0);
    
    [self setScrollViewContentOffsetCenter];
}

#pragma mark - setters
- (void)setImageURLStrings:(NSArray *)imageURLStrings {
    if (imageURLStrings) {
        _imageURLStrings = imageURLStrings;
        
        // 设置默认下标为0
        self.curIndex = 0;
        
        // 有图片
        if (imageURLStrings.count > 1) {
            // 自动滚动
            [self.scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.scrollDuration]];
            // 设置总页数／当前页码／显示
            self.pageControl.numberOfPages = imageURLStrings.count;
            self.pageControl.currentPage = 0;
            self.pageControl.hidden = NO;
            
            // 无图片
        } else {
            self.pageControl.hidden = YES;
            [self.leftImageView removeFromSuperview];
            [self.rightImageView removeFromSuperview];
            self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.bounds), 0);
        }
    }
}

- (void)setCurIndex:(NSInteger)curIndex {
    if (_curIndex >= 0) {
        _curIndex = curIndex;
        
        // 计算下标
        NSInteger imageCount = self.imageURLStrings.count;
        NSInteger leftIndex = (curIndex + imageCount - 1) % imageCount;
        NSInteger rightIndex= (curIndex + 1) % imageCount;
        
        self.leftImageView.image = [UIImage imageNamed:self.imageURLStrings[leftIndex]];
        self.middleImageView.image = [UIImage imageNamed:self.imageURLStrings[curIndex]];
        self.rightImageView.image = [UIImage imageNamed:self.imageURLStrings[rightIndex]];
        
        // 每一次滚动都是移动当前的页码到中心位置
        [self setScrollViewContentOffsetCenter];
        
        self.pageControl.currentPage = curIndex;
    }
}
- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    _pageControl.currentPageIndicatorTintColor = (_selectedColor) ? (_selectedColor) : (SelectedColor);
}
- (void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    _pageControl.pageIndicatorTintColor = (_normalColor) ? (_normalColor) : (NormalColor);
}

#pragma mark - 图片点击的手势
- (void)imageClicked:(UITapGestureRecognizer *)tap {
    // 图片点击手势的：回调方法
    if (self.clickAction) {
        self.clickAction (self.curIndex);
    }
}

#pragma mark - 定时器自动调用方法
- (void)scrollTimerDidFired:(NSTimer *)timer {
    // 正确的ImageView的位置，因为每一个自动滚动后
    // 可以在一页中显示两幅图像
    // 设置临界值
    CGFloat criticalValue = .2f;
    if (self.scrollView.contentOffset.x < CGRectGetWidth(self.scrollView.bounds) - criticalValue || self.scrollView.contentOffset.x > CGRectGetWidth(self.scrollView.bounds) + criticalValue) {
        [self setScrollViewContentOffsetCenter];
    }
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.bounds), self.scrollView.contentOffset.y);
    [self.scrollView setContentOffset:newOffset animated:YES];
}
#pragma mark - 设置滚动视图：内容偏移量到中心
- (void)setScrollViewContentOffsetCenter {
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.bounds), 0);
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self caculateCurIndex];
}
// 计算当前的下标
- (void)caculateCurIndex {
    if (self.imageURLStrings && self.imageURLStrings.count > 0) {
        // 滑动的偏移量
        CGFloat pointX = self.scrollView.contentOffset.x;
        
        //判断临界值，第一个和第三个ImageView的contentoffset
        CGFloat criticalValue = 0.2f;
        
        // 向右滚动，判断正确临界值
        if (pointX > 2 * CGRectGetWidth(self.scrollView.bounds) - criticalValue) {
            self.curIndex = (self.curIndex + 1) % self.imageURLStrings.count;
        } else if (pointX < criticalValue) {
            // 向左滚动，判断左临界值
            self.curIndex = (self.curIndex + self.imageURLStrings.count - 1) % self.imageURLStrings.count;
        }
    }
}

#pragma mark - getters
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        _pageControl.pageIndicatorTintColor = (self.normalColor) ? (self.normalColor) : (NormalColor);
        _pageControl.currentPageIndicatorTintColor = (self.selectedColor) ? (self.selectedColor) : (SelectedColor);
    }
    
    return _pageControl;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [UIImageView new];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        //_leftImageView.backgroundColor = [UIColor yellowColor];
    }
    
    return _leftImageView;
}

- (UIImageView *)middleImageView {
    if (!_middleImageView) {
        _middleImageView = [UIImageView new];
        _middleImageView.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
        [_middleImageView addGestureRecognizer:tap];
        //_middleImageView.backgroundColor = [UIColor redColor];
        _middleImageView.userInteractionEnabled = YES;
    }
    
    return _middleImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [UIImageView new];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
        //_rightImageView.backgroundColor = [UIColor greenColor];
    }
    
    return _rightImageView;
}
- (void)dealloc {
    // 清除定时器
    if (self.scrollTimer) {
        [self.scrollTimer invalidate];
        self.scrollTimer = nil;
    }
}

@end
