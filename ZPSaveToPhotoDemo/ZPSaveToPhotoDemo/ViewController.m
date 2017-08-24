//
//  ViewController.m
//  ZPSaveToPhotoDemo
//
//  Created by yueru on 2017/8/24.
//  Copyright © 2017年 赵攀. All rights reserved.
//

#import "ViewController.h"
#import "ZPSaveToPhotoTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIImage *image = [UIImage imageNamed:@"1"];
    [ZPSaveToPhotoTool saveToPhotoWtihImage:image success:^{
        NSLog(@"保存成功");
    } failer:^{
        NSLog(@"保存失败");
    }];
}


@end
