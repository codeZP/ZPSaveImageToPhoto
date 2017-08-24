//
//  ZPSaveToPhotoTool.h
//  ZPSaveToPhotoDemo
//
//  Created by yueru on 2017/8/24.
//  Copyright © 2017年 赵攀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPSaveToPhotoTool : NSObject

/**
 保存图片到相册

 @param image 图片
 @param success 成功回调
 @param failer 失败回调
 */
+ (void)saveToPhotoWtihImage:(UIImage *)image success:(void (^)())success failer:(void (^)())failer;

@end
