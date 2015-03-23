//
//  LSConstraint.h
//  SizeClass
//
//  Created by liushuang on 15-3-9.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LSConstraint : NSObject


@property (nonatomic, strong) UIView *item;
@property (nonatomic, assign) NSLayoutAttribute attribute;
@property (nonatomic, assign) CGFloat multiplier;
@property (nonatomic, assign) BOOL unusedMultiple;
@property (nonatomic, assign) CGFloat constant;
@property (nonatomic, strong) NSLayoutConstraint *layoutConstraint;

@property (nonatomic, strong) NSMutableArray *constraints;
@property (nonatomic, strong) LSConstraint *superconstraint;

-(LSConstraint * (^)(LSConstraint *con))equalTo;
-(LSConstraint * (^)(CGFloat offset))offset;
-(LSConstraint * (^)(CGFloat offset))multipliedBy;
-(LSConstraint * (^)(BOOL usedefault))unusedDefault;




@end
