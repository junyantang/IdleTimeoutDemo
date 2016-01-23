//
//  IdleWindow.h
//  IdleTimeoutDemo
//
//  - IdleWindow - control idle time out
//  -- core function
//  -- 1. start - start monitor time after login
//  -- 2. stop - stop monitor time after logout
//  -- 3. pause - pause monitor when resign active
//  -- 4. resume - resume monitor when reactive
//
//  Created by User on 16/1/2016.
//  Copyright © 2016年 tjy. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const IdleNotification;

@interface IdleWindow : UIWindow

@property (nonatomic) NSTimeInterval idleTimeInterval;
@property (nonatomic, strong) NSTimer *idleTimer;

-(void) start;
-(void) stop;
-(void) pause;
-(void) resume;

@end
