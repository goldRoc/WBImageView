//
//  ViewController.m
//  WBImageView
//
//  Created by Mac on 16/1/8.
//  Copyright © 2016年 耿金鹏. All rights reserved.
//

#import "ViewController.h"
#import "WBImageView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WBImageView *view = [[WBImageView alloc]initWithFrame:CGRectMake(50, 200, 300, 0)];

    view.backgroundColor = [UIColor grayColor];
    
    
    view.data = @[@"http://ww2.sinaimg.cn/bmiddle/005wayyCjw1ewiou3zc0dj30h20mlgoq.jpg",@"http://ww1.sinaimg.cn/bmiddle/005wayyCgw1ew6yyvcv7vj30fa0fz40g.jpg",@"http://ww4.sinaimg.cn/bmiddle/005wayyCjw1evyxyr8gmhj30i809h3zw.jpg"];
    
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
