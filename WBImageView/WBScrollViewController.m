//
//  WBScrollViewController.m
//  WBImageView
//
//  Created by Mac on 16/1/8.
//  Copyright © 2016年 耿金鹏. All rights reserved.
//

#import "WBScrollViewController.h"
#import "UIImageView+WebCache.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height


@interface WBScrollViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    NSInteger _index;
}
@end

@implementation WBScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    
    _scrollView.contentSize = CGSizeMake(kScreenW * self.data.count, kScreenH);
    
    [self.view addSubview:_scrollView];
    
    _scrollView.pagingEnabled = YES;
    
    _scrollView.delegate = self;
    
    
    _scrollView.hidden = YES;
    
    for (int i= 0; i<self.data.count; i ++) {
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW *i , 0, kScreenW, kScreenH)];
        
        imgV.userInteractionEnabled = YES;
        
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        
        //获取路径
        NSString *url = self.data[i];
        
        url = [url stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
        
        [imgV setImageWithURL:[NSURL URLWithString:url]];
     
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgVTap:)];
        
        [imgV addGestureRecognizer:tap];
        
        [_scrollView addSubview:imgV];
    }
    
}


-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];

    //frame所在的坐标系转换
    CGRect newframe = [self.item.superview convertRect:self.item.frame toView:self.view];
    
    self.item.contentMode = UIViewContentModeScaleAspectFit;

    
    //重新设置坐标
    self.item.frame = newframe;
    
    //添加到当前视图
    [self.view addSubview:self.item];
    
    //动画修改frame
    [UIView animateWithDuration:1 animations:^{
        
        self.item.frame = self.view.bounds;
    } completion:^(BOOL finished) {
        
        _scrollView.hidden  =NO;
        
        self.item.contentMode = UIViewContentModeScaleToFill;
        
        //移除item
        [self.item removeFromSuperview];
        
        //还原item
        self.item.frame = self.item.originframe;
        [self.weiboView addSubview:self.item];
        
        [_scrollView scrollRectToVisible:CGRectMake(kScreenW * self.item.index, 0, kScreenW, kScreenH) animated:NO];
    }];
    
}

//点击操作
-(void)imgVTap:(UITapGestureRecognizer *)tap{

    //获取到item
    WBImageViewItem *item = self.weiboView.items[_index];
    
    item.contentMode = UIViewContentModeScaleAspectFit;
    
    [item.superview bringSubviewToFront:item];
    
    //坐标系转换
    CGPoint point = [self.view convertPoint:CGPointZero toView:self.weiboView];
    
    item.frame = CGRectMake(point.x, point.y, kScreenW, kScreenH);
    
    
    [self dismissViewControllerAnimated:NO completion:^{
        
        
        //动画修改itemframe
        [UIView animateWithDuration:1 animations:^{
            
            item.frame = item.originframe;

        }completion:^(BOOL finished) {
            
            item.contentMode = UIViewContentModeScaleToFill;
 
        }];
    }];
}

#pragma mark ------- UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    _index = (NSInteger )scrollView.contentOffset.x/kScreenW;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
