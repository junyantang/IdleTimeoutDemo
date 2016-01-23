//
//  AppDelegate.m
//  IdleTimeoutDemo
//
//  Created by User on 16/1/2016.
//  Copyright © 2016年 tjy. All rights reserved.
//

#import "AppDelegate.h"
#import "IdleWindow.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - life cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.isLogin = NO;
    
    IdleWindow *windowTmp = [[IdleWindow alloc] init];
    [windowTmp setRootViewController:self.window.rootViewController];
    self.window = windowTmp;
    windowTmp.idleTimeInterval = 30;
    NSLog(@"window %@",self.window);
    
    //add notification
    NSNotificationCenter *nnc = [NSNotificationCenter defaultCenter];
    
    [nnc addObserver:self selector:@selector(idleTimeout) name:IdleNotification object:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [(IdleWindow *)self.window pause];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [(IdleWindow *)self.window resume];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - notification

-(void) popLogin{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    [self.window.rootViewController presentViewController:loginViewController animated:YES completion:nil];
}

-(void) idleTimeout{
    
    NSLog(@"Idle la");
    WS(weakSelf);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Timeout" message:@"Timeout Message" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Timeout" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf popLogin];
    }];
    
    [alertController addAction:alertAction];
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end
