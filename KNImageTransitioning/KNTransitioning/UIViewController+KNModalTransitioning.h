//
//  UIViewController+KNModalTransitioning.h
//  KNImageTransitioning
//
//  Created by 刘凡 on 2017/7/20.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNAnimation.h"

//自定义专场动画的分类
@interface UIViewController (KNModalTransitioning)<UIViewControllerTransitioningDelegate>

//模态窗口出现
@property(nonatomic, strong)KNAnimation *presentAnimation;
//模态窗口消失
@property(nonatomic, strong)KNAnimation *dismissAnimation;

//Add in toVC
- (void)kn_presentAnimation:(KNAnimation *)animation;

//Add in toVC
- (void)kn_dismissAnimation:(KNAnimation *)animation;

@end
