//
//  ViewController.m
//  DDTextView
//
//  Created by Milo. on 15/7/22.
//  Copyright (c) 2015年 milodongg. All rights reserved.
//

#import "ViewController.h"
#import "EHTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EHTextView *myView = [[EHTextView alloc] initWithFrame:CGRectMake(16, 20, self.view.frame.size.width - 32, 100) addText:@"Open your misty eyes\n拨开笼罩的迷雾\nHere comes another fight\n新的战役将要开始\nThere's a stormy night\n还有一场腥风血雨之夜\nBefore the morning arrives\n在天亮以前\nNo matter where you go \n无论你去往哪里\nI will follow you\n我都会跟随\nKeep careful watch of your soul\n紧紧守护你的灵魂 " addRowHeight:40];
    //    myView.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:myView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
