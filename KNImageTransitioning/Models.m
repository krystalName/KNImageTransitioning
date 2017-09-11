//
//  Models.m
//  KNImageTransitioning
//
//  Created by 刘凡 on 2017/7/19.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import "Models.h"

@implementation Models


-(instancetype)initWithTitle:(NSString *)title Images:(NSArray<UIImage *> *)images
{
    if (self = [super init]) {
        _title = title;
        _images = images;
    }
    return self;
}

-(CGFloat)rowHeight{
    
    //获取到标题的的size
    //参数1,是指提供一个宽度，高度 ，
    //参数2,自适应设置 (以行为矩形区域自适应,以字体字形自适应)
    //参数3,文字属性,通常这里面需要知道是字体大小
    //参数4,绘制文本上下文,做底层排版时使用,填nil即可
    CGFloat titleHeight = [_title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, MAXFLOAT ) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    
    //获取图片高度
    //左右间隔10，然后每行放3个图片，多了就加1行,宽度除以3乘行数
    CGFloat imageHeight = ((_images.count -1)/3 + 1) * (([UIScreen mainScreen].bounds.size.width - 10)/3.0);
    
    return titleHeight + imageHeight + 30;
}


@end
