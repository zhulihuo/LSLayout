# LSLayout
LSLayout 是一个基于自动布局的轻量级框架


如何使用LSLayout
#import "UIView+LSLayout.h"

具体用法：

1.添加单个约束
view1.top = view2.top.offset(20);

2.同时添加多个约束
view1.top.left = view2.top.left.mutableoffset(@20,@10);

3.常用约束
>>设置宽高
btn1.size(100,50); 
ps:传入负值则不添加约束
如：btn1.size(-1,50);
只设置高度

>>设置位置,Y
btn1.origin(100,100);
>>对齐
btn2.leftAlignBy(btn1);
>>间距
btn2.topSpacingBy(btn1,20);
>>等宽高
btn2.WHequalTo(btn1);


等等。。

4.约束控制

>>修改约束常量  index 依据自己添加约束的顺序
[view  resetConstraint:0 constant:20];

>>替换约束,原来的约束还在，只不过失效，新的约束要从数组后面取
-(void)replaceConstant:(NSInteger)index completion:(void (^)())complet;

>>激活约束
-(void)activeConstant:(NSInteger)index;