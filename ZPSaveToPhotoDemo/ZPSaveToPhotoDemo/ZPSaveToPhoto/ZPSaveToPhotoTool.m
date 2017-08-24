//
//  ZPSaveToPhotoTool.m
//  ZPSaveToPhotoDemo
//
//  Created by yueru on 2017/8/24.
//  Copyright © 2017年 赵攀. All rights reserved.
//

#import "ZPSaveToPhotoTool.h"
#import <Photos/Photos.h>

@implementation ZPSaveToPhotoTool

+ (void)saveToPhotoWtihImage:(UIImage *)image success:(void (^)())success failer:(void (^)())failer {
    // 得到保存到照片库的照片
    PHFetchResult<PHAsset *> *assets = [self getSavedAssetWithImage:image];
    if (!assets) {
        failer();
    }
    // 创建相册
    PHAssetCollection *asssetCollection = [self creatAssetCollection];
    if (!asssetCollection) {
        failer();
    }
    // 保存照片到自定义照片库
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        [[PHAssetCollectionChangeRequest changeRequestForAssetCollection:asssetCollection] insertAssets:assets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    if (!error) {
        success();
    }else {
        failer();
    }
    
}

+ (PHFetchResult<PHAsset *> *)getSavedAssetWithImage:(UIImage *)image {
    // 将图片存放到相机胶卷
    NSError *error = nil;
    __block NSString *identifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        identifier = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    // 如果保存失败, 调用回调
    if (error) {
        return nil;
    }
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[identifier] options:nil];
}

/**
 获得相册
 */
+ (PHAssetCollection *)creatAssetCollection {
    // 先抓取相册
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 得到APP名字
    NSString *appName = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];
    // 遍历是否已经存在这个相册, 如果有直接返回
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:appName]) {
            return assetCollection;
        }
    }
    // 如果没有 则创建相册
    NSError *error = nil;
    __block NSString *identifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 选拿到相册标示
        identifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:appName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error) {
        return nil;
    }
    // 返回有刚创建标示的相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[identifier] options:nil].firstObject;
}

@end
