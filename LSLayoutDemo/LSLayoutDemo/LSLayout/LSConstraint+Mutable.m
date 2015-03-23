//
//  LSConstraint+Mutable.m
//  SizeClass
//
//  Created by liushuang on 15-3-19.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import "LSConstraint+Mutable.h"


@implementation LSConstraint (Mutable)

//NSInteger应该用CGFloat
-(LSConstraint *(^)(NSInteger, ...))mutableoffset
{
    return ^ LSConstraint *(NSInteger  off, ...)
    {
        int i = 1;
        CGFloat  args;
        va_list list;
        //取得第一个参数的值
        LSConstraint *con =  self.constraints[i-1];
        con.constant = off;
        
        va_start(list, off);
        do {
            
            args = va_arg(list, NSInteger);
            i++;
            LSConstraint *con =  self.constraints[i-1];
            con.constant = args ;
            
        } while (i < self.constraints.count);
        
        va_end(list);
        return self;
    };
}


-(LSConstraint * (^)(NSLayoutAttribute attribute) )constraint
{
    return ^LSConstraint *(NSLayoutAttribute attribute){
        
        LSConstraint *con = [[LSConstraint alloc] init];
        con.attribute = attribute;
        con.superconstraint = self;
        con.item = self.item;
        //一个约束范式只有一个 constraints
        if (self.constraints == nil) {
            
            if (self.superconstraint.constraints == nil) {
                self.constraints = [NSMutableArray array];
                [self.constraints addObject:self];
            }else
            {    self.constraints = self.superconstraint.constraints;
                [self.constraints addObject:self];
            }
        }
        
        [self.constraints addObject:con];
        return self;
    };
}

-(void (^)(NSLayoutAttribute attribute) )setConstraint:(LSConstraint *)con
{
 return ^(NSLayoutAttribute attribute)
    {
        self.constraint(attribute);
       
        NSAssert((self.constraints.count == con.constraints.count), @"两边约束个数不相等");
        
        //添加约束
        self.item.translatesAutoresizingMaskIntoConstraints = NO;
        con.item.translatesAutoresizingMaskIntoConstraints = NO;
        for (int i = 0; i < self.constraints.count; i++) {
          LSConstraint *con1 =  self.constraints[i];
          LSConstraint *con2 =  con.constraints[i];
          NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:con1.item attribute:con1.attribute relatedBy:NSLayoutRelationEqual toItem:con2.item attribute:con2.attribute multiplier:1 constant:con2.constant];
          [con1.item.superview addConstraint:constraint];
        }
       
        
    };
}

//left
-(LSConstraint * )left
{
    return self.constraint(NSLayoutAttributeLeft);
    
}

-(void)setLeft:(LSConstraint *)left
{
    
    [self setConstraint:left](NSLayoutAttributeLeft);
}

//right
-(LSConstraint *)right
{
    return self.constraint(NSLayoutAttributeRight);
}

-(void)setRight:(LSConstraint *)right
{
    [self setConstraint:right](NSLayoutAttributeRight);
}


//top
-(LSConstraint *)top
{
    return self.constraint(NSLayoutAttributeTop);
}

-(void)setTop:(LSConstraint *)top
{
  [self setConstraint:top](NSLayoutAttributeTop);
}


//bottom
-(LSConstraint *)bottom
{
    return self.constraint(NSLayoutAttributeBottom);
}

-(void)setBottom:(LSConstraint *)bottom
{
   [self setConstraint:bottom](NSLayoutAttributeBottom);
}



//leading
-(LSConstraint *)leading
{
    return self.constraint(NSLayoutAttributeLeading);
}
-(void)setLeading:(LSConstraint *)leading
{
    [self setConstraint:leading](NSLayoutAttributeLeading);
}



//trailing
-(LSConstraint *)trailing
{
    return self.constraint(NSLayoutAttributeTrailing);
}
-(void)setTrailing:(LSConstraint *)trailing
{
   [self setConstraint:trailing](NSLayoutAttributeTrailing);
}



//width
-(LSConstraint *)width
{
    return self.constraint(NSLayoutAttributeWidth);
}
-(void)setWidth:(LSConstraint *)width
{
    [self setConstraint:width](NSLayoutAttributeWidth);
}



//height
-(LSConstraint *)height
{
    return self.constraint(NSLayoutAttributeHeight);
}
-(void)setHeight:(LSConstraint *)height
{
    [self setConstraint:height](NSLayoutAttributeHeight);
}



//centerX
-(LSConstraint *)centerX
{
    return self.constraint(NSLayoutAttributeCenterX);
}
-(void)setCenterX:(LSConstraint *)centerX
{
    [self setConstraint:centerX](NSLayoutAttributeCenterX);
}



//centerY
-(LSConstraint *)centerY
{
    return self.constraint(NSLayoutAttributeCenterY);
}
-(void)setCenterY:(LSConstraint *)centerY
{
    [self setConstraint:centerY](NSLayoutAttributeCenterY);
}



//baseline
-(LSConstraint *)baseline
{
    return self.constraint(NSLayoutAttributeBaseline);
}

-(void)setBaseline:(LSConstraint *)baseline
{
   [self setConstraint:baseline](NSLayoutAttributeBaseline);
}


@end
