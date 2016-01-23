//
//  MainViewController.m
//  IdleTimeoutDemo
//
//  Created by User on 16/1/2016.
//  Copyright © 2016年 tjy. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)viewDidAppear:(BOOL)animated{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if (!delegate.isLogin) {
        [delegate popLogin];
    }
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

- (IBAction)logout:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.isLogin = NO;
    IdleWindow *idleWindow = (IdleWindow *)appDelegate.window;
    
    //stop moniter timeout and pop login
    [idleWindow stop];
    [appDelegate popLogin];
}


@end
