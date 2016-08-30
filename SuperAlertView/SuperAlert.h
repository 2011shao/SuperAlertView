//
//  SuperAlert.h
//  SuperAlertView
//
//  Created by ios-少帅 on 16/8/30.
//  Copyright © 2016年 ios-shaoshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SuperButtonClick)(NSInteger btIndex);
typedef void(^SuperTextClick)(NSInteger btIndex,NSMutableArray * strArr);




@interface SuperAlert : UIView
@property(nonatomic,assign)id/*<superAlertDelegate *>*/delegate;

@property (nonatomic,copy)SuperButtonClick superBtClick;
@property (nonatomic,copy)SuperTextClick superTxClick;
/**
 * 普通 AlterView
 */
-(instancetype)initWithTitle:(NSString*)title message:(NSString*)message clickButtonTitle:(NSArray*)titles buttonClick:(SuperButtonClick)buttonIndexBlcok delegate:(id)delegate;

/**
 *  输入框 AlterView
 */
-(instancetype)initWithTitle:(NSString*)title message:(NSString*)message textfiled:(NSArray*)textFileds clickButtonTitle:(NSArray*)titles buttonClick:(SuperTextClick)buttonIndexBlcok delegate:(id)delegate;

-(void)shown;

@end
@protocol superAlertDelegate <NSObject>
@optional

-(void)superAlertView:(SuperAlert*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;


@end