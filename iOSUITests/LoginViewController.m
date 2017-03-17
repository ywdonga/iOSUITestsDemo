//
//  LoginViewController.m
//  iOSUITests
//
//  Created by dyw on 2017/3/15.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginManager.h"

#define TestName @"iss"
#define TestPwd @"123456"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation LoginViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.pwdTextField.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - private methods

#pragma mark - public methods

#pragma mark - request methods

#pragma mark - UITableViewDataSource

#pragma mark - UITableViewDelegate

#pragma mark - Custom Delegate

#pragma mark - event response
- (IBAction)cancerButtonClick:(id)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginButtonClick:(id)sender {
    if([self.nameTextField.text isEqualToString:TestName] && [self.pwdTextField.text isEqualToString:TestPwd]){
        [LoginManager setLogin:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:nil message:@"账号或者密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alt show];
}

#pragma mark - getters and setters

@end
