//
//  ViewController.m
//  idcardTest
//
//  Created by xiete@wyc.cn on 2018/12/3.
//  Copyright © 2018年 xiete. All rights reserved.
//

#import "ViewController.h"
#import "XTIDCardKeyboard.h"

@interface ViewController ()<XTIDCardKeyboardDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputTextF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    XTIDCardKeyboard *keyboard = [[XTIDCardKeyboard alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, WIDTH_SCREEN/3/2 * 4)];
    keyboard.delegate = self;
    self.inputTextF.inputView = keyboard;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)xtKeyboardSelectValue:(NSString *)value{
    if ([value containsString:@"delete"]){
        
        [self.inputTextF deleteBackward];
    }else{
        
        // 计算光标位置，并插入键盘输入的字符
        UITextPosition *beginning = self.inputTextF.beginningOfDocument;
        
        // 当前选择的区域
        UITextRange *selectedRange = self.inputTextF.selectedTextRange;
        /// 选择区域的起始位置
        UITextPosition *selectionStart = selectedRange.start;
        /// 选择区域的终点位置
        UITextPosition *selectionEnd = selectedRange.end;
        
        const NSInteger location = [self.inputTextF offsetFromPosition:beginning toPosition:selectionStart];
        
        const NSInteger selectionEndLocation = [self.inputTextF offsetFromPosition:beginning toPosition:selectionEnd];
        
        NSMutableString *variableValue = [NSMutableString stringWithString:self.inputTextF.text];
        if (selectionEndLocation - location > 0){
            
            [variableValue replaceCharactersInRange:NSMakeRange(location, selectionEndLocation - location) withString:value];
            
        }else{
            [variableValue insertString:value atIndex:location];
        }
        
        self.inputTextF.text = variableValue;
        
        // 输入键盘数字后更新光标位置
        UITextPosition* startPosition = [self.inputTextF positionFromPosition:self.inputTextF.beginningOfDocument offset:location + 1];
        UITextPosition* endPosition = [self.inputTextF positionFromPosition:self.inputTextF.beginningOfDocument offset:location + 1];
        UITextRange* selectionRange = [self.inputTextF textRangeFromPosition:startPosition toPosition:endPosition];
        if(startPosition && endPosition){
            [self.inputTextF setSelectedTextRange:selectionRange];
        }
        
    }
}

@end
