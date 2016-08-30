//
//  SuperAlertView.m
//  SuperAlertView
//
//  Created by ios-少帅 on 16/8/29.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "SuperAlertView.h"
#import "masonry.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define   SCREEN_WID    [UIScreen mainScreen].bounds.size.width
#define   SCREEN_HEIHTE [UIScreen mainScreen].bounds.size.height

CGFloat const  textfiledHight=35;//单个 textfiled 的高度定义

@interface SuperAlertView ()<UITextFieldDelegate>
{
    NSMutableArray * txStrArr;
    UIView * txView;
    NSInteger btTag;
}

@property (nonatomic,strong)UIView * bigView;



@end

@implementation SuperAlertView
-(instancetype)init
{

    self=[super init];
    if (self) {
        self.modalPresentationStyle=UIModalPresentationOverFullScreen;

    }
    return self;
}
#pragma makr - -文字 alertview 初始化
-(instancetype)initWithTitle:(NSString*)title message:(NSString*)message clickButtonTitle:(NSArray*)titles buttonClick:(SuperButtonClick)buttonIndexBlcok
{
    self=[super init];
    if (self) {
        WS(ws);
        _bigView=[[UIView alloc]init];
        _bigView.backgroundColor=[UIColor whiteColor];
        _bigView.layer.cornerRadius=5;
        _bigView.clipsToBounds=YES;

        [self.view addSubview:_bigView];
        [_bigView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(ws.view.mas_centerY).offset(-50);
            make.centerX.equalTo(ws.view.mas_centerX);
            make.left.equalTo(ws.view.mas_left).offset(30);
            make.right.equalTo(ws.view.mas_right).offset(-30);
            make.height.equalTo(@180);
        }];

        UILabel * titleLable=[[UILabel alloc]init];
        titleLable.textAlignment=NSTextAlignmentCenter;
        titleLable.text=title;
        [_bigView addSubview:titleLable];
        
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bigView.mas_top).offset(10);
            make.left.equalTo(_bigView.mas_left).offset(10);
            make.right.equalTo(_bigView.mas_right).offset(-10);
            make.height.equalTo([ws textHeightWithstr:title]);
        }];
        
        UILabel * messageTitle=[[UILabel alloc]init];
        messageTitle.text=message;
        messageTitle.layer.borderColor=[UIColor lightGrayColor].CGColor;
        messageTitle.layer.borderWidth=1;
       // messageTitle.userInteractionEnabled=NO;
        messageTitle.textAlignment=NSTextAlignmentCenter;
        [_bigView addSubview:messageTitle];
        [messageTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_bigView);
            make.left.equalTo(titleLable.mas_left);
            make.right.equalTo(titleLable.mas_right);
            make.height.equalTo(@90);
            
        }];
        
        self.superBtClick=^(NSInteger index){
            buttonIndexBlcok(index);
        };
        
        [self boomBarViewWithtitles:titles];

    }
    return self;
}
#pragma mark - - 根据标题创建 button
-(void)boomBarViewWithtitles:(NSArray*)arr
{
    
    NSMutableArray * viewArr=[[NSMutableArray alloc]initWithCapacity:0];
    [arr enumerateObjectsUsingBlock:^(NSString * btStr, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=idx;
        button.titleLabel.font=[UIFont systemFontOfSize:20];
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
         [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.backgroundColor=[UIColor whiteColor];
        [button setTitle:btStr forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bigView addSubview:button];
        [viewArr addObject:button];
        
    }];
    if (arr.count>1) {
        
        [viewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
        
        [viewArr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.bottom.equalTo(_bigView.mas_bottom);
        }];
        
    }else{
        UIButton * button=viewArr[0];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_bigView.mas_left);
            make.right.equalTo(_bigView.mas_right);
            make.bottom.equalTo(_bigView.mas_bottom);
            make.height.equalTo(@30);
            
        }];
        
    }
}
#pragma makr - -textfiled alertview 初始化

-(instancetype)initWithTitle:(NSString*)title message:(NSString*)message textfiled:(NSArray*)textFileds clickButtonTitle:(NSArray*)titles buttonClick:(SuperTextClick)buttonIndexBlcok
{
    self=[super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jianpanDown) name:UIKeyboardWillHideNotification object:nil];
       
        WS(ws);
        _bigView=[[UIView alloc]init];
        _bigView.backgroundColor=[UIColor whiteColor];
        _bigView.layer.cornerRadius=5;
        _bigView.clipsToBounds=YES;
        
        txStrArr=[[NSMutableArray alloc]initWithArray:textFileds];
        
        [self.view addSubview:_bigView];
        [_bigView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(ws.view.mas_centerY).offset(-50);
            make.centerX.equalTo(ws.view.mas_centerX);
            make.left.equalTo(ws.view.mas_left).offset(30);
            make.right.equalTo(ws.view.mas_right).offset(-30);
            make.height.equalTo([NSNumber numberWithInteger:textFileds.count*textfiledHight+textFileds.count-1+89+[[self textHeightWithstr:message] floatValue]]);
        }];
        
        
        UILabel * titleLable=[[UILabel alloc]init];
        titleLable.textAlignment=NSTextAlignmentCenter;
        titleLable.text=title;
        [_bigView addSubview:titleLable];
        
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bigView.mas_top).offset(10);
            make.left.equalTo(_bigView.mas_left).offset(10);
            make.right.equalTo(_bigView.mas_right).offset(-10);
            make.height.equalTo([ws textHeightWithstr:title]);
        }];
        
        UILabel * messageTitle=[[UILabel alloc]init];
        messageTitle.text=message;
        messageTitle.textAlignment=NSTextAlignmentCenter;
        [_bigView addSubview:messageTitle];
        [messageTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLable.mas_bottom);
            make.left.equalTo(titleLable.mas_left);
            make.right.equalTo(titleLable.mas_right);
            make.height.equalTo([self textHeightWithstr:message]);
            
        }];

        
        self.superTxClick=^(NSInteger index,NSMutableArray * arrStrs){
            buttonIndexBlcok(index,arrStrs);
        };
        
        [self boomBarViewWithtitles:titles];
        txView=[self textFiledViewWithtitles:textFileds];
        
        
        [txView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(messageTitle.mas_bottom).offset(10);
            make.left.equalTo(messageTitle.mas_left);
            make.right.equalTo(messageTitle.mas_right);
            make.height.equalTo([NSNumber numberWithInteger:textFileds.count*textfiledHight+textFileds.count-1]);
        }];

    }
    return self;

    
    
}
#pragma mark - - 根据标题创建 texefiled
-(UIView*)textFiledViewWithtitles:(NSArray*)placeTexts
{
    UIView * view=[[UIView alloc]init];
    view.backgroundColor=[UIColor redColor];
    [_bigView addSubview:view];
    NSMutableArray * viewArr=[[NSMutableArray alloc]initWithCapacity:0];
    [placeTexts enumerateObjectsUsingBlock:^(NSString * btStr, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UITextField * textfiled=[[UITextField alloc]init];
        textfiled.tag=idx;
        textfiled.placeholder=btStr;
        textfiled.delegate=self;
        textfiled.textAlignment=NSTextAlignmentCenter;
        textfiled.backgroundColor=[UIColor lightGrayColor];
        [view addSubview:textfiled];
        [viewArr addObject:textfiled];
        
    }];
    if (placeTexts.count>1) {
        
        
        [viewArr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
        
        [viewArr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left);
            make.right.equalTo(view.mas_right);
            make.height.equalTo([NSNumber numberWithFloat:textfiledHight]);
        }];
        
    }else{
        UITextField * textfiled=viewArr[0];
        [textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left);
            make.top.equalTo(view.mas_top);
            make.right.equalTo(view.mas_right);
            make.bottom.equalTo(view.mas_bottom);
            
        }];
        
    }
    
    
    
    return view;
    
    
}
-(void)buttonClick:(UIButton*)button
{
    if (txStrArr) {
        [self.view endEditing:YES];
        btTag=button.tag;


    }else{
        self.superBtClick(button.tag);


    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSNumber*)textHeightWithstr:(NSString*)str
{
    CGRect labelRect=[str boundingRectWithSize:CGSizeMake(SCREEN_WID-70,100) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}context:nil];
    
    return [NSNumber numberWithFloat:labelRect.size.height];
    
}
-(void)jianpanDown
{
    for (UITextField * textField in txView.subviews) {
        [txStrArr replaceObjectAtIndex:textField.tag withObject:textField.text];
        
    }
     self.superTxClick(btTag,txStrArr);

}

@end
