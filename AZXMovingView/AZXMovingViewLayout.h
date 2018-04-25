//
//  AZXMovingViewLayout.h
//  Proj_UICollectionView布局
//
//  Created by Azen.Xu on 15/8/6.
//  Copyright (c) 2015年 Azen.Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AZXMovingViewAlignmentType) {
    AZXMovingViewAlignmentTypeLeft,
    AZXMovingViewAlignmentTypeCenter
};

@interface AZXMovingViewLayout : UICollectionViewFlowLayout

+ (instancetype)layoutWithItemSize :(CGSize)size minimumLineSpacing :(CGFloat)spacing;
+ (instancetype)layoutWithItemSize :(CGSize)size minimumLineSpacing :(CGFloat)spacing alignmentType: (AZXMovingViewAlignmentType)type;

@end
