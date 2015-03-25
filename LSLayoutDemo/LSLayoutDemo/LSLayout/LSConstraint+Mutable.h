//
//  LSConstraint+Mutable.h
//  SizeClass
//
//  Created by liushuang on 15-3-19.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import "LSConstraint.h"

@interface LSConstraint (Mutable)
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


-(LSConstraint * (^)(NSNumber *, ...))mutableoffset;

@end
