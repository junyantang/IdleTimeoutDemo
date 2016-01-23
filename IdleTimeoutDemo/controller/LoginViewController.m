//
//  LoginViewController.m
//  IdleTimeoutDemo
//
//  Created by User on 16/1/2016.
//  Copyright © 2016年 tjy. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "IdleWindow.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
- (IBAction)login:(id)sender {
    NSLog(@"login");
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    delegate.isLogin = YES;
    
    //start moniter idle time out
    IdleWindow *idleWindow = (IdleWindow *)delegate.window;
    [idleWindow start];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
