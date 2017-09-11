//
//  KNImageViewController.m
//  KNImageTransitioning
//
//  Created by 刘凡 on 2017/7/19.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import "KNImageViewController.h"
#import "Masonry.h"
#import "KNImageAnimation.h"
#import "KNTransitioning.h"

@interface KNImageViewController ()<UIScrollViewDelegate>

/**
 图片集合
 */
@property(nonatomic, strong)NSArray *images;

/**
 位置的集合
 */
@property(nonatomic, strong)NSArray *initialFrames;


/**
 当前选中的第几个
 */
@property(nonatomic, assign)NSUInteger currentIndex;

/**
 装图片。用于查看图片的ScrollView;
 */
@property(nonatomic, strong)UIScrollView *scrollView;

/**
 用于显示当前在第几个的提示作用
 */
@property(nonatomic, strong)UIPageControl *pageControl;

@end

@implementation KNImageViewController

-(instancetype)initWithImages:(NSArray<UIImage *> *)images initialFrames:(NSArray<NSValue *> *)initialFrames currentIndex:(NSUInteger)currentIndex
{
    if (self = [super init]) {
    
        //赋值
        _images = images;
        _initialFrames = initialFrames;
        _currentIndex = currentIndex;
        //设置背景颜色
        self.view.backgroundColor = [UIColor blackColor];
        
        [self kn_presentAnimation:[KNImageAnimation new]];
        [self kn_dismissAnimation:[KNImageAnimation new]];
    }
    return self;
}

 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CreateUI];
}


//创建UI
-(void)CreateUI{
    
    //添加滑动的View;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    //设置查看的点位置
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-100);
        make.centerX.equalTo(self.view);
    }];
    
    
    //循环创建imageView;
    
    [_images enumerateObjectsUsingBlock:^(UIImage * image, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
        imageView.tag = [self tag] + idx;
        if (idx == _currentIndex) {
            CGRect rect;
            [_initialFrames[_currentIndex] getValue:&rect];
            rect.origin.x += _currentIndex*self.view.frame.size.width;
            imageView.frame = rect;
        } else {
            imageView.bounds = (CGRect){CGPointZero, image.size};
            imageView.center = CGPointMake(self.view.center.x + self.view.frame.size.width * idx, self.view.center.y);
        }
        [_scrollView addSubview:imageView];
    }];
    
    
    
}



//关闭这个选择的VC
-(void)ChooseClick:(UITapGestureRecognizer *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//显示出来的时候。 设置一个动画
-(void)showAnimation:(void (^)(BOOL finished))completion{
    //获取当前选择的ImageView
    UIImageView * currentImageView = (UIImageView *)[self.view viewWithTag:[self tag] + _currentIndex];
    [UIView animateWithDuration:0.3 animations:^{
        
        //因为是刚开始显示。所以直接设置动画显示位置
        currentImageView.bounds = (CGRect){CGPointZero,currentImageView.image.size};
        //设置中间就是中间位置
        currentImageView.center = CGPointMake(self.view.center.x + _currentIndex *self.view.frame.size.width  , self.view.center.y);
    } completion:completion];
    
}
//隐藏的时候。 设置一个动画
-(void)hideAnimation:(void (^)(BOOL finished))completion{
    //首先要获取到当前选择的下标
    NSUInteger currentIndex = _scrollView.contentOffset.x / self.view.frame.size.width;
    //然后全局搜索。根据tag 获取到这个ImageView
    UIImageView * currentImageView = (UIImageView *)[self.view viewWithTag:[self tag]+ currentIndex];
    [UIView animateWithDuration:0.3 animations:^{
        //要做的是。先从我们保存在initalFrames里面的位置，获取到rect
        CGRect rect;
        [_initialFrames[currentIndex] getValue:&rect];
        rect.origin.x += currentIndex * self.view.frame.size.width;
        currentImageView.frame = rect;
    } completion:completion];
    
}




//获取一个tag值。为10000
-(NSInteger)tag{
    return 10000;
}


//pagecontroll的委托方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    //    NSLog(@"%d", page);
    
    // 设置页码
    _pageControl.currentPage = page;
}




- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * _images.count, self.view.frame.size.height);
        [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChooseClick:)]];
        _scrollView.contentOffset = CGPointMake(_currentIndex * self.view.frame.size.width, 0);
    }
    return _scrollView;
}



-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.numberOfPages = _images.count;
        _pageControl.currentPage = _currentIndex;
        // 设置非选中页的圆点颜色

        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];

    }
    return _pageControl;
}


@end
