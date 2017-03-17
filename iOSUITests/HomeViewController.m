//
//  HomeViewController.m
//  iOSUITests
//
//  Created by dyw on 2017/3/15.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *secmentInfoLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *a1;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *a2;
@property (weak, nonatomic) IBOutlet UIProgressView *prView;

@end

@implementation HomeViewController

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
- (IBAction)segmentedValueChange:(UISegmentedControl *)sender {
    self.secmentInfoLabel.text = sender.selectedSegmentIndex?@"Segmented右边":@"Segmented左边";
}

- (IBAction)swichValueChange:(UISwitch *)sender {
    sender.isOn?[self.a1 startAnimating]: [self.a1 stopAnimating];
    sender.isOn?[self.a2 startAnimating]: [self.a2 stopAnimating];
}

- (IBAction)stepperValueChange:(UIStepper *)sender {
    
    self.prView.progress = sender.value/10.0;
}

@end
