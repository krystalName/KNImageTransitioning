//
//  KNImageAnimation.m
//  KNImageTransitioning
//
//  Created by 刘凡 on 2017/7/20.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import "KNImageAnimation.h"
#import "KNImageViewController.h"

@implementation KNImageAnimation


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.2;
}

#pragma mark - Push
//忽略下面的警告
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //Push
    if ([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isKindOfClass:[KNImageViewController class]]) {
        //目的ViewController
        KNImageViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        //起始ViewController
        UIViewController *formVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        //添加toVC 到上下文
        [[transitionContext containerView] insertSubview:toVC.view belowSubview:formVC.view];
        
        //设置一个透明颜色
        toVC.view.backgroundColor = [UIColor clearColor];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            formVC.view.alpha = 0;
            toVC.view.backgroundColor = [UIColor blackColor];
        } completion:^(BOOL finished) {
            
            if ([toVC respondsToSelector:NSSelectorFromString(@"showAnimation:")]){
                [toVC performSelector:NSSelectorFromString(@"showAnimation:") withObject:^(BOOL finished) {
                    formVC.view.alpha = 1;
                    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                }];
            }
        }];
    }else{
        //POP
        //目的ViewController
        UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        //起始ViewController
        KNImageViewController * formVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
    //添加上下文
    [[transitionContext containerView] insertSubview:toVC.view belowSubview:formVC.view];
        if ([formVC respondsToSelector:NSSelectorFromString(@"hideAnimation:")]) {
            [formVC performSelector:NSSelectorFromString(@"hideAnimation:") withObject:^(BOOL finished) {
                [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
                    formVC.view.alpha = 0;
                } completion:^(BOOL finished) {
                    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                }];
            }];
        }
    }
}
@end
