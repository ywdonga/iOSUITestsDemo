//
//  InformationViewController.m
//  iOSUITests
//
//  Created by dyw on 2017/3/15.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import "InformationViewController.h"

#define WW [UIScreen mainScreen].bounds.size.width

@interface InformationViewController ()

@property (weak, nonatomic) IBOutlet UIView *buttonBackView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UIScrollView Delegate
//减速停止了时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offSetX = scrollView.contentOffset.x;
    NSInteger page = offSetX/WW + 1;
    for (UIButton *btn in self.buttonBackView.subviews) {
        btn.selected = (btn.tag == page);
    }
}


- (IBAction)buttonClick:(UIButton *)sender {
    for (UIButton *btn in self.buttonBackView.subviews) {
        btn.selected = NO;
    }
    sender.selected = YES;
    [self.scrollView setContentOffset:CGPointMake((sender.tag-1)*WW, 0) animated:YES];
}



@end
