//
//  WBImageView.m
//  WBImageView
//
//  Created by Mac on 16/1/8.
//  Copyright © 2016年 耿金鹏. All rights reserved.
//

#import "WBImageView.h"

#define kWidth self.frame.size.width
#define kSpace 10
#import "UIViewExt.h"
#import "WBImageViewItem.h"
#import "WBScrollViewController.h"
#import "UIImageView+WebCache.h"

@implementation WBImageView



-(void)setData:(NSArray *)data{

    _data = data;
    //获取View高度
    CGFloat height = [self heightForCount:data.count];
    
    self.height = height;
    
    _items = [NSMutableArray array];
    
    for (int i = 0; i <data.count; i ++) {
        
        WBImageViewItem *item = [[WBImageViewItem alloc]initWithFrame:[self frameForItemIndex:i]];
        
        //设置可触摸
        item.userInteractionEnabled = YES;
        
        //自动适应
//        item.contentMode = UIViewContentModeScaleAspectFit;
        
        item.index = i;
        
        item.originframe = item.frame;
        
        //设置图片
        [item setImageWithURL:[NSURL URLWithString:_data[i]]];
        
        [_items addObject:item];
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemTap:)];
        
        //给每一个item添加手势
        [item addGestureRecognizer:tap];
        
        [self addSubview:item];
    }
    

}

//根据数据计算高度
-(CGFloat)heightForCount:(NSInteger)count{

    //计算行数
    long row = count/3;
    
    if (count%3 != 0) {
        
        row ++;
    }
    
    //每个图片控件的高度
    CGFloat itemW = (kWidth - kSpace *4)/3;
    
    //计算总高度
    CGFloat height = row * itemW + kSpace *(row +1);
    
    return height;

}

//计算每个item的frame
-(CGRect)frameForItemIndex:(int)i{

    //每个item的宽
    CGFloat itemW = (kWidth -kSpace *4)/3;
    
    //坐标
    CGFloat x = itemW *(i%3) + (i%3 +1)*kSpace;
    CGFloat y = i/3*itemW + kSpace*(i/3 + 1);
    
    return CGRectMake(x, y, itemW, itemW);

}

//手势操作
-(void)itemTap:(UITapGestureRecognizer *)tap{

    WBImageViewItem *item = (WBImageViewItem *)tap.view;
    
//    item.contentMode = UIViewContentModeScaleAspectFit;
    
    WBScrollViewController *weiboScrollView = [[WBScrollViewController alloc]init];
    
    weiboScrollView.data = self.data;
    
    weiboScrollView.item = item;
    
    weiboScrollView.weiboView = self;
    
    //推出模态视图
    [self.viewController presentViewController:weiboScrollView animated:YES completion:nil];

}

@end
