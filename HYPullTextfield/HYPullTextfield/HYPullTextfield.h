//
//  HYPullTextfield.h
//  HYPullTextfield
//
//  Created by yanghaha on 15/8/6.
//  Copyright (c) 2015年 yanghaha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYPullTextfield;

@protocol HYPullTextfieldDelegate <NSObject>

/**
 *@brief 选中指定列数、行数的回调方法
 *@params row 指定行数 component 指定列数
 **/
- (void)pullTextfield:(HYPullTextfield *)pullTextfield didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

/**
 *@brief 文字类的下拉框设置
 *@params row 指定行数 component 指定列数
 @return 返回指定列数中行数里面的文字
 **/
- (NSString *)pullTextfield:(HYPullTextfield *)pullTextfield titleForRow:(NSInteger)row forComponent:(NSInteger)component;

@end

@protocol HYPullTextfieldDataSource <NSObject>

@required

/**
 *@brief 设置下拉框的列数
 *@return 返回要设置的指定列数
 **/
- (NSInteger)numberOfComponentsInPullTextfield:(HYPullTextfield *)pullTextfield;

/**
 *@brief 设置指定列数的行数
 *@params component 指定的列数
 *@return 返回要设置指定列数的行数
 **/
- (NSInteger)pullTextfield:(HYPullTextfield *)pullTextfield numberOfRowsInComponent:(NSInteger)component;


@end

@interface HYPullTextfield : UIView

@property (nonatomic, assign) id<HYPullTextfieldDataSource> dataSource;
@property (nonatomic, assign) id<HYPullTextfieldDelegate> delegate;

/**
 *@brief 下拉框输入内容
 **/
@property (nonatomic, copy) NSString *title;

/**
 *@brief 设置上下左右空隙
 **/
@property (nonatomic) UIEdgeInsets contentInset;

/**
 *@brief 下拉按钮的size
 **/
@property (nonatomic) CGSize accessorySize;

/**
 *@brief 下拉按钮的默认图片
 **/
@property (nonatomic, strong) UIImage *image;

/**
 *@brief 输入框
 **/
@property (nonatomic, strong, readonly) UITextField *inputTextField;

/**
 *@breief 设置picker背景颜色
 **/
@property (nonatomic,strong) UIColor *pullBackgroundColor;

@end
