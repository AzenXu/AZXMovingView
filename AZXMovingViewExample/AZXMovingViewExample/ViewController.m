//
//  ViewController.m
//  AZXMovingViewExample
//
//  Created by Azen.Xu on 15/8/7.
//  Copyright (c) 2015年 Azen.Xu. All rights reserved.
//

#import "ViewController.h"
#import "AZXMovingView.h"
#import "AZXMovingViewLayout.h"
#import "AZXBannerView.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) AZXBannerView *bannerView;

@end

@implementation ViewController

- (NSArray *)imageArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 35; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [array addObject:image];
    }
    return array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //  创建控件
    AZXMovingView *movingView = [[AZXMovingView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    //  添加控件
    [self.view addSubview:movingView];
    //  传入图片数组
    movingView.imageArray = self.imageArray;
    //  设置图片尺寸
    UIImage *image = self.imageArray.lastObject;
    movingView.imageSize = image.size;
    movingView.scaleChangeValue = 1;
    movingView.imageMargin = 10;
    
    [self.view addSubview:self.collectionView];
    
    //  banner view
    self.bannerView.frame = CGRectMake(0, 400, 375, 200);
    [self.view addSubview:self.bannerView];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]  initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 100) collectionViewLayout:[AZXMovingViewLayout layoutWithItemSize:CGSizeMake(100, 100) minimumLineSpacing:10 alignmentType:(AZXMovingViewAlignmentTypeCenter)]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"test"];
    }
    return _collectionView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
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

- (AZXBannerView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[AZXBannerView alloc] init];
        _bannerView.backgroundColor = [UIColor greenColor];
    }
    return _bannerView;
}

@end
