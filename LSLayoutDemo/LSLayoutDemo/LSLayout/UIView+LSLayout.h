//
//  UIView+LSLayout.h
//  SizeClass
//
//  Created by liushuang on 15-3-9.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSConstraint.h"
#import "LSConstraint+Mutable.h"

@interface UIView (LSLayout)

-(LSConstraint * (^)(NSLayoutAttribute attribute) )constraint;

@property (nonatomic, strong) LSConstraint *left;
@property (nonatomic, strong) LSConstraint *right;
@property (nonatomic, strong) LSConstraint *top;
@property (nonatomic, strong) LSConstraint *bottom;
@property (nonatomic, strong) LSConstraint *leading;
@property (nonatomic, strong) LSConstraint *trailing;
@property (nonatomic, strong) LSConstraint *width;
@property (nonatomic, strong) LSConstraint *height;
@property (nonatomic, strong) LSConstraint *centerX;
@property (nonatomic, strong) LSConstraint *centerY;
@property (nonatomic, strong) LSConstraint *baseline;
@property (nonatomic, strong) LSConstraint *center;

-(void (^)(CGFloat x ,CGFloat y) )origin;
//设置宽高
-(void (^)(CGFloat with ,CGFloat heigh) )size;
-(void (^)(UIView *view))WHequalTo;

//设置相对于父控件的边距
-(void (^)(CGFloat top ,CGFloat left,CGFloat bottom ,CGFloat right) )edge;

//对齐
-(void (^)(UIView *view) )topAlignBy;
-(void (^)(UIView *view) )leftAlignBy;
-(void (^)(UIView *view) )rightAlignBy;
-(void (^)(UIView *view) )bottomAlignBy;

//间距
-(void (^)(UIView *view,CGFloat spacing) )topSpacingBy;
-(void (^)(UIView *view,CGFloat spacing) )leftSpacingBy;
-(void (^)(UIView *view,CGFloat spacing) )rightSpacingBy;
-(void (^)(UIView *view,CGFloat spacing) )bottomSpacingBy;

-(NSLayoutConstraint *)constraint:(NSLayoutAttribute)attribute;
-(void)resetConstraint:(NSLayoutAttribute)attribute constant:(CGFloat)constant;

@end
