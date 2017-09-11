//
//  ModelsCell.m
//  KNImageTransitioning
//
//  Created by 刘凡 on 2017/7/19.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import "ModelsCell.h"
#import "Masonry.h"

@interface ModelsCell ()

//标题Lable;
@property(nonatomic, strong)UILabel *titleLable;

//添加这个View;
@property(nonatomic, strong)UIView *imagesView;

@end

@implementation ModelsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView setBackgroundColor:[UIColor lightGrayColor]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLable];
       
        
    }
    return self;
}

-(void)setModels:(Models *)models
{
    _models = models;

    if (self.imagesView) {
        [self.imagesView removeFromSuperview];
        self.imagesView = nil;
    }
    //设置标题
    self.titleLable.text = models.title;
    //设置位置
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(20);
        make.top.equalTo(self.contentView).with.offset(5);
    }];
    
    CGFloat height = (([UIScreen mainScreen].bounds.size.width - 20)/3.0) * ((_models.images.count - 1)/3 + 1);

    [self.contentView addSubview:self.imagesView];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.width.equalTo(@([UIScreen mainScreen].bounds.size.width - 20));
    }];
    
    //循环。类似forIN. 但是带类型， 循环完能停止。或者控制stop = YES
    [_models.images enumerateObjectsUsingBlock:^(UIImage  *image, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.userInteractionEnabled = YES;
        //添加手势
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageClick:)]];
        //设置tag。self.tag + 下表
        imageView.tag = [self tag] + idx;
        [self.imagesView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imagesView).offset((([UIScreen mainScreen].bounds.size.width - 20)/3.0) * (idx/3));
            make.left.equalTo(self.imagesView).offset((([UIScreen mainScreen].bounds.size.width - 20)/3.0) * (idx%3));
            make.size.mas_equalTo(CGSizeMake((([UIScreen mainScreen].bounds.size.width - 20)/3.0), (([UIScreen mainScreen].bounds.size.width - 20)/3.0)));
        }];
        
    }];
    
    //立即布局
    [self layoutIfNeeded];
    
}

//图片点击
-(void)ImageClick:(UITapGestureRecognizer *)sender{
    
    NSMutableArray *initialFrames = [NSMutableArray array];
    
    for (int i = 0; i < _models.images.count ; i++) {
        
        //搜索这个view上面所有控件。 按照tag来搜索
        UIImageView * imageView = (UIImageView *)[self.contentView viewWithTag:[self tag] +i];
        imageView.contentMode = UIViewContentModeScaleAspectFill;

        CGRect realRect = [self.contentView convertRect:[self.imagesView convertRect:imageView.frame toView:self] toView:self.superview.superview.superview];
        
        //以NSValue 的数据类型保存起来
        [initialFrames addObject:[NSValue valueWithCGRect:realRect]];
    }
    
    if (self.delegate) {
        //调用代理把值传出去
        [self.delegate modelsCellDidClick:sender.view.tag - [self tag] images:_models.images initialFrames:initialFrames];
    }
}


-(NSInteger)tag{
  return  10000;
}


- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.numberOfLines = 0;
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.font = [UIFont systemFontOfSize:13];
    }
    return _titleLable;
}
                                            

- (UIView *)imagesView {
    if (!_imagesView) {
        _imagesView = [UIView new];
    }
    return _imagesView;
}

@end
