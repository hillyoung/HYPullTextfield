//
//  ViewController.m
//  HYPullTextfield
//
//  Created by yanghaha on 15/8/6.
//  Copyright (c) 2015年 yanghaha. All rights reserved.
//

#import "ViewController.h"
#import "HYPullTextfield.h"

@interface ViewController ()<HYPullTextfieldDataSource, HYPullTextfieldDelegate, UITableViewDataSource, UITableViewDelegate> {
    HYPullTextfield *pullTextField;
}

@end

@implementation ViewController


- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];



    pullTextField = [[HYPullTextfield alloc] initWithFrame:CGRectMake(20, 100, 280, 60)];
    pullTextField.delegate = self;
    pullTextField.dataSource = self;
    pullTextField.inputTextField.placeholder = @"请输入商品";
//    pullTextField.image = [UIImage imageNamed:@"join"];
    pullTextField.backgroundColor = [UIColor redColor];

    [self.view addSubview:pullTextField];


    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;

//    [self.view addSubview:tableView];


    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction)];
//    [self.view addGestureRecognizer:tapGesture];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HYPullTextfieldDataSource && HYPullTextfieldDelegate

- (NSInteger)numberOfComponentsInPullTextfield:(HYPullTextfield *)pullTextfield {
    return 1;
}

- (NSInteger)pullTextfield:(HYPullTextfield *)pullTextfield numberOfRowsInComponent:(NSInteger)component {
    return 10;
}

- (NSString *)pullTextfield:(HYPullTextfield *)pullTextfield titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"55";
}

-(void)pullTextfield:(HYPullTextfield *)pullTextfield didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    pullTextfield.title = [@"select" stringByAppendingFormat:@"-->%ld",row];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"default";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];

    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return [@"head-->" stringByAppendingFormat:@"%ld", section];
//}

- (void)closeAction {
//    [pullTextField.contentPicker endEditing:YES];
}

@end
