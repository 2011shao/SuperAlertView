//
//  ViewController.m
//  SuperAlertView
//
//  Created by ios-少帅 on 16/8/29.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "ViewController.h"
#import "SuperAlertView.h"
#import "SuperAlert.h"
@interface ViewController() <superAlertDelegate>
#define MYWINDOWN      [UIApplication sharedApplication].keyWindow
{
    SuperAlert * view;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blueColor];
    
   view=[[SuperAlert alloc]initWithTitle:@"温馨提示" message:@"网络连接错误请重试" clickButtonTitle:@[@"确定",@"取消"] buttonClick:^(NSInteger btIndex) {
       NSLog(@"%ld",(long)btIndex);

   } delegate:self];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [view shown];
}
-(void)superAlertView:(SuperAlert *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"%ld",(long)buttonIndex);

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
