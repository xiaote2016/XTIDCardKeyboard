//
//  XTIDCardKeyboard.h
//  idcardTest
//
//  Created by xiete@wyc.cn on 2018/12/3.
//  Copyright © 2018年 xiete. All rights reserved.
//

#import <UIKit/UIKit.h>

#define     WIDTH_SCREEN                [UIScreen mainScreen].bounds.size.width
#define     HEIGHT_SCREEN               [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN


@protocol XTIDCardKeyboardDelegate <NSObject>

- (void)xtKeyboardSelectValue:(NSString *)value;

@end

@interface XTIDCardKeyboard : UIView

@property (nonatomic, weak) id<XTIDCardKeyboardDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
