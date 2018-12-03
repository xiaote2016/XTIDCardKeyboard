//
//  XTIDCardKeyboard.m
//  idcardTest
//
//  Created by xiete@wyc.cn on 2018/12/3.
//  Copyright © 2018年 xiete. All rights reserved.
//

#import "XTIDCardKeyboard.h"

#define idCardNums @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"X",@"0",@"delete"]
@implementation XTIDCardKeyboard

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    
    CGFloat btnWidth = WIDTH_SCREEN / 3;
    CGFloat btnHeight = self.frame.size.height / 4;
    
    NSInteger index = 0;
    for (int i = 0; i < 4; i++){ // 行数
        for (int j = 0;j < 3; j++){ // 列
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(j * btnWidth, i * btnHeight, btnWidth, btnHeight);
            button.backgroundColor = [UIColor whiteColor];
            [button setTitle:idCardNums[index] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:0.66 green:0.68 blue:0.73 alpha:1.00] size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.font = [UIFont systemFontOfSize:20];
            [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            index ++;
        }
    }
    
    // 画线
    for (int i = 1; i<3; i++){
        UIBezierPath *bottomPath = [UIBezierPath bezierPath];
        [bottomPath moveToPoint:CGPointMake(i * btnWidth, 0)];
        [bottomPath addLineToPoint:CGPointMake(i * btnWidth, self.frame.size.height)];
        [self addLineWithPath:bottomPath.CGPath];
    }
    
    for (int i = 0; i<4; i++){
        UIBezierPath *bottomPath = [UIBezierPath bezierPath];
        [bottomPath moveToPoint:CGPointMake(0, i * btnHeight)];
        [bottomPath addLineToPoint:CGPointMake(self.frame.size.width, i * btnHeight)];
        [self addLineWithPath:bottomPath.CGPath];
    }

}

- (void)clickAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(xtKeyboardSelectValue:)]){
        
        [self.delegate xtKeyboardSelectValue:sender.currentTitle];
    }
}

#pragma mark - private
- (void)addLineWithPath:(CGPathRef)path{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor colorWithRed:0.81 green:0.83 blue:0.85 alpha:0.5].CGColor;
    layer.fillColor = nil;
    layer.path = path;
    layer.lineWidth = 2;
    [self.layer addSublayer:layer];
}

/// 颜色转图片
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
