//
//  KNImageViewController.h
//  KNImageTransitioning
//
//  Created by 刘凡 on 2017/7/19.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNImageViewController : UIViewController


/**
 初始化方法,这里不传imageViews 是为了更加灵活

 @param images 所有的images
 @param initialFrames 它们初始化时候的位置
 @param currentIndex 当前选中第几个
 @return KNImageViewController
 */
-(instancetype)initWithImages:(NSArray <UIImage *> *)images
                initialFrames:(NSArray <NSValue *> *)initialFrames
                 currentIndex:(NSUInteger )currentIndex;

@end
