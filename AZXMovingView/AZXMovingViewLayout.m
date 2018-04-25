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
@property (nonatomic, assign) AZXMovingViewAlignmentType alignmentType;

@end


@implementation AZXMovingViewLayout

+ (instancetype)layoutWithItemSize :(CGSize)size minimumLineSpacing :(CGFloat)spacing
{
    return [self layoutWithItemSize:size minimumLineSpacing:spacing alignmentType:(AZXMovingViewAlignmentTypeCenter)];
}

+ (instancetype)layoutWithItemSize :(CGSize)size minimumLineSpacing :(CGFloat)spacing alignmentType: (AZXMovingViewAlignmentType)type
{
    AZXMovingViewLayout *layout = [[AZXMovingViewLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = size;
    layout.minimumInteritemSpacing = MAXFLOAT;
    layout.minimumLineSpacing = spacing;
    layout.alignmentType = type;
    return layout;
}

- (AZXMovingView *)movingView
{
    AZXMovingView *movingView = (AZXMovingView *)self.collectionView;
    return movingView;
}

#pragma mark - over write functions
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    //  若居中对齐，则根据配置变更透明度、缩放
    if (self.alignmentType == AZXMovingViewAlignmentTypeCenter) {
        CGFloat centerPointX = self.collectionView.frame.size.width * 0.5;
        [self _changeAlphaAndScalForAttributes:array defaultOffset:centerPointX];
    }
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGPoint resultContentOffset = [self _caculateFinialContentOffsetForProposedContentOffset:proposedContentOffset];
    return resultContentOffset;
}

- (void)prepareLayout
{
    switch (self.alignmentType) {
        case AZXMovingViewAlignmentTypeCenter:
            [self _moveFirtItemToCenter];
            break;
        case AZXMovingViewAlignmentTypeLeft:
            // do nothing
            break;
        default:
            break;
    }
}

#pragma mark - private functions
- (CGPoint)_caculateFinialContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
{
    CGPoint finialPoint = CGPointZero;
    switch (self.alignmentType) {
        case AZXMovingViewAlignmentTypeCenter:
            finialPoint = [self _caculateCenterAlignmentContentOffsetForProposedContentOffset:proposedContentOffset];
            break;
        case AZXMovingViewAlignmentTypeLeft:
            finialPoint = [self _caculateLeftAlignmentContentOffsetForProposedContentOffset:proposedContentOffset];
            break;
        default:
            break;
    }
    return finialPoint;
}

- (CGPoint)_caculateCenterAlignmentContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
{
    //  获取默认布局对象们
    NSArray *elements = [self _attributesFromPropsedContentOffset:proposedContentOffset];
    //  默认结束中心线位置
    CGFloat centerPointX = self.collectionView.frame.size.width * 0.5 + proposedContentOffset.x;
    //  计算最近 cell 距中心线的距离
    CGFloat min = CGFLOAT_MAX;
    for (int i = 0; i < elements.count; i++) {
        UICollectionViewLayoutAttributes *attribute = elements[i];
        CGFloat itemPointX = attribute.center.x;
        CGFloat distance = itemPointX - centerPointX;
        min = ABS(distance) < ABS(min) ? distance : min;
    }
    //  获取偏移量修正值
    CGFloat x = proposedContentOffset.x + min;
    return CGPointMake(x, 0);
}

- (CGPoint)_caculateLeftAlignmentContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
{
    //  获取默认布局对象们
    NSArray *elements = [self _attributesFromPropsedContentOffset:proposedContentOffset];
    //  默认结束offset
    CGFloat leftPointX = self.collectionView.frame.origin.x + proposedContentOffset.x;
    //  计算最近 cell 距中心线的距离
    CGFloat min = CGFLOAT_MAX;
    for (int i = 0; i < elements.count; i++) {
        UICollectionViewLayoutAttributes *attribute = elements[i];
        CGFloat itemPointX = attribute.frame.origin.x;
        CGFloat distance = itemPointX - leftPointX;
        min = ABS(distance) < ABS(min) ? distance : min;
    }
    //  获取偏移量修正值
    CGFloat x = proposedContentOffset.x + min;
    return CGPointMake(x, 0);
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)_attributesFromPropsedContentOffset:(CGPoint)proposedContentOffset
{
    CGRect rect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.movingView.bounds.size.width, self.movingView.bounds.size.height);
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    return attributes;
}

- (void)_changeAlphaAndScalForAttributes:(NSArray *)attrbutes defaultOffset:(CGFloat)defaultOffset
{
    //  遍历 cell 根据距中心线距离调整尺寸&透明度
    for (int i = 0 ; i < attrbutes.count; i++) {
        UICollectionViewLayoutAttributes *attribute = attrbutes[i];
        CGFloat itemPointX = attribute.center.x - self.collectionView.contentOffset.x;
        CGFloat distance = itemPointX - defaultOffset;
        //  调整缩放比例
        if ([self.movingView respondsToSelector:@selector(scaleChangeValue)]) {
            CGFloat scale = (1 - ABS(distance / [UIScreen mainScreen].bounds.size.width * self.movingView.scaleChangeValue)) ;
            //        CGFloat scale = ABS();
            attribute.transform = CGAffineTransformMakeScale(scale, scale);
        }
        //  调整 aplha 变化比例
        if ([self.movingView respondsToSelector:@selector(alphaChangeValue)]) {
            attribute.alpha = 1 - self.movingView.alphaChangeValue * ABS(distance / [UIScreen mainScreen].bounds.size.width);
        }
    }
}

- (void)_moveFirtItemToCenter
{
    //  调整首图显示模式为居中显示
    CGFloat length = (self.collectionView.bounds.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, length, 0, length);
}

@end
