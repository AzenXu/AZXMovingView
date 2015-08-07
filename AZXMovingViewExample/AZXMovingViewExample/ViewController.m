//
//  ViewController.m
//  AZXMovingViewExample
//
//  Created by Azen.Xu on 15/8/7.
//  Copyright (c) 2015年 Azen.Xu. All rights reserved.
//

#import "ViewController.h"
#import "AZXMovingView.h"

@interface ViewController ()

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
