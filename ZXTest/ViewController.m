//
//  ViewController.m
//  ZXTest
//
//  Created by macmini on 16/2/3.
//  Copyright © 2016年 macmini. All rights reserved.
//
#define  kScreenWidth    [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "TopView.h"

CGFloat const kTopViewHeight = 200.0f;


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TopView *topView = [[TopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopViewHeight)];
    NSArray *imageArray = @[@"http://www.ppt123.net/beijing/uploadfiles_8374/201203/2012032517501327.jpg", @"http://pic13.nipic.com/20110415/1347158_132411659346_2.jpg",@"http://pic25.nipic.com/20121126/8305779_171431388000_2.jpg",@"http://pic2.ooopic.com/01/03/51/25b1OOOPIC19.jpg",@"http://www.ppt123.net/beijing/UploadFiles_8374/201601/2016010718311175.jpg"];
    topView.imgArrs = imageArray;
    [self.view addSubview:topView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
