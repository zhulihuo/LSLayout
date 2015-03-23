//
//  ViewController.m
//  LSLayoutDemo
//
//  Created by liushuang on 15-3-23.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import "ViewController.h"
#import "UIView+LSLayout.h"
@interface ViewController ()
{
     UIButton *btn1;
     UIButton *btn2;
     UIButton *btn3;
     UIButton *btn4;
     UIButton *btn5;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
     btn1 = [[UIButton alloc] init];
     btn2 = [[UIButton alloc] init];
     btn3 = [[UIButton alloc] init];
     btn4 = [[UIButton alloc] init];
     btn5 = [[UIButton alloc] init];
     [self setBtn:btn1 index:1];
     [self setBtn:btn2 index:2];
     [self setBtn:btn3 index:3];
     [self setBtn:btn4 index:4];
     [self setBtn:btn5 index:5];
    
    btn1.size(100,50);
    btn1.origin(100,100);
    
    btn2.leftAlignBy(btn1);
    btn2.topSpacingBy(btn1,20);
    btn2.WHequalTo(btn1);
    
    btn3.leftSpacingBy(btn1,20);
    btn3.topAlignBy(btn1);
    btn3.WHequalTo(btn1);
    
    btn4.edge(500,20,20,20);
    
    btn5.top = btn2.bottom.offset(20);
    btn5.leftAlignBy(btn1);
    btn5.width.height = btn2.width.height.mutableoffset(120,100);
    
}

-(void)setBtn:(UIButton *)btn index:(NSInteger) index
{
 btn.translatesAutoresizingMaskIntoConstraints = NO;
 btn.backgroundColor = [UIColor brownColor];
 [btn setTitle:[NSString stringWithFormat:@"btn%li",(long)index] forState:UIControlStateNormal];
 [self.view addSubview:btn];

}


@end
