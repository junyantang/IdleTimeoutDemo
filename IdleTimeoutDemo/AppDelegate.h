//
//  AppDelegate.h
//  IdleTimeoutDemo
//
//  Created by User on 16/1/2016.
//  Copyright © 2016年 tjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IdleWindow.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) BOOL isLogin;

-(void) popLogin;
@end

