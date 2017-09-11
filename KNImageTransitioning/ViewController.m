//
//  ViewController.m
//  KNImageTransitioning
//
//  Created by 刘凡 on 2017/7/19.
//  Copyright © 2017年 Krystal. All rights reserved.
//

#import "ViewController.h"
#import "KNTransitioning.h"
#import "Models.h"
#import "ModelsCell.h"
#import "KNImageViewController.h"
#import "KNImageAnimation.h"
#import "Masonry.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,ModelsDelegate>



/**
 表格视图
 */
@property(nonatomic, strong)UITableView *tableView;


/**
 数据列表
 */
@property(nonatomic, copy)NSArray *dataArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getArrayData];
    [self CreateUI];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)CreateUI{
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)getArrayData{
    
    //这里做一个假的数据
    _dataArray = @[
                   
                   [[Models alloc]initWithTitle:@"分组1" Images:@[[UIImage imageNamed:@"123.jpg"],]]
                   ,[[Models alloc]initWithTitle:@"分组2" Images:@[[UIImage imageNamed:@"123.jpg"],
                                                                [UIImage imageNamed:@"123.jpg"],]]
                   ,[[Models alloc]initWithTitle:@"分组3" Images:@[[UIImage imageNamed:@"123.jpg"],
                                                                [UIImage imageNamed:@"123.jpg"],
                                                                [UIImage imageNamed:@"123.jpg"]]]
                   ,[[Models alloc]initWithTitle:@"分组4" Images:@[[UIImage imageNamed:@"123.jpg"],
                                                                [UIImage imageNamed:@"123.jpg"],
                                                                [UIImage imageNamed:@"123.jpg"],
                                                                [UIImage imageNamed:@"123.jpg"]]]
                   ,[[Models alloc]initWithTitle:@"分组5" Images:@[[UIImage imageNamed:@"123.jpg"],
                                                                [UIImage imageNamed:@"123.jpg"],
                                                                [UIImage imageNamed:@"123.jpg"],
                                                                [UIImage imageNamed:@"123.jpg"],
                                                                [UIImage imageNamed:@"123.jpg"]]]
                   ,[[Models alloc]initWithTitle:@"分组6" Images:@[[UIImage imageNamed:@"123.jpg"],
                                                                [UIImage imageNamed:@"123.jpg"],
                                                                [UIImage imageNamed:@"123.jpg"],
                                                                [UIImage imageNamed:@"123.jpg"],
                                                                [UIImage imageNamed:@"123.jpg"],
                                                                [UIImage imageNamed:@"123.jpg"]]]
                   
                   ];
}



#pragma mark - 设置数据
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModelsCell *myCell = (ModelsCell *)cell;
    myCell.delegate = self;
    [myCell setModels:_dataArray[indexPath.row]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

#pragma mark - 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ModelsCell class])];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return ((Models *)_dataArray[indexPath.row]).rowHeight;
}
//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

-(void)modelsCellDidClick:(NSInteger)index images:(NSArray<UIImage *> *)images initialFrames:(NSArray<NSValue *> *)initialFrames
{
    [self presentViewController:[[KNImageViewController alloc]initWithImages:images initialFrames:initialFrames currentIndex:index ] animated:YES completion:^{
        
    }];
}

/**
 懒加载初始化表格对象

 @return 返回表格。其他地方直接使用self.tableView 即可
 */
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //注册cell
        [_tableView registerClass:[ModelsCell class] forCellReuseIdentifier:NSStringFromClass([ModelsCell class])];
    }
    return _tableView;
}


@end
