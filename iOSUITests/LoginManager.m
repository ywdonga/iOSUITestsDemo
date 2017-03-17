//
//  LoginManager.m
//  iOSUITests
//
//  Created by dyw on 2017/3/15.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import "LoginManager.h"

#define LoginKey @"LoginKey"

@implementation LoginManager

+ (void)setLogin:(BOOL)isLogin{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    [df setBool:isLogin forKey:LoginKey];
}

+ (BOOL)getLogin{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    return [df boolForKey:LoginKey];
}

@end
