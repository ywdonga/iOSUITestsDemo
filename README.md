#iOS UITests(UI自动化测试 实现)
[博客地址http://www.jianshu.com/p/cf445a2f5f5b](http://www.jianshu.com/p/cf445a2f5f5b)
[toc]

###简介
1.UI Tests是一个自动测试UI与交互的Testing组件,它可以通过编写代码、或者是记录开发者的操作过程并代码化，来实现自动点击某个按钮、视图，或者自动输入文字等功能。
2.在实际的开发过程中，随着项目越做越大，功能越来越多，仅仅靠人工操作的方式来覆盖所有测试用例是非常困难的，尤其是加入新功能以后，旧的功能也要重新测试一遍，这导致了测试需要花非常多的时间来进行回归测试，这里产生了大量重复的工作，而这些重复的工作有些是可以自动完成的，这时候UI Tests就可以帮助解决这个问题了.
![home.gif](http://upload-images.jianshu.io/upload_images/1760826-580849733a553b26.gif?imageMogr2/auto-orient/strip)

###最低要求
Xcode7
iOS 9
###使用
1.添加**UI Teste Targets**
[新工程]() 创建工程的时候勾选 **Inclide UI Tests**

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/1760826-0b1d6f54bb5edd2a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

[现有的工程]() 新建一个 **Targets** 选择 **iOS UI Testing Bundle**

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/1760826-adafbffe2b8cd29a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![Paste_Image.png](http://upload-images.jianshu.io/upload_images/1760826-ac390e78bfb2aaeb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

[添加完成]() 添加完成可以看到**UITests**如图:

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/1760826-c5ceeecce273bc02.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


-------
### 自动化测试代码的编写
#####方法1.自己看着界面编写
参考文章下面的代码演示
[iOS UITests(自动化测试)常用类参考文档](http://www.jianshu.com/p/3b43e56c0a13)
[参考Demo](https://github.com/ywdonga/iOSUITestsDemo)
#####方法2.录制后修改
1.点击`UITests`类 下面的 红色的录制按钮
![Paste_Image.png](http://upload-images.jianshu.io/upload_images/1760826-0dc157d624c8746b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
然后APP会启动，你只需要对APP进行界面操作，系统就会在你光标最后停留的位置开始生成与你操作对应的代码，然后你稍作修改就可以用了。
看大大大图
![recode.gif](http://upload-images.jianshu.io/upload_images/1760826-058e1ba88a3a6ae7.gif?imageMogr2/auto-orient/strip)
自动生成的代码
![Paste_Image.png](http://upload-images.jianshu.io/upload_images/1760826-b6bd698545175cf7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
稍作修改，把里面的Unicode编码 转成中文，如下
![Paste_Image.png](http://upload-images.jianshu.io/upload_images/1760826-526fcb0d0dc4c55a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
这样就可以直接运行了


###运行自动化测试
1.` command + U`  运行UITests类中 每一个以`test`开头的方法 如：'- (void)allTestExample' '- (void)testHome' 个人感觉是没有顺序的
![Paste_Image.png](http://upload-images.jianshu.io/upload_images/1760826-7608eeda2f77a639.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2.点击每一个以`test`开头的方法前面的 播放 按钮（运行单个方法）
![Paste_Image.png](http://upload-images.jianshu.io/upload_images/1760826-4dcd3633dda515a0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
###涉及到的新类 
###[iOS UITests(自动化测试)常用类参考文档](http://www.jianshu.com/p/3b43e56c0a13)

> 
>XCUIApplication - 启动程序
------
>#####1.简介
这个类掌管应用程序的生命周期，代表被测应用继承
>XCUIElement - 元素
-------
>#####1.简介
>继承NSObject，实现协议XCUIElementAttributes, XCUIElementTypeQueryProvider
可以表示系统的各种UI元素
>XCUIElementQuery - 查找元素
-------
>用于定位用户界面元素的查询

###[iOS UITests(自动化测试)常用类参考文档](http://www.jianshu.com/p/3b43e56c0a13)

-------

###[代码演示](https://github.com/ywdonga/iOSUITestsDemo)
[https://github.com/ywdonga/iOSUITestsDemo](https://github.com/ywdonga/iOSUITestsDemo)
为了更好的演示 我用storyboard搭建了一个可以简单跳转的界面
![Jietu20170317-093727.png](http://upload-images.jianshu.io/upload_images/1760826-9e09b8e6028041e1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
####1.我们从首页的测试开始（未登录的首页）
测试首页我们首先得判断是否已经登录，因为已登录和未登录是无法进入 我的、资讯 这两个界面的。在选择这两个页面的时候会直接弹出登录界面，测试流程就会有差异。所以就得先判断当前状态是否是已登录状态。
>**1.1 判断登录状态**
因为我们不能访问原有APP的任何变量，所以只能通过某个界面特有的元素Element 来进行判断。在这里我们看到 如果未登录的话 点击‘我的’ 一定会跳转到‘登录’界面，而在登录界面有一个‘登录’Label. 在这里 我就通过 登录界面中的一个 文字为‘登录’的Label元素 作为判断对象（当然你可以根据自己的想法去定，但是一定要确保元素的唯一性）。
流程如下
![Paste_Image.png](http://upload-images.jianshu.io/upload_images/1760826-561308b49ef1fa61.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```
/** 判断是否在登陆界面 */
- (BOOL)isLogin{
    BOOL isLogin;
    //进入我的界面
    XCUIElementQuery *tabBarsQuery = self.app.tabBars;
    XCUIElement *tableBarButton = tabBarsQuery.buttons[@"我的"];
    !tableBarButton.exists?:[tableBarButton tap];
    //获取标志性Element loginLabel
    XCUIElement *loginLabel = self.app.staticTexts[@"loginLabel"];
    //判断是否登陆
    if(loginLabel.exists){//进入登陆界面（当前状态未登陆）
        XCUIElement *cancerButton = self.app.buttons[@"取消"];
        !cancerButton.exists?:[cancerButton tap];
        isLogin = NO;
    }else{//进入我的页面（当前状态已经登陆）
        tableBarButton = tabBarsQuery.buttons[@"首页"];
        !tableBarButton.exists?:[tableBarButton tap];
        isLogin = YES;
    }
    return isLogin;
}
```
上面代码中为何定义了一个变量(`BOOL isLogin`)去接收登录状态，为何不直接用 ‘登录’元素是否存在(`loginLabel.exists`)作为结果直接返回呢？
原因在于，在判断登录时，我们进入到其他界面了，为了不影响后面的测试流程，我们在判断完后最好要回到'首页'。然而在我们回到首页时候，登录元素在首页是找到不到的，'loginLabel.exists'直接为`NO`了。

>**1.2 退出登录**
>判断完登录状态后，就会出现两种情况了，登录/未登录，由于我们现在的目的是测试未登录的首页，那么如果是已经登录了就先退出登陆
![logOut.gif](http://upload-images.jianshu.io/upload_images/1760826-5114fbb153f13ffc.gif?imageMogr2/auto-orient/strip)
流程就是 
判断是否登陆 ->已经登陆 去‘我的’界面找到‘退出登陆’按钮，点击退出登陆

```
- (void)testLogOut{
    //判断是否登陆
    if([self isLogin]){
        NSLog(@"--> 开始退出登陆");
        //进入我的页面
        XCUIElement *tableBarButton = self.app.tabBars.buttons[@"我的"];
        !tableBarButton.exists?:[tableBarButton tap];

        //向上滑一点 避免小屏幕看不到按钮
        XCUIElement *tableView = [self.app.tables elementAtIndex:0];
        [tableView swipeUp];
        
        XCUIElementQuery *tablesQuery = self.app.tables;
        [tablesQuery.buttons[@"退出登陆"] tap];
        
        //弹窗点击
        [self alertViewTap];

        //判断是否登陆成功
        XCTAssert(![self isLogin], @"退出登陆失败，快查查原因");
        
        NSLog(@"---> 成功退出登陆");
    }else{
        NSLog(@"---> 本来就没有登陆");
    }
}
```
>**1.3 测试未登陆首页**
>未登录首页测试，目前我写的Demo只是对首页的每个元素进行查找和简单的操作
>如图
>![home.gif](http://upload-images.jianshu.io/upload_images/1760826-528934e49b401326.gif?imageMogr2/auto-orient/strip)


```
- (void)testHome{
    //判断是否登陆
    if([self isLogin]){
        [self testLogOut];//退出登陆
    }
    //UISegmentedControl (可见文字)
    XCUIElement *segmentedButton = self.app.segmentedControls.buttons[@"Second"];
    !segmentedButton.exists?:[segmentedButton tap];
    
    segmentedButton = self.app.segmentedControls.buttons[@"First"];
    !segmentedButton.exists?:[segmentedButton tap];
    
    //UITabBarController
    XCUIElementQuery *tabBarsQuery = self.app.tabBars;
    XCUIElement *tableBarButton = tabBarsQuery.buttons[@"我的"];
    !tableBarButton.exists?:[tableBarButton tap];
    
    tableBarButton = self.app.buttons[@"取消"];
    !tableBarButton.exists?:[tableBarButton tap];
    
    //UISlider (通过标签)
    XCUIElement *slider1 = self.app.sliders[@"slider1"];
    !slider1.exists?:[slider1 adjustToNormalizedSliderPosition:0];
    !slider1.exists?:[slider1 adjustToNormalizedSliderPosition:1];

    //UISwitch (通过标签)
    XCUIElement *switch1 = self.app.switches[@"switch1"];
    !switch1.exists?:[switch1 tap];
    !switch1.exists?:[switch1 tap];
    
    //UIStepper (通过顺序)
    XCUIElement *stepper = [self.app.steppers elementAtIndex:0];
    XCUIElement *incrementButton = stepper.buttons[@"Increment"];
    [incrementButton tap];
    [incrementButton tap];
    [incrementButton tap];
    
    XCUIElement *decrementButton = stepper.buttons[@"Decrement"];
    [decrementButton tap];
    [decrementButton tap];
    [decrementButton tap];
    
    //tableview (通过顺序)
    XCUIElement *tableview = [self.app.tables elementAtIndex:0];
    [tableview swipeDown];
    [tableview swipeUp];
    [tableview swipeDown];
    
    //cells
    XCUIElementQuery *cellQuery = tableview.cells;
    
    for (int i=0; i<5; i++) {
        //cell (通过顺序)
        [self cellTapAtIndex:i withCells:cellQuery];
        //UIAlertView
        [self alertViewTap];
    }
}
```

>**1.4 登录测试（多账号）**
>这里我们准备了多个账号，只有最后一个是对的，然后依次登录，如果全部登录失败就会进入断言
>`XCTAssert((loginIndex<self.accountArr.count), @"所有账号都无法登陆");`
>准备一个账号数组 填入所有账号


```
- (NSArray *)accountArr{
    if(!_accountArr.count){
        _accountArr = @[
                       @{@"name":@"zhangsan", @"pwd":@"123456"},//账号1
                       @{@"name":@"lisis", @"pwd":@"123456"},//账号2
                       @{@"name":@"wangmazi", @"pwd":@"123456"},//账号3
                       @{@"name":@"iss", @"pwd":@"123456"},//账号4
                       ];
    }
    return _accountArr;
}
```
效果图
![login.gif](http://upload-images.jianshu.io/upload_images/1760826-cc228fc3418b23f3.gif?imageMogr2/auto-orient/strip)
代码
```
- (void)testLogin{
    if([self isLogin]){
        NSLog(@"--> 测试登陆 已经是登陆状态");
        return;
    }
    NSLog(@"---> 开始测试登陆");
    //UITabBarController
    XCUIElementQuery *tabBarsQuery = self.app.tabBars;
    XCUIElement *tableBarButton = tabBarsQuery.buttons[@"我的"];
    !tableBarButton.exists?:[tableBarButton tap];
    
    XCTAssert((loginIndex<self.accountArr.count), @"所有账号都无法登陆");
    
    //获取用户名和密码
    NSDictionary *accountDict = self.accountArr[loginIndex];
    NSString *userName = accountDict[@"name"];
    NSString *pwd = accountDict[@"pwd"];
    
    //UITextField
    XCUIElement *nameTextField = self.app.textFields[@"用户名"];
    !nameTextField.exists?:[nameTextField tap];
    //输入用户名之前先清除之前的文本
    XCUIElement *clearButton = self.app.buttons[@"Clear text"];
    !clearButton.exists?:[clearButton tap];
    //输入用户名
    [nameTextField typeText:userName];
    
    //隐藏键盘
    [self hindKeyBoard];
    
    
    XCUIElement *pwdTextField = self.app.secureTextFields[@"密码"];
    !pwdTextField.exists?:[pwdTextField tap];
    //输入密码
    !pwdTextField.exists?:[pwdTextField typeText:pwd];
    
    //隐藏键盘
    [self hindKeyBoard];
    
    //开始登陆
    XCUIElement *loginButton = self.app.buttons[@"登录"];
    !loginButton.exists?:[loginButton tap];
    
    sleep(1);//等待登陆
    
    //根据标识查看是否登陆成功
    XCUIElement *loginLabel = self.app.staticTexts[@"loginLabel"];
    if(loginLabel.exists){//登陆失败
        //清除提示框
        [self alertViewTap];
        NSLog(@"---> 账号%@ 密码%@ 登陆失败", userName, pwd);
        //换个账号 重新登陆
        loginIndex ++;
        [self testLogin];
    }else{//登陆成功
        
        NSLog(@"---> 账号%@ 密码%@ 登陆成功", userName, pwd);
        
        XCUIElement *tableBarButton = tabBarsQuery.buttons[@"我的"];
        !tableBarButton.exists?:[tableBarButton tap];
        
        tableBarButton = tabBarsQuery.buttons[@"首页"];
        !tableBarButton.exists?:[tableBarButton tap];
        
        NSLog(@"---> 登陆测试完成");
    }
}
```

>**1.5 资讯页面测试**
>测试之前必须是已登录状态，才可以顺利进入'资讯'页面，所以得先判断是否登录，如果没有登录的话 必须先登录
>
![info.gif](http://upload-images.jianshu.io/upload_images/1760826-1651cc4cae69d6f0.gif?imageMogr2/auto-orient/strip)


```
- (void)testInformation{
    NSInteger loginCount = 0;
    if([self isLogin]){//已经登陆
        NSLog(@"---> 开始测试资讯页面");
        XCUIElement *information = self.app.tabBars.buttons[@"资讯"];
        !information.exists?:[information tap];
        //点击
        XCUIElement *button = self.app.buttons[@"标签2"];
        [button tap];
        button = self.app.buttons[@"标签3"];
        [button tap];
        button = self.app.buttons[@"标签4"];
        [button tap];
        button = self.app.buttons[@"标签5"];
        [button tap];
        button = self.app.buttons[@"标签6"];
        [button tap];
        button = self.app.buttons[@"标签1"];
        [button tap];
        //滑动
        XCUIElement *swipeView = [self.app.scrollViews elementAtIndex:0];
        [swipeView swipeRight];
        [swipeView swipeLeft];
        [swipeView swipeLeft];
        [swipeView swipeLeft];
        [swipeView swipeLeft];
        [swipeView swipeLeft];
        [swipeView swipeLeft];

        NSLog(@"---> 资讯页面测试完成");
    }else{//未登陆
        XCTAssert((loginCount<MaxLoginNumber), @"");
        NSLog(@"---> 在资讯页面发现未登录 开始第 %@ 次登陆", @(loginCount));
        loginCount ++;
        //发起登陆
        [self testLogin];
        //继续测试资讯
        [self testInformation];
    }
}
```

###参考
[iOS UITests(自动化测试)常用类参考文档](http://www.jianshu.com/p/3b43e56c0a13)
[iOS 官方文档](https://developer.apple.com/reference/xctest/xcuiapplication?language=objc)
[本文Demo地址](https://github.com/ywdonga/iOSUITestsDemo)



