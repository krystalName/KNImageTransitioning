//
//  ModelsCell.h
//  KNImageTransitioning
//
//  Created by 刘凡 on 2017/7/19.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Models.h"

@protocol ModelsDelegate <NSObject>

-(void)modelsCellDidClick:(NSInteger )index
                   images:(NSArray <UIImage *> *)images
            initialFrames:(NSArray <NSValue *> *)initialFrames;



@end

@interface ModelsCell : UITableViewCell

@property(nonatomic, strong) Models *models;
@property(nonatomic, weak)id <ModelsDelegate> delegate;


@end
