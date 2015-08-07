//
//  AZXMovingViewLayout.m
//  Proj_UICollectionView布局
//
//  Created by Azen.Xu on 15/8/6.
//  Copyright (c) 2015年 Azen.Xu. All rights reserved.
//

#import "AZXMovingViewLayout.h"
#import "AZXMovingView.h"

@interface AZXMovingViewLayout ()

@property(weak,nonatomic) AZXMovingView *movingView;

@end


@implementation AZXMovingViewLayout

+ (instancetype)layoutWithItemSize :(CGSize)size minimumLineSpacing :(CGFloat)spacing
{
    AZXMovingViewLayout *layout = [[AZXMovingViewLayout alloc] init];
    //  滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //  cell 尺寸
    layout.itemSize = size;
    //  水平居中显示
    layout.minimumInteritemSpacing = MAXFLOAT;
    //  图片间距
    layout.minimumLineSpacing = spacing;

    return layout;
}


#pragma mark --内部属性 get 方法
- (AZXMovingView *)movingView
{
    AZXMovingView *movingView = (AZXMovingView *)self.collectionView;
    return movingView;
}

#pragma mark --父类方法重写
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //  调用父类方法获得流水排布 attributes 计算值数组
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    //  找到 collection 中心线
    CGFloat centerPointX = self.collectionView.frame.size.width * 0.5;
    //  遍历 cell 根据距中心线距离调整尺寸&透明度
    for (int i = 0 ; i < array.count; i++) {
        UICollectionViewLayoutAttributes *attribute = array[i];
        CGFloat itemPointX = attribute.center.x - self.collectionView.contentOffset.x;
        CGFloat distance = itemPointX - centerPointX;
        //  调整缩放比例
        CGFloat scale = (1 - ABS(distance / [UIScreen mainScreen].bounds.size.width * self.movingView.scaleChangeValue)) ;
//        CGFloat scale = ABS();
        attribute.transform = CGAffineTransformMakeScale(scale, scale);
        //  调整 aplha 变化比例
        attribute.alpha = 1 - self.movingView.alphaChangeValue * ABS(distance / [UIScreen mainScreen].bounds.size.width);
    }
    
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //  计算默认结束 Rect
    CGRect rect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.movingView.bounds.size.width, self.movingView.bounds.size.height);
    //  获得默认结束 attributes 数组
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    //  默认结束中心线位置
    CGFloat centerPointX = self.collectionView.frame.size.width * 0.5 + proposedContentOffset.x;
    //  计算最近 cell 距中心线的距离
    CGFloat min = CGFLOAT_MAX;
    for (int i = 0; i < array.count; i++) {
        UICollectionViewLayoutAttributes *attribute = array[i];
        CGFloat itemPointX = attribute.center.x;
        CGFloat distance = itemPointX - centerPointX;
        min = ABS(distance) < ABS(min) ? distance : min;
    }
    //  获取偏移量修正值
    CGFloat x = proposedContentOffset.x + min;
    return CGPointMake(x, 0);
}

- (void)prepareLayout
{
    //  调整首图显示模式为居中显示
    CGFloat length = (self.collectionView.bounds.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, length, 0, length);
}

@end

