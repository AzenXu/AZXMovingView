//
//  CollectionViewCell.m
//  Proj_UICollectionView布局
//
//  Created by Azen.Xu on 15/8/7.
//  Copyright (c) 2015年 Azen.Xu. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _imageView;
}

- (void)layoutSubviews
{
    self.backgroundColor = [UIColor greenColor];
    self.imageView.bounds = self.bounds;
    self.imageView.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    [super layoutSubviews];
    
    [self addSubview:self.imageView];
}

@end
