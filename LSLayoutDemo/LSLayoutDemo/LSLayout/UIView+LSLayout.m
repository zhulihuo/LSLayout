//
//  UIView+LSLayout.m
//  SizeClass
//
//  Created by liushuang on 15-3-9.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import "UIView+LSLayout.h"
#import <objc/runtime.h>
char* const ASSOCIATION_ConstraintArr = "ASSOCIATION_ConstraintArr";
@implementation UIView (LSLayout)

#pragma mark - 通过关联扩展属性
-(NSMutableArray *)constraintArr
{
    NSMutableArray* constraintArr =objc_getAssociatedObject(self,ASSOCIATION_ConstraintArr);
    
    return constraintArr;
}

-(void)setConstraintArr:(NSMutableArray *)constraintArr
{
    objc_setAssociatedObject(self,ASSOCIATION_ConstraintArr,constraintArr,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(NSLayoutConstraint *)creatLayout:(LSConstraint *)con
{
    
NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self attribute:1 relatedBy:NSLayoutRelationEqual toItem:con.item attribute:con.attribute multiplier:con.multiplier constant:con.constant];
return right;
    
}

-(LSConstraint * (^)(NSLayoutAttribute attribute) )constraint
{
    if (self.constraintArr == nil) {
        self.constraintArr = [[NSMutableArray alloc] init];
    }
   return ^LSConstraint *(NSLayoutAttribute attribute){
        LSConstraint *con = [[LSConstraint alloc] init];
        con.attribute = attribute;
        con.item = self;
        
        return con;
    };

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
        if (w >= 0) {
          self.width = self.superview.width.unusedDefault(YES).multipliedBy(0).offset(w);
        }
        if (h >= 0) {
            self.height = self.superview.width.unusedDefault(YES).multipliedBy(0).offset(h);
        }
    };
}


//edge
-(void (^)(CGFloat, CGFloat, CGFloat, CGFloat))edge
{
    return ^void (CGFloat top ,CGFloat left,CGFloat bottom ,CGFloat right){
        if(top >= 0)
        {
         self.top = self.superview.top.offset(top);
        }
        if(left >= 0)
        {
          self.left = self.superview.left.offset(left);
        }
        if(bottom >= 0)
        {
          self.bottom = self.superview.bottom.offset(-bottom);
        }
        if(right >= 0)
        {
          self.right = self.superview.right.offset(-right);
        }
       
       
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


#pragma mark -重新设置约束参数
-(void)resetConstraint:(NSInteger)index constant:(CGFloat)constant
{
    NSAssert((index < self.constraintArr.count), @"参数index越界");
    
    NSLayoutConstraint *con = self.constraintArr[index];
    con.constant = constant;
    
}


#pragma mark -重新设置约束
-(void)replaceConstant:(NSInteger)index completion:(void (^)())complet
{
   NSAssert((index < self.constraintArr.count), @"参数index越界");
    [NSLayoutConstraint deactivateConstraints:@[self.constraintArr[index]]];
    if (complet) {
        complet();
    }

}
#pragma mark -激活约束
-(void)activeConstant:(NSInteger)index
{
[NSLayoutConstraint activateConstraints:@[self.constraintArr[index]]];
}



@end

@implementation UIView (change)


-(void (^)(CGFloat))changeW
{
    return ^void (CGFloat offset)
    {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width+offset, self.frame.size.height);
    };
}

-(void (^)(CGFloat))changeH
{
    return ^void (CGFloat offset)
    {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,self.frame.size.height+offset);
    };
}
-(void (^)(CGFloat))changeX
{
    return ^void (CGFloat offset)
    {
        self.frame = CGRectMake(self.frame.origin.x+offset, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    };
}

-(void (^)(CGFloat))changeY
{
    return ^void (CGFloat offset)
    {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+offset, self.frame.size.width, self.frame.size.height);
    };
}


-(void (^)(CGFloat, CGFloat))changeOrigin
{
    return ^void (CGFloat x,CGFloat y)
    {
        self.transform = CGAffineTransformTranslate( self.transform, x, y);
    };
}
-(void (^)(CGFloat, CGFloat))changeSize{
    
    return ^void (CGFloat w,CGFloat h)
    {
        CGFloat sw = (self.frame.size.width+w)/self.frame.size.width;
        CGFloat sh = (self.frame.size.height+h)/self.frame.size.height;
        self.transform = CGAffineTransformScale(self.transform, sw, sh);
    };
}



@end
