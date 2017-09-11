//
//  UIViewController+KNPushTransitioning.h
//  KNImageTransitioning
//
//  Created by 刘凡 on 2017/7/20.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNAnimation.h"

//push到下一个页面的时候。设置的自定义动画
@interface UIViewController (KNPushTransitioning)<UINavigationControllerDelegate>

//push 到下一个页面.自定义动画设置
@property(nonatomic, strong)KNAnimation * pushAnimation;
//pop 回来来的时候。动画设置
@property(nonatomic, strong)KNAnimation * popAnimation;


-(void)kn_pushAnimation:(KNAnimation *)animation;

-(void)kn_popAnimation:(KNAnimation *)animation;
@end
