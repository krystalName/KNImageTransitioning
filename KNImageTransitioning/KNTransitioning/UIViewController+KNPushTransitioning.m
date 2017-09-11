//
//  UIViewController+KNPushTransitioning.m
//  KNImageTransitioning
//
//  Created by 刘凡 on 2017/7/20.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import "UIViewController+KNPushTransitioning.h"
#import <objc/runtime.h>

@implementation UIViewController (KNPushTransitioning)
//先定义两个key
static NSString * kn_pushAnimation_key = @"kn_pushAnimation_key";
static NSString * kn_popAnimation_key = @"kn_popAnimation_key";

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //将viewWillAppear这个方法封装成SEL对象
        //定义这个方法的指针
        SEL systemSel = @selector(viewWillAppear:);
        //定义一个自己方法的指针
        SEL sknSEL    = @selector(kn_viewWillAppear:);
        Method systemMethod = class_getClassMethod([self class], systemSel);
        Method sknMethod    = class_getClassMethod([self class], sknSEL);
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(sknMethod), method_getTypeEncoding(sknMethod));
        if (isAdd) {
            class_replaceMethod(self, sknSEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }else{
            method_exchangeImplementations(systemMethod, sknMethod);
        }
        
    });
}


-(void)kn_viewWillAppear:(BOOL)aniamted{
    [self kn_viewWillAppear:aniamted];
    self.navigationController.delegate  = self;
}

-(void)setPushAnimation:(KNAnimation *)pushAnimation{
    objc_setAssociatedObject(self, &kn_pushAnimation_key, pushAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(KNAnimation *)pushAnimation{
    return  objc_getAssociatedObject(self, &kn_pushAnimation_key);
}


-(void)setPopAnimation:(KNAnimation *)popAnimation{
    objc_setAssociatedObject(self, &kn_popAnimation_key, popAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(KNAnimation *)popAnimation{
    return  objc_getAssociatedObject(self, &kn_popAnimation_key);
}

-(void)kn_pushAnimation:(KNAnimation *)animation{
    self.pushAnimation = animation;
    self.navigationController.delegate = self;
}

-(void)kn_popAnimation:(KNAnimation *)animation{
    self.popAnimation = animation;
    self.navigationController.delegate = self;
}


//调用转场动画
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    
    if (operation == UINavigationControllerOperationPush) {
        return (id<UIViewControllerAnimatedTransitioning>)self.pushAnimation;
    }else if(operation == UINavigationControllerOperationPop){
        return (id<UIViewControllerAnimatedTransitioning>)self.popAnimation;
    }else{
        return nil;
    }
}
@end
