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
    
    view=[[SuperAlert alloc]initWithTitle:@"温馨提示" message:nil textfiled:@[@"名字",@"电话"] clickButtonTitle:@[@"取消",@"确定"] buttonClick:^(NSInteger btIndex, NSMutableArray *strArr) {
        NSLog(@"%ld,%@",(long)btIndex,strArr);
        
    } delegate:nil];
    
    
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
