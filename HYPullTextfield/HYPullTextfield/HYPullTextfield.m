//
//  HYPullTextfield.m
//  HYPullTextfield
//
//  Created by yanghaha on 15/8/6.
//  Copyright (c) 2015年 yanghaha. All rights reserved.
//

#import "HYPullTextfield.h"

@interface HYPullTextfield ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong, readonly) UIButton *pullButton;     //下拉按钮
@property (nonatomic, strong) UIPickerView *contentPicker;          //内容选择
@property (nonatomic, strong) UIToolbar *accessoryView;             //textfield的inputAccessoryView

@end

@implementation HYPullTextfield

@synthesize inputTextField = _inputTextField;
@synthesize pullButton = _pullButton;
@synthesize image = _image;


#pragma mark - LifeCycle

-(void)layoutSubviews {
    [super layoutSubviews];


    CGRect rect = self.bounds;

    self.inputTextField.frame = UIEdgeInsetsInsetRect(rect, self.contentInset);

    CGRect pullButtonFrame;

    if (CGSizeEqualToSize(self.accessorySize, CGSizeZero)) {
        CGFloat width = self.image.size.width * self.image.size.height/CGRectGetHeight(rect);
        pullButtonFrame = CGRectMake(0, 0, width, CGRectGetHeight(rect));
    } else {
        pullButtonFrame = CGRectMake(0, 0, self.accessorySize.width, self.accessorySize.height);
    }

    self.pullButton.frame = pullButtonFrame;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - SET && GET

- (void)setTitle:(NSString *)title {
    self.inputTextField.text = title;
}

- (NSString *)title {
    return self.inputTextField.text;
}

- (UITextField *)inputTextField {
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.borderStyle = UITextBorderStyleRoundedRect;
        _inputTextField.rightViewMode = UITextFieldViewModeAlways;
        _inputTextField.rightView = self.pullButton;
        _inputTextField.inputAccessoryView = self.accessoryView;
        _inputTextField.inputView = self.contentPicker;
        [self addSubview:_inputTextField];
    }

    return _inputTextField;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    [self.pullButton setImage:_image forState:UIControlStateNormal];
}

- (UIImage *)image {
    if (!_image) {
        _image = [UIImage imageNamed:@"Icon_pull"];
        [self.pullButton setImage:_image forState:UIControlStateNormal];
    }

    return _image;
}

- (void)setPullBackgroundColor:(UIColor *)pullBackgroundColor {
    _pullBackgroundColor = pullBackgroundColor;
    self.contentPicker.backgroundColor = _pullBackgroundColor;
}

#pragma mark - Private

- (UIButton *)pullButton {
    if (!_pullButton) {
        _pullButton = [[UIButton alloc] init];
        [_pullButton addTarget:self action:@selector(touchPullButton:) forControlEvents:UIControlEventTouchUpInside];
    }

    return _pullButton;
}

- (UIPickerView *)contentPicker {
    if (!_contentPicker) {
        _contentPicker = [[UIPickerView alloc] init];
        _contentPicker.delegate = self;
        _contentPicker.dataSource = self;
        _contentPicker.backgroundColor = [UIColor whiteColor];
    }

    return _contentPicker;
}

- (UIToolbar *)accessoryView {
    if (!_accessoryView) {

        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneItem:)];

         _accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        _accessoryView.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneItem];
    }

    return _accessoryView;
}

- (void)doneItem:(UIBarButtonItem *)item {
    [self.inputTextField endEditing:YES];
}

#pragma mark - Action

- (void)touchPullButton:(UIButton *)sender {
    [self.inputTextField becomeFirstResponder];
}

#pragma mark - UIPickerViewDataSource && UIPickerViewDelegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if ([self.dataSource respondsToSelector:@selector(numberOfComponentsInPullTextfield:)]) {
        return [self.dataSource numberOfComponentsInPullTextfield:self];
    }

    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([self.dataSource respondsToSelector:@selector(pullTextfield:numberOfRowsInComponent:)]) {
        return [self.dataSource pullTextfield:self numberOfRowsInComponent:component];
    }

    return 0;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([self.delegate respondsToSelector:@selector(pullTextfield:didSelectRow:inComponent:)]) {
        [self.delegate pullTextfield:self didSelectRow:row inComponent:component];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([self.delegate respondsToSelector:@selector(pullTextfield:titleForRow:forComponent:)]) {
        return [self.delegate pullTextfield:self titleForRow:row forComponent:component];
    }

    return [@(row) description];
}


@end
