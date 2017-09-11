//
//  Models.h
//  KNImageTransitioning
//
//  Created by 刘凡 on 2017/7/19.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Models : NSObject

@property(nonatomic, strong)NSString *title;

@property(nonatomic, strong)NSArray *images;

@property(nonatomic, assign, readonly) CGFloat rowHeight;


-(instancetype)initWithTitle:(NSString *)title Images:(NSArray<UIImage *> *)images;

@end
