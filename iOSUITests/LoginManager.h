//
//  LoginManager.h
//  iOSUITests
//
//  Created by dyw on 2017/3/15.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LoginManager : NSObject

+ (void)setLogin:(BOOL)isLogin;
+ (BOOL)getLogin;


@end
