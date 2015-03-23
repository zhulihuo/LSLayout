//
//  UIView+LSLayout.m
//  SizeClass
//
//  Created by liushuang on 15-3-9.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import "UIView+LSLayout.h"

@implementation UIView (LSLayout)


-(NSLayoutConstraint *)creatLayout:(LSConstraint *)con
{
    
NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self attribute:1 relatedBy:NSLayoutRelationEqual toItem:con.item attribute:con.attribute multiplier:con.multiplier constant:con.constant];
return right;
    
}

-(void)setConstraint:(LSConstraint *)constraint
{
    [self.superview addConstraint:[self creatLayout:constraint]];

}
-(LSConstraint * (^)(NSLayoutAttribute attribute) )constraint
{
   return ^LSConstraint *(NSLayoutAttribute attribute){
        LSConstraint *con = [[LSConstraint alloc] init];
        con.attribute = attribute;
        con.item = self;
        return con;
    };

}
-(NSLayoutConstraint *)constraint:(NSLayoutAttribute)attribute
{
    for (NSLayoutConstraint *Constraint in self.constraints) {
        if (Constraint.firstAttribute == attribute) {
            return Constraint;
        }
    }   
    return nil;
}

-(void)resetConstraint:(NSLayoutAttribute)attribute constant:(CGFloat)constant
{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == attribute) {
            constraint.constant = constant;
            break;
        }
    }
}

//left
-(LSConstraint *)left
{
    return self.constraint(NSLayoutAttributeLeft);
}

-(void)setLeft:(LSConstraint *)left
{
    self.left.equalTo(left);
}



//right
-(LSConstraint *)right
{
    return self.constraint(NSLayoutAttributeRight);
}

-(void)setRight:(LSConstraint *)right
{
  self.right.equalTo(right);
}


//top
-(LSConstraint *)top
{
    return self.constraint(NSLayoutAttributeTop);
}

-(void)setTop:(LSConstraint *)top
{
    self.top.equalTo(top);
}


//bottom
-(LSConstraint *)bottom
{
    return self.constraint(NSLayoutAttributeBottom);
}

-(void)setBottom:(LSConstraint *)bottom
{
 self.bottom.equalTo(bottom);
}



//leading
-(LSConstraint *)leading
{
    return self.constraint(NSLayoutAttributeLeading);
}
-(void)setLeading:(LSConstraint *)leading
{
 self.leading.equalTo(leading);
}



//trailing
-(LSConstraint *)trailing
{
    return self.constraint(NSLayoutAttributeTrailing);
}
-(void)setTrailing:(LSConstraint *)trailing
{
 self.trailing.equalTo(trailing);
}



//width
-(LSConstraint *)width
{
    return self.constraint(NSLayoutAttributeWidth);
}
-(void)setWidth:(LSConstraint *)width
{
 self.width.equalTo(width);
}



//height
-(LSConstraint *)height
{
    return self.constraint(NSLayoutAttributeHeight);
}
-(void)setHeight:(LSConstraint *)height
{
self.height.equalTo(height);
}



//centerX
-(LSConstraint *)centerX
{
    return self.constraint(NSLayoutAttributeCenterX);
}
-(void)setCenterX:(LSConstraint *)centerX
{
self.centerX.equalTo(centerX);
}



//centerY
-(LSConstraint *)centerY
{
    return self.constraint(NSLayoutAttributeCenterY);
}
-(void)setCenterY:(LSConstraint *)centerY
{
self.centerY.equalTo(centerY);
}



//baseline
-(LSConstraint *)baseline
{
    return self.constraint(NSLayoutAttributeBaseline);
}
-(void)setBaseline:(LSConstraint *)baseline
{
 self.baseline.equalTo(baseline);
}

//origin
-(void (^)(CGFloat, CGFloat))origin
{
    return ^void (CGFloat x,CGFloat y){
        
        self.top = self.superview.top.unusedDefault(YES).multipliedBy(0).offset(y);
        self.left = self.superview.left.unusedDefault(YES).multipliedBy(0).offset(x);
        
    };
}

//size
-(void (^)(CGFloat, CGFloat))size
{
    return ^void (CGFloat w,CGFloat h){
    
      self.width = self.superview.width.unusedDefault(YES).multipliedBy(0).offset(w);
      self.height = self.superview.width.unusedDefault(YES).multipliedBy(0).offset(h);
 
    };
}


//edge
-(void (^)(CGFloat, CGFloat, CGFloat, CGFloat))edge
{
    return ^void (CGFloat top ,CGFloat left,CGFloat bottom ,CGFloat right){
        
        self.top = self.superview.top.offset(top);
        self.left = self.superview.left.offset(left);
        self.bottom = self.superview.bottom.offset(-bottom);
        self.right = self.superview.right.offset(-right);
        
    };

}
//WHequalTo
-(void (^)(UIView *))WHequalTo
{
    return ^void (UIView *view)
    {
        self.width = view.width;
        self.height = view.height;    
    };
}

#pragma matk ---对齐
-(void (^)(UIView *, NSLayoutAttribute))alignBy
{
return ^void (UIView *view,NSLayoutAttribute attribute)
    {
        
        
        NSLayoutConstraint *con = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view attribute:attribute multiplier:1 constant:0];
        
        [self.superview addConstraint:con];
        
    };
}

-(void (^)(UIView *))topAlignBy
{
    return ^void (UIView *view)
    {
        self.alignBy(view,NSLayoutAttributeTop);
        
    };
}


-(void (^)(UIView *))leftAlignBy
{
    return ^void (UIView *view)
    {
        self.alignBy(view,NSLayoutAttributeLeft);
        
    };
}

-(void (^)(UIView *))bottomAlignBy
{

    return ^void (UIView *view)
    {
        self.alignBy(view,NSLayoutAttributeBottom);
        
    };
}

-(void (^)(UIView *))rightAlignBy
{
    return ^void (UIView *view)
    {
        self.alignBy(view,NSLayoutAttributeRight);
        
    };
}

#pragma matk ---间距
-(void (^)(UIView *, CGFloat, NSLayoutAttribute))spacingBy
{
    return ^void (UIView *view,CGFloat spacing,NSLayoutAttribute attribute)
    {
        NSLayoutAttribute attribute2;
        switch (attribute) {
            case NSLayoutAttributeTop:
                attribute2 = NSLayoutAttributeBottom;
                break;
            case NSLayoutAttributeLeft:
                attribute2 = NSLayoutAttributeRight;
                break;
            case NSLayoutAttributeBottom:
                attribute2 = NSLayoutAttributeTop;
                spacing = -spacing;
                break;
            case NSLayoutAttributeRight:
                attribute2 = NSLayoutAttributeLeft;
                spacing = -spacing;
                break;
                
            default:
                break;
        }
        
        NSLayoutConstraint *con = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view attribute:attribute2 multiplier:1 constant:spacing];
        
        [self.superview addConstraint:con];
        
    };
}

-(void (^)(UIView *, CGFloat))topSpacingBy
{
    return ^void (UIView *view,CGFloat spacing)
    {
        self.spacingBy(view,spacing,NSLayoutAttributeTop);
    };
}


-(void (^)(UIView *, CGFloat))leftSpacingBy
{
    return ^void (UIView *view,CGFloat spacing)
    {
        self.spacingBy(view,spacing,NSLayoutAttributeLeft);
        
    };
}

-(void (^)(UIView *, CGFloat))bottomSpacingBy
{
    
    return ^void (UIView *view,CGFloat spacing)
    {
        self.spacingBy(view,spacing,NSLayoutAttributeBottom);
        
    };
}

-(void (^)(UIView *, CGFloat))rightSpacingBy
{
    return ^void (UIView *view,CGFloat spacing)
    {
        self.spacingBy(view,spacing,NSLayoutAttributeRight);
        
    };
}


@end
