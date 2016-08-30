//
//  SuperAlertView.h
//  SuperAlertView
//
//  Created by ios-少帅 on 16/8/29.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SuperButtonClick)(NSInteger btIndex);
typedef void(^SuperTextClick)(NSInteger btIndex,NSMutableArray * strArr);


@interface SuperAlertView : UIViewController

@property (nonatomic,copy)SuperButtonClick superBtClick;

@property (nonatomic,copy)SuperTextClick superTxClick;




/**
 *  一般的alterview
 */
-(instancetype)initWithTitle:(NSString*)title message:(NSString*)message clickButtonTitle:(NSArray*)titles buttonClick:(SuperButtonClick)buttonIndexBlcok;

/**
 *  带有textfiled的alterview
 */
-(instancetype)initWithTitle:(NSString*)title message:(NSString*)message textfiled:(NSArray*)textFileds clickButtonTitle:(NSArray*)titles buttonClick:(SuperTextClick)buttonIndexBlcok;

@end
