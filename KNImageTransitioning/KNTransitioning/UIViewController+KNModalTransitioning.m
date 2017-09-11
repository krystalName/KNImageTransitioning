//
//  UIViewController+KNModalTransitioning.m
//  KNImageTransitioning
//
//  Created by 刘凡 on 2017/7/20.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import "UIViewController+KNModalTransitioning.h"
#import <objc/runtime.h>

@implementation UIViewController (KNModalTransitioning)

static NSString * kn_presentAniamtion_key = @"kn_presentAniamtion_key";
static NSString * kn_dismissAniamtion_key = @"kn_dismissAniamtion_key";




-(void)setPresentAnimation:(KNAnimation *)presentAnimation
{
    //获取关联的对象,给一个KEY作为标示;
    //参数1. 源对象//参数2. 关联字//参数3. 关联的对象//参数4. 关联策略
    objc_setAssociatedObject(self, &kn_presentAniamtion_key, presentAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(KNAnimation *)presentAnimation{
    //将定义的presentAnimation设置为关联对象,通过一个key
    return objc_getAssociatedObject(self, &kn_presentAniamtion_key);
}


-(void)setDismissAnimation:(KNAnimation *)dismissAnimation{
    
    //一样先过获取关联对象,拿一个key作为标示
    objc_setAssociatedObject(self, &kn_dismissAniamtion_key, dismissAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(KNAnimation *)dismissAnimation{
    
   return  objc_getAssociatedObject(self, &kn_dismissAniamtion_key);
}

-(void)kn_presentAnimation:(KNAnimation *)animation{
    //设置这个方法调用的同时.self.presentAnimation 获取到关联动画
    self.presentAnimation = animation;
    self.transitioningDelegate = self;
}

-(void)kn_dismissAnimation:(KNAnimation *)animation{
    //设置这个方法调用的同时，这个方法获取到animation 赋值给slef.dismissAnimation;
    self.dismissAnimation = animation;
    self.transitioningDelegate = self;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    //代理方法。返回当前已经获取到的self.dismissAnimation
    return (id<UIViewControllerAnimatedTransitioning>)self.dismissAnimation;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    //代理方法。进入到下一个页面的是。 调用到的自定义动画
    return (id<UIViewControllerAnimatedTransitioning>)self.presentAnimation;
}

@end
