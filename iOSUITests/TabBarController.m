//
//  TabBarController.m
//  iOSUITests
//
//  Created by dyw on 2017/3/15.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import "TabBarController.h"
#import "LoginManager.h"

@interface TabBarController ()
<UITabBarControllerDelegate>

@end

@implementation TabBarController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOut) name:@"logOut" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:@"logOut"];
}

#pragma mark - private methods
- (void)logOut{
    self.selectedIndex = 0;
}

#pragma mark - public methods

#pragma mark - request methods

#pragma mark - UITableViewDataSource

#pragma mark - UITableViewDelegate

#pragma mark - TabBarController Delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    //判断是否登陆 未登陆跳转到登陆界面
    if(![LoginManager getLogin]){
        [self performSegueWithIdentifier:@"prLoginViewController" sender:nil];
        return NO;
    }
    return YES;
}


#pragma mark - event response

#pragma mark - getters and setters


@end
