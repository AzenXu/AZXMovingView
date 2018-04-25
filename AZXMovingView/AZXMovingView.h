//
//  AZXMovingView.h
//  Proj_UICollectionView布局
//
//  Created by Azen.Xu on 15/8/6.
//  Copyright (c) 2015年 Azen.Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AZXMovingDelegate <UICollectionViewDelegate>

//- (void)xxx;

@end

@interface AZXMovingView : UICollectionView

{
    CGFloat _imageMargin;
    CGSize _imageSize;
    CGFloat _scaleChangeValue;
    CGFloat _alphaChangeValue;
}

/** 
 * 图片数组
 * 未传值则不会有图像展示
 */
@property(strong,nonatomic)  NSArray *imageArray;

/** 
 * 图片尺寸
 * 默认值为(50,50)
 */
@property(assign,nonatomic)  CGSize imageSize;

/** 
 * 图片间距
 * 默认值为50
 */
@property(assign,nonatomic) CGFloat imageMargin;

/**
 * 缩放比例属性
 * 值越大，缩放越明显。为0.01时，基本无缩放
 * 默认值为1.5
 */
@property(assign,nonatomic)  CGFloat scaleChangeValue;

/**
 * 透明度改变比例
 * 值越大，透明度改变越明显。为0.01时，基本无改变
 * 默认值为1.5
 */
@property(assign,nonatomic)  CGFloat alphaChangeValue;

/** 
 * 代理（该功能暂未上线）
 * 预期通过该功能监听当前所选 cell 的点击事件
 */
@property(assign,nonatomic)  id<AZXMovingDelegate> movingDelegate;

@end
