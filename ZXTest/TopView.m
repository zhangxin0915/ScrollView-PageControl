//
//  TopView.m
//  ZXTest
//
//  Created by macmini on 16/2/3.
//  Copyright © 2016年 macmini. All rights reserved.
//
#define  kScreenWidth    [UIScreen mainScreen].bounds.size.width

#import "TopView.h"
#import "UIImageView+WebCache.h"

CGFloat const kTopViewHeight = 200.0f;
double const kTimeInterval = 3.0f;


@interface TopView () <UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)NSTimer *timer;



@end


@implementation TopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopViewHeight)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];

    }
    return self;
}

-(void)setImgArrs:(NSArray *)imgArrs
{
    _imgArrs = imgArrs;
    _scrollView.contentSize = CGSizeMake(kScreenWidth * _imgArrs.count, 0);
    [self addImageViewForScrollView];
    [self addPageControl];
    [self addTimerLoop];
}
- (void)addImageViewForScrollView
{
    if (_imgArrs.count > 0) {
//        for (int i = 0 ; i < _imgArrs.count; i++) {
//            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i *kScreenWidth, 0, kScreenWidth, kTopViewHeight)];
//            [imageView sd_setImageWithURL:_imgArrs[i] placeholderImage:nil];
//            imageView.userInteractionEnabled = YES;
//            imageView.tag = i + 100;
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
//            [imageView addGestureRecognizer:tap];
//            [_scrollView addSubview:imageView];
//        }
        
        [_imgArrs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(idx *kScreenWidth, 0, kScreenWidth, kTopViewHeight)];
            [imageView sd_setImageWithURL:_imgArrs[idx] placeholderImage:nil];
            imageView.userInteractionEnabled = YES;
            imageView.tag = idx + 100;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
            [imageView addGestureRecognizer:tap];
            [_scrollView addSubview:imageView];
            
        }];
    }
    
}
- (void)addPageControl
{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kTopViewHeight - 20, kScreenWidth, 20)];
    _pageControl.numberOfPages = _imgArrs.count;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
    
}
- (void)addTimerLoop
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(changeOffSet) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

#pragma mark -  手势
-(void)tapImageView:(UIGestureRecognizer *)ges
{
    if ([ges.view isKindOfClass:[UIImageView class]]) {
        UIImageView *imgView = (UIImageView *)ges.view;
        NSLog(@"imgView.tag == %ld",imgView.tag);
    }
}
#pragma mark - UIPageControl 事件
- (void)changePage:(UIPageControl *)pageControl
{
    _scrollView.contentOffset = CGPointMake(_pageControl.currentPage * kScreenWidth, 0);
}
#pragma mark -  改变偏移量
- (void)changeOffSet
{
  CGFloat x =  _scrollView.contentOffset.x;
    if (x >= (_imgArrs.count - 1) * kScreenWidth) {
        _scrollView.contentOffset = CGPointZero;
        _pageControl.currentPage = 0;
    }else{
        _scrollView.contentOffset = CGPointMake(x + kScreenWidth, 0);
        _pageControl.currentPage ++;
    }
}

#pragma mark -  UIScrollView代理
//手动滑动移除timer 滑动结束add timer
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self removeTimer];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self addTimerLoop];
}

- (void)removeTimer {
    if (_timer == nil) return;
    [_timer invalidate];
    _timer = nil;
}
-(void)dealloc
{
    [self removeTimer];
}



@end
