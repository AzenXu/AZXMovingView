//
//  AZXBannerView.m
//  AZXMovingViewExample
//
//  Created by Azen Xu on 2018/4/25.
//  Copyright © 2018年 Azen.Xu. All rights reserved.
//

#import "AZXBannerView.h"
#import "AZXMovingViewLayout.h"

#define PlanSections 100

@interface AZXBannerView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) AZXMovingViewLayout *layout;
@property (nonatomic, assign) NSInteger currentPageIndex;

@end

@implementation AZXBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)setupUI
{
    [self addSubview:self.collectionView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addTimer];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:PlanSections / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    });
}

#pragma mark - private
// timer
- (void)addTimer
{
    [self removeTimer];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(_scrollToNextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)_scrollToNextPage
{
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:PlanSections/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == [self _itemCountFromDataSource]) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (NSInteger)_itemCountFromDataSource
{
    CGFloat itemCount = 0;
    if ([self.dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        itemCount = [self.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    }
    return itemCount;
}

#pragma mark - setter & getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"test222"];
        _collectionView.backgroundColor = [UIColor grayColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (AZXMovingViewLayout *)layout
{
    if (!_layout) {
        _layout = [AZXMovingViewLayout layoutWithItemSize:CGSizeMake(100, 100) minimumLineSpacing:10 alignmentType:(AZXMovingViewAlignmentTypeLeft)];
    }
    return _layout;
}

#pragma mark - delegate & datasource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.dataSource collectionView:self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return PlanSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self _itemCountFromDataSource];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [self.delegate collectionView:collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    }
}

#pragma mark - scroll
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger itemCount = [self _itemCountFromDataSource];
    if (itemCount > 0) {
        NSInteger page = (NSInteger)(scrollView.contentOffset.x /scrollView.frame.size.width + 0.5) % [self _itemCountFromDataSource];
        self.currentPageIndex = page;
    } else {
        self.currentPageIndex = 0;
    }
}


@end
