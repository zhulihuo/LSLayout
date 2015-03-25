//
//  LSConstraint.m
//  SizeClass
//
//  Created by liushuang on 15-3-9.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import "LSConstraint.h"
#import "UIView+LSLayout.h"
@implementation LSConstraint


-(LSConstraint *(^)(LSConstraint *))equalTo
{
    self.item.translatesAutoresizingMaskIntoConstraints = NO;
    
    return ^LSConstraint *(LSConstraint *con){
        if (con.unusedMultiple == NO) {
            con.multipliedBy(1);
        }
        
       _layoutConstraint= [NSLayoutConstraint constraintWithItem:self.item attribute:self.attribute relatedBy:NSLayoutRelationEqual toItem:con.item attribute:con.attribute multiplier:con.multiplier constant:con.constant];
      
       [self.item.superview addConstraint:_layoutConstraint];
       [self.item.constraintArr addObject:_layoutConstraint];
        return con;
    };
}




-(LSConstraint *(^)(CGFloat))offset
{
  return ^ LSConstraint *(CGFloat offset)
    {
        self.constant = offset;
        return self;
    };

}


-(LSConstraint *(^)(CGFloat))multipliedBy
{
    return ^ LSConstraint *(CGFloat multiplier)
    {
        self.multiplier = multiplier;
        return self;
    };

}

-(LSConstraint *(^)(BOOL))unusedDefault
{
    return ^ LSConstraint *(BOOL unusedMultiple)
    {
        self.unusedMultiple = unusedMultiple;
        return self;
    };
}






@end
