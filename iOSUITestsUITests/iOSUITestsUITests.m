//
//  iOSUITestsUITests.m
//  iOSUITestsUITests
//
//  Created by dyw on 2017/3/15.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import <XCTest/XCTest.h>

#define MaxLoginNumber 2 //最多循环登录次数
static NSInteger loginIndex = 0;//当前登录账号的下标

@interface iOSUITestsUITests : XCTestCase

/** 当前测试的APP */
@property (nonatomic, strong) XCUIApplication *app;
/** 测试账号集合 */
@property (nonatomic, strong) NSArray *accountArr;

@end

@implementation iOSUITestsUITests

- (void)setUp {
    [super setUp];
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    //关闭应用
    [app terminate];
    //重新启动引用
    [app launch];
    //启动参数
    NSArray *args = [app launchArguments];
    for(int i=0;i<args.count;i++){
        NSLog(@"arg :  %@",[args objectAtIndex:i]);
    }
    //启动环境
    NSDictionary *env = [app launchEnvironment];
    for (id key in env) {
        NSString *object=[env objectForKey:key];
        NSLog(@"env : %@",object);
    }
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    //在UI测试中，通常最好在出现故障时立即停止
    //失败后是否继续
    self.continueAfterFailure = NO;
    
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    //UI测试必须启动他们测试的应用程序。在安装程序中这样做会确保每个测试方法都会发生。
    [self.app launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    //把teardown代码在这里。该方法在类中的每个测试方法调用后调用。
    [super tearDown];
}

- (void)testExample{
    //整体测试
    [self allTestExample];    
}

/** 整体测试 */
- (void)allTestExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    //首页
    [self testHome];
    //登陆
    [self testLogin];
    //退出登陆
    [self testLogOut];
    //测试资讯
    [self testInformation];
    //测试我的
    [self testMine];
}

#pragma mark - 首页（未登录）
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

#pragma mark - 登陆
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

#pragma mark - 退出登陆
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


#pragma mark - 资讯
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

#pragma mark - 我的
- (void)testMine{
    NSInteger loginCount = 0;
    if([self isLogin]){//已经登陆
        NSLog(@"---> 开始测试我的页面");
        XCUIElement *information = self.app.tabBars.buttons[@"我的"];
        !information.exists?:[information tap];
        
        XCUIElement *tableView = [self.app.tables elementAtIndex:0];
        [tableView swipeDown];
        [tableView swipeUp];
        [tableView swipeDown];
        [tableView swipeUp];
        
        NSLog(@"---> 我的页面测试完成");
    }else{//未登陆
        XCTAssert((loginCount<MaxLoginNumber), @"");
        NSLog(@"---> 在我的页面发现未登录 开始第 %@ 次登陆", @(loginCount));
        loginCount ++;
        //发起登陆
        [self testLogin];
        //继续测试我的
        [self testMine];
    }
}



#pragma mark -辅助方法
/** 隐藏键盘 */
- (void)hindKeyBoard{
    XCUIElement *element = [[self.app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0];
    [element tap];
}
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

/** cell点击 */
- (void)cellTapAtIndex:(NSInteger)index withCells:(XCUIElementQuery *)cellQuery{
    XCUIElement *cellElement = [cellQuery elementAtIndex:index];
    !cellElement.exists?:[cellElement tap];
}

/** 弹窗点击 */
- (void)alertViewTap{
    sleep(0.5);
    XCUIElement *alertView = [self.app.alerts elementAtIndex:0];
    XCUIElement *alertButton = alertView.buttons[@"确定"];
    !alertButton.exists?:[alertButton tap];
}

- (XCUIApplication *)app{
    if(!_app){
        _app = [[XCUIApplication alloc] init];
    }
    return _app;
}

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

@end
