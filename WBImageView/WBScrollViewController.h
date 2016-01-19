//
//  WBScrollViewController.h
//  WBImageView
//
//  Created by Mac on 16/1/8.
//  Copyright © 2016年 耿金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBImageViewItem.h"
#import "WBImageView.h"

@interface WBScrollViewController : UIViewController

@property(nonatomic,retain)NSArray *data;

@property(nonatomic,retain)WBImageViewItem *item;

@property(nonatomic,retain)WBImageView *weiboView;

@end
