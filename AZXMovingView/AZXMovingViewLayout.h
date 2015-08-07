//
//  AZXMovingViewLayout.h
//  Proj_UICollectionView布局
//
//  Created by Azen.Xu on 15/8/6.
//  Copyright (c) 2015年 Azen.Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZXMovingViewLayout : UICollectionViewFlowLayout

+ (instancetype)layoutWithItemSize :(CGSize)size minimumLineSpacing :(CGFloat)spacing;

@end
