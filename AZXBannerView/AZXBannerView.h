//
//  AZXBannerView.h
//  AZXMovingViewExample
//
//  Created by Azen Xu on 2018/4/25.
//  Copyright © 2018年 Azen.Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZXBannerView : UIView

@property (nonatomic, assign, readonly) NSInteger currentPageIndex;
@property (nonatomic, strong) id<UICollectionViewDelegate> delegate;
@property (nonatomic, strong) id<UICollectionViewDataSource> dataSource;
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

@end
