//
//  ViewController.m
//  D01-图片轮播器[掌握]
//
//  Created by chang on 16/3/10.
//  Copyright (c) 2016年 itcast. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak,nonatomic) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    int count = 5;
    
    CGSize size = self.scrollView.frame.size;
    
//  动态的添加子控件
    for (int i = 1; i <= count; i++) {
        
        NSString *name = [NSString stringWithFormat:@"img_%02d",i];
        
        UIImage  *image = [UIImage imageNamed:name];
        
        UIImageView  *imageView = [[UIImageView alloc] init];
        
        imageView.image = image;
        
        imageView.frame = CGRectMake(size.width * (i - 1),0,size.width,size.height);
        
        [self.scrollView addSubview:imageView];
    }
    
  
//  设置滚动的区域
    self.scrollView.contentSize = CGSizeMake(size.width * count, 0);
//  设置需要分页
    self.scrollView.pagingEnabled = YES;
//  设置不需要滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
//  设置scrollView代理
    self.scrollView.delegate = self;
    
//  设置pageControl页数
    self.pageControl.numberOfPages = count;
    
//  自动滚动
//    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [self start];
}

- (void) start
{
    NSTimer *timer  = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timer = timer;
}

- (void) stop
{
    [self.timer invalidate];
}

- (void) nextPage
{
    NSInteger currentPage = self.pageControl.currentPage;
    
    if (currentPage == self.pageControl.numberOfPages - 1) {
        currentPage = 0;
    }else{
        currentPage++;
    }
    
    CGPoint offset = CGPointMake(currentPage * self.scrollView.frame.size.width, 0);
    
    [self.scrollView setContentOffset:offset  animated:YES];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage  = (self.scrollView.contentOffset.x + self.scrollView.frame.size.width * 0.5) / self.scrollView.frame.size.width;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}


- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self start];
}


@end
