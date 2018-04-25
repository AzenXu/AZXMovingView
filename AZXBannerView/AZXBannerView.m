//
//  AZXBannerView.m
//  AZXMovingViewExample
//
//  Created by Azen Xu on 2018/4/25.
//  Copyright © 2018年 Azen.Xu. All rights reserved.
//

#import "AZXBannerView.h"
#import "AZXMovingViewLayout.h"

@interface AZXBannerView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) AZXMovingViewLayout *layout;

@end

@implementation AZXBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"test222" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
@end
