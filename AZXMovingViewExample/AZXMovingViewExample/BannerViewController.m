//
//  BannerViewController.m
//  AZXMovingViewExample
//
//  Created by Azen Xu on 2018/4/25.
//  Copyright © 2018年 Azen.Xu. All rights reserved.
//

#import "BannerViewController.h"
#import "AZXBannerView.h"

@interface BannerViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) AZXBannerView *bannerView;

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.bannerView.frame = CGRectMake(0, 0, 375, 200);
    [self.view addSubview:self.bannerView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"蛤蛤蛤");
}

- (AZXBannerView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[AZXBannerView alloc] init];
        _bannerView.backgroundColor = [UIColor greenColor];
        _bannerView.dataSource = self;
        _bannerView.delegate = self;
        [_bannerView.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    }
    return _bannerView;
}

@end
