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
    btn5.width.height = btn2.width.height.mutableoffset(@120,@20);
    
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

-(void)setBtn:(UIButton *)btn index:(NSInteger) index
{
 btn.translatesAutoresizingMaskIntoConstraints = NO;
 btn.backgroundColor = [UIColor brownColor];
 [btn setTitle:[NSString stringWithFormat:@"btn%li",(long)index] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
 [self.view addSubview:btn];

}

-(void)onClick:(id)sender
{
    
    
 //在viewDidAppear后，通过设置frame的动画没有效果，可以通过设置transform实现动画效果
    NSLog(@">>>>>>>%@",NSStringFromCGRect(btn5.frame));
    if (sender == btn5) {
        if (btn5.selected != YES) {
            [UIView animateWithDuration:1 animations:^{
                btn5.changeOrigin(0,10);
                btn5.changeSize(0,20);
                
            } completion:^(BOOL finished) {
                NSLog(@">>>>>>>%@",NSStringFromCGRect(btn5.frame));
                btn5.selected = YES;
               
            }];
        }else
        {
            [UIView animateWithDuration:1 animations:^{
                 btn5.transform  = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                NSLog(@">>>>>>>%@",NSStringFromCGRect(btn5.frame));
                btn5.selected = NO;
               
            }];
        
        }
       
    }

}


@end
