LoopBannerDamo

iOS无限循环轮播图（只使用三个imageView）

以前循环轮播图的逻辑：

以前我写过一个无限循环的轮播图，大概逻辑是：根据数据源（图片的数量）新建若干个imageView，然后在ScrollView的代理方法scrollViewDidScroll里判断需要展示的三个imageView的索引号，将这些三个iamgeVIew添加到scrollView上进行展示。这种方式的缺点显而易见：有多少张图片，就要新建多少个imageView控件，而且每次都需要向scrollview上添加imageView。

现在只需要使用三个imageView就可以实现：

我新做的循环轮播图只需要使用3个imagView控件，并且支持定时器自动滚动播放。大致逻辑：在scrollView上添加3个imageView，每滚动一页，通过KVO观察scrollView的contentOffset的变化，判断需要添加的3张图片的索引号，并重置中间的imageView为当前页（中间的imageView永远都是当前页）。需要注意的是，临界值的判断。

本damo重点对项目中的细节做了调整和优化，供大家产考和指导。

```
// 添加观察者：监控offset的变化，进行从新计算下标的方式
YSLoopBanner *loop1 = [[YSLoopBanner alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 260) scrollDuration:3.f];
[self.view addSubview:loop1];
loop1.imageURLStrings = @[@"1.jpg", @"2.jpg", @"3.jpg"];
loop1.selectedColor = [UIColor blueColor];
loop1.normalColor = [UIColor orangeColor];
loop1.clickAction = ^(NSInteger index) {
NSLog(@"curIndex: %ld", index);
};
```
```
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
```

http://www.jianshu.com/p/84180911c70c 原来作者来自：
