//
//  AZXMovingView.m
//  Proj_UICollectionView布局
//
//  Created by Azen.Xu on 15/8/6.
//  Copyright (c) 2015年 Azen.Xu. All rights reserved.
//

#import "AZXMovingView.h"
#import "AZXMovingViewLayout.h"
#import "CollectionViewCell.h"

@interface AZXMovingView ()<UICollectionViewDataSource,UICollectionViewDelegate>


@end

@implementation AZXMovingView

static NSString *ID = @"cell";

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame collectionViewLayout:[AZXMovingViewLayout layoutWithItemSize:self.imageSize minimumLineSpacing:self.imageMargin]]) {
        self.dataSource = self;
        [self registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:ID];
    }
    return self;
}

#pragma mark --重写 set 及 get 方法
- (void)setImageMargin:(CGFloat)imageMargin
{
    _imageMargin = imageMargin;
    [self setCollectionViewLayout:[AZXMovingViewLayout layoutWithItemSize:self.imageSize minimumLineSpacing:self.imageMargin]];
}
- (void)setImageSize:(CGSize)imageSize
{
    _imageSize = imageSize;
    [self setCollectionViewLayout:[AZXMovingViewLayout layoutWithItemSize:self.imageSize minimumLineSpacing:self.imageMargin]];
}
- (void)setScaleChangeValue:(CGFloat)scaleChangeValue
{
    _scaleChangeValue = scaleChangeValue;
    [self setCollectionViewLayout:[AZXMovingViewLayout layoutWithItemSize:self.imageSize minimumLineSpacing:self.imageMargin]];
}
- (void)setAlphaChangeValue:(CGFloat)alphaChangeValue
{
    _alphaChangeValue = alphaChangeValue;
    [self setCollectionViewLayout:[AZXMovingViewLayout layoutWithItemSize:self.imageSize minimumLineSpacing:self.imageMargin]];
}
- (CGSize)imageSize
{
    if ([NSStringFromCGSize(_imageSize) isEqualToString:NSStringFromCGSize(CGSizeZero)]) {
        _imageSize = CGSizeMake(50, 50);
    }
    return _imageSize;
}
- (CGFloat)scaleChangeValue
{
    if (_scaleChangeValue == 0) {
        _scaleChangeValue = 1.5;
    }
    return _scaleChangeValue;
}
- (CGFloat)imageMargin
{
    if (_imageMargin == 0) {
        _imageMargin = 50;
    }
    return _imageMargin;
}
- (CGFloat)alphaChangeValue
{
    if (_alphaChangeValue == 0) {
        _alphaChangeValue = 1.5;
    }
    return _alphaChangeValue;
}


#pragma mark --数据源方法
//  设置 cell 个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}
//  数据源方法设置 cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //  取出 cell设置 boundes
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    cell.bounds = CGRectMake(0, 0, self.imageSize.width, self.imageSize.height);
    cell.imageView.image = self.imageArray[indexPath.row];
    NSLog(@"%@",cell.imageView);
    return cell;
}

#pragma mark --重写敏感方法
- (void)setDataSource:(id<UICollectionViewDataSource>)dataSource
{
    [super setDataSource:self];
}
- (void)setDelegate:(id<UICollectionViewDelegate>)delegate
{
    self.movingDelegate = (id<AZXMovingDelegate>)delegate;
    [super setDataSource:self];
}


@end
