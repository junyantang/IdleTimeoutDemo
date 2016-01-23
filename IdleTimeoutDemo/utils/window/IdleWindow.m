//
//  IdleWindow.m
//  IdleTimeoutDemo
//
//  Created by User on 16/1/2016.
//  Copyright © 2016年 tjy. All rights reserved.
//

#import "IdleWindow.h"

NSString * const IdleNotification = @"IdleNotification";

@interface IdleWindow()

@property (nonatomic) BOOL isStart;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;

@end

@implementation IdleWindow

@synthesize isStart,idleTimeInterval,idleTimer;

#pragma mark - life cycle
- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.idleTimeInterval = 10;
        self.isStart = NO;
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return self;
}

#pragma mark - override window function
- (void)sendEvent:(UIEvent *)event {
    [super sendEvent:event];
    
    if (isStart) {
        NSSet *allTouches = [event allTouches];
        if ([allTouches count] > 0) {
            
            NSLog(@"refresh time");
            
            // To reduce timer resets only reset the timer on a Began or Ended touch.
            UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase;
            if (phase == UITouchPhaseBegan || phase == UITouchPhaseEnded) {
                //stop old timer
                if (idleTimer) {
                    [idleTimer invalidate];
                }
                //start new timer
                if (idleTimeInterval != 0) {
                    self.idleTimer = [NSTimer scheduledTimerWithTimeInterval:idleTimeInterval
                                                                      target:self
                                                                    selector:@selector(postIdleNotification)
                                                                    userInfo:nil repeats:NO];
                }
            }
        }
    }
}

#pragma mark - public function
-(void) start{
    //start refred
    isStart = YES;
    //set up timer
    self.idleTimer = [NSTimer scheduledTimerWithTimeInterval:idleTimeInterval
                                                      target:self
                                                    selector:@selector(postIdleNotification)
                                                    userInfo:nil repeats:NO];
}

-(void) stop{
    //stop refresh
    isStart = NO;
    //invalid timer
    if (idleTimer) {
        [idleTimer invalidate];
        idleTimer = nil;
    }
}

-(void) pause{
    if (isStart) {
        if (idleTimer) {
            NSDate *fireDate = idleTimer.fireDate;
            
            NSString *dateStr = [self.dateFormatter stringFromDate:fireDate];
            NSLog(@"date %@",dateStr);
            
            //save fire time in document
            //get document path
            NSString *idleFilePath = [self getIdleFilePath];
            NSLog(@"idleFilePath path :%@",idleFilePath);
            NSError *error=nil;
            [dateStr writeToFile:idleFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
            
            if (error) {
                NSLog(@"write error %@",error);
            }
            
            //stop timer
            [idleTimer invalidate];
            idleTimer = nil;
        }
    }
}

-(void) resume{
    NSString *idleFilePath = [self getIdleFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //check idle timout file if exist
    if ([fileManager fileExistsAtPath:idleFilePath]) {
        //read idle timeout file
        NSError *error=nil;
        NSString *idleTime = [NSString stringWithContentsOfFile:idleFilePath encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            NSLog(@"read error %@",error);
        }else{
            //delete file
            [fileManager removeItemAtPath:idleFilePath error:&error];
            if (error) {
                NSLog(@"delete error %@",error);
            }
            
            //reset timeout timer
            NSLog(@"content %@",idleTime);
            NSDate *date = [self.dateFormatter dateFromString:idleTime];
            NSLog(@"resume date is %@",date);
            self.idleTimer = [NSTimer scheduledTimerWithTimeInterval:idleTimeInterval
                                                              target:self
                                                            selector:@selector(postIdleNotification)
                                                            userInfo:nil repeats:NO];
            //resume fire date
            [self.idleTimer setFireDate:date];
        }
    }
}

#pragma mark - private function
- (void)postIdleNotification {
    NSLog(@"postIdleNotification");
    //stop refresh
    isStart = NO;
    //invalidate timer
    if (idleTimer) {
        [idleTimer invalidate];
        idleTimer = nil;
    }
    //send notification
    NSNotificationCenter *dnc = [NSNotificationCenter defaultCenter];
    [dnc postNotificationName:IdleNotification
                       object:self
                     userInfo:nil];
    self.idleTimer = nil;
}

-(NSString *) getIdleFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *idleFilePath = [NSString stringWithFormat:@"%@/idleTime",documentDirectory];
    
    return idleFilePath;
}

@end
