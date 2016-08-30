//
//  SuperAlert.m
//  SuperAlertView
//
//  Created by ios-少帅 on 16/8/30.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import "SuperAlert.h"
#import "masonry.h"
//*********单个 textfiled 的高度定义**********
#define  textfiledHight 30

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define HightligntColor RGBA(226, 226, 226, 1.0)//

#define   SCREEN_WID    [UIScreen mainScreen].bounds.size.width
#define   SCREEN_HEIHTE [UIScreen mainScreen].bounds.size.height

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//CGFloat const  textfiledHight=35;//单个 textfiled 的高度定义

@interface SuperAlert()

{
    NSMutableArray * txStrArr;
    NSInteger btTag;
    CGFloat tfHight;
    
}

@property (nonatomic,strong)UIView * bigView;


@end

@implementation SuperAlert

//*********************普通的 alertview 的初始化方法*****************//
-(instancetype)initWithTitle:(NSString*)title message:(NSString*)message clickButtonTitle:(NSArray*)titles buttonClick:(SuperButtonClick)buttonIndexBlcok delegate:(id)delegate;
{
    self=[super init];
    if (self) {
        
        _delegate=delegate;
        self.backgroundColor=RGBA(226, 226, 226, 0.5);
        self.frame=CGRectMake(0, 0, SCREEN_WID, SCREEN_HEIHTE);
        
        CGPoint center=CGPointMake(SCREEN_WID/2, SCREEN_HEIHTE/2);
        
        _bigView=[[UIView alloc]initWithFrame:CGRectMake(50, center.y-136, (SCREEN_WID-100), 176)];
        
        _bigView.layer.cornerRadius=5;
        _bigView.clipsToBounds=YES;
        
        _bigView.backgroundColor=[UIColor whiteColor];
        self.alpha=0;
        
        
        [self addSubview:_bigView];
        
        
        UILabel * titleLable=[[UILabel alloc]init];
        titleLable.textAlignment=NSTextAlignmentCenter;
        titleLable.text=title;
        titleLable.font=[UIFont systemFontOfSize:15];
        [_bigView  addSubview:titleLable];
        
        UILabel * messageTitle=[[UILabel alloc]init];
        messageTitle.text=message;
        messageTitle.font=[UIFont systemFontOfSize:15];
        messageTitle.textAlignment=NSTextAlignmentCenter;
        [_bigView  addSubview:messageTitle];
        
        self.superBtClick=^(NSInteger index){
            buttonIndexBlcok(index);
        };
        
        [self boomBarViewWithtitles:titles];
        
        
        titleLable.frame=CGRectMake(10, 0, _bigView.frame.size.width-20, 35);
        messageTitle.frame=CGRectMake(10, 36, _bigView.frame.size.width-20,100);
        
        
    }
    return self;
}
#pragma mark - - 根据标题创建 button
-(void)boomBarViewWithtitles:(NSArray*)arr
{
    
    [arr enumerateObjectsUsingBlock:^(NSString * btStr, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=idx;
        
        button.titleLabel.font=[UIFont systemFontOfSize:20];
        button.titleLabel.textAlignment=NSTextAlignmentCenter;
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.backgroundColor=HightligntColor;
        [button setTitle:btStr forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bigView  addSubview:button];
        
        CGFloat btY=txStrArr ? 36+tfHight+textfiledHight*txStrArr.count+(txStrArr.count-1)*2 :136;
            if (arr.count>1) {
                button.frame=CGRectMake(idx*(_bigView.frame.size.width*0.5+1), btY+2, _bigView.frame.size.width*0.5, 40);
            }else{
                button.frame=CGRectMake(0, btY+2, _bigView.frame.size.width, 40);
            }

        
        
        
    }];
    
    
    
    
}
-(CGFloat)textHeightWithstr:(NSString*)str
{
    CGRect labelRect=[str boundingRectWithSize:CGSizeMake(SCREEN_WID-70,100) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}context:nil];
    
    return labelRect.size.height;
    
}
#pragma mark - - button 被点击的方法
-(void)buttonClick:(UIButton*)button
{
    if (txStrArr) {
        [self endEditing:YES];
        btTag=button.tag;
        
        
    }else{
        self.superBtClick(button.tag);
        
        
    }
    
    //协议的方法
    [_delegate superAlertView:self clickedButtonAtIndex:button.tag];
    
    [UIView animateWithDuration:0.3 animations:^{
        //self.frame=CGRectMake(50, -176, (SCREEN_WID-100), 176);
        self.alpha=0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}
#pragma mark - - 展示 alertview
-(void)shown
{
    UIWindow * window=[UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self];
    // CGPoint center=CGPointMake(SCREEN_WID/2, SCREEN_HEIHTE/2);
    
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha=1;
        
        
    }];
    
}

//********************输入框的 alertview 的初始化方法***********
-(instancetype)initWithTitle:(NSString*)title message:(NSString*)message textfiled:(NSArray*)textFileds clickButtonTitle:(NSArray*)titles buttonClick:(SuperTextClick)buttonIndexBlcok delegate:(id)delegate;
{
    self=[super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jianpanDown) name:UIKeyboardWillHideNotification object:nil];
        //1注册通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyBoardUpDown:) name:UIKeyboardWillChangeFrameNotification object:nil];
        _delegate=delegate;

        txStrArr=[[NSMutableArray alloc]initWithArray:textFileds];
        tfHight=message ? [self textHeightWithstr:message] :0;

        
        self.backgroundColor=RGBA(226, 226, 226, 0.5);
        self.frame=CGRectMake(0, 0, SCREEN_WID, SCREEN_HEIHTE);
        
        CGPoint center=CGPointMake(SCREEN_WID/2, SCREEN_HEIHTE/2);
        
        _bigView=[[UIView alloc]initWithFrame:CGRectMake(50, center.y-136, (SCREEN_WID-100), 36+tfHight+textfiledHight*txStrArr.count+(txStrArr.count-1)*2+42)];
        
       
        _bigView.layer.cornerRadius=5;
        _bigView.clipsToBounds=YES;
        
        _bigView.backgroundColor=[UIColor whiteColor];
        self.alpha=0;
        
        
        [self addSubview:_bigView];
        
        
        UILabel * titleLable=[[UILabel alloc]init];
        titleLable.textAlignment=NSTextAlignmentCenter;
        titleLable.text=title;
        titleLable.font=[UIFont systemFontOfSize:15];
        [_bigView  addSubview:titleLable];
        
        UILabel * messageTitle=[[UILabel alloc]init];
        messageTitle.text=message;
        messageTitle.font=[UIFont systemFontOfSize:15];
        messageTitle.textAlignment=NSTextAlignmentCenter;
        [_bigView  addSubview:messageTitle];
        
        
        titleLable.frame=CGRectMake(10, 0, _bigView.frame.size.width-20, 35);
        messageTitle.frame=CGRectMake(10, 36, _bigView.frame.size.width-20,tfHight);
        
        
        
        self.superTxClick=^(NSInteger index,NSMutableArray * arrStrs){
            buttonIndexBlcok(index,arrStrs);
        };
        
        [self boomBarViewWithtitles:titles];
       [self textFiledViewWithtitles:textFileds];
        
        
        
        
    }
    return self;
    
    
    
}
#pragma mark - - 根据标题创建 texefiled的属性设置
-(void)textFiledViewWithtitles:(NSArray*)placeTexts
{
    
    [placeTexts enumerateObjectsUsingBlock:^(NSString * btStr, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UITextField * textfiled=[[UITextField alloc]init];
        textfiled.tag=idx;
        textfiled.placeholder=btStr;
        textfiled.textAlignment=NSTextAlignmentCenter;
        textfiled.backgroundColor=HightligntColor;
        [_bigView addSubview:textfiled];
        

      textfiled.frame=CGRectMake(10, 36+tfHight+(textfiledHight+2)*idx, _bigView.frame.size.width-20, textfiledHight);
        
        
    }];
    

    
    
}

-(void)jianpanDown
{
    for (UITextField * textField in _bigView.subviews) {
        if ([textField isKindOfClass:[UITextField class]]) {
             [txStrArr replaceObjectAtIndex:textField.tag withObject:textField.text];
        }
       
    }
    self.superTxClick(btTag,txStrArr);
    
}
//----------------

//2通知调用的方法
-(void)KeyBoardUpDown:(NSNotification*)tongzhi
{
    //moveview为输入框所在的底试图
    [self jianpandonghuaWithtongzhicanshu:tongzhi moveView:_bigView];
}
//键盘上升下落的方法
-(CGRect)jianpandonghuaWithtongzhicanshu:(NSNotification*)tongzhi moveView:(UIView*)moveView
//currSelf:(id)delegateSelf
{
    NSValue * frameRect=tongzhi.userInfo[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rectFrame=[frameRect CGRectValue];
    
    float yanshi=[tongzhi.userInfo[ UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    
    int donghuaquxian=[tongzhi.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    for(UITextField * textView in _bigView.subviews)
    {
        
        if (textView.isEditing)
        {
            
            
            
            CGFloat myheight=(_bigView.frame.origin.y+_bigView.frame.size.height)-rectFrame.origin.y;
            CGRect  mysize=[UIScreen mainScreen].bounds;
            
            
            if (myheight>0)
            {
                
                
                [UIView animateWithDuration:yanshi animations:^{
                    
                    [UIView setAnimationCurve:donghuaquxian];
                    
                    
                    _bigView.frame=CGRectMake(_bigView.frame.origin.x, _bigView.frame.origin.y-20, _bigView.frame.size.width, _bigView.frame.size.height);
                    
                }];
                
                
            }
            if (rectFrame.origin.y==mysize.size.height)
            {
                
                
                [UIView animateWithDuration:yanshi animations:^{
                    
                    [UIView setAnimationCurve:donghuaquxian];
                    
                    
                    _bigView.frame=CGRectMake(_bigView.frame.origin.x, _bigView.frame.origin.y+20, _bigView.frame.size.width, _bigView.frame.size.height);
                    
                }];
            }
            
        }
    }
    
    return rectFrame;
}

@end
