//
//  QSKLimiter.m
//  QuasarKit
//
//  Created by Massimo Oliviero on 28/10/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "QSKLimiter.h"

#import "QSKAction.h"


@interface QSKLimiter ()

@property (nonatomic, readwrite, strong) NSTimer *timer;
@property (nonatomic, readwrite, strong) dispatch_queue_t queue;
@property (nonatomic, readwrite, strong) NSMutableArray *actions;

@end


@implementation QSKLimiter

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Properties

- (NSMutableArray *)actions {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _actions = [[NSMutableArray alloc] init];
    });
    
    return _actions;
}

- (dispatch_queue_t)queue {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _queue = dispatch_queue_create("QuasarKit.QSKLimiter", DISPATCH_QUEUE_SERIAL);
    });
    
    return _queue;
}

#pragma mark - Polling

- (void)startPolling {
    if (!self.timer) {
        self.timer = [NSTimer timerWithTimeInterval:0.1f target:self selector:@selector(dispatch:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)dispatch:(NSTimer *)timer {
    __weak typeof(self) weakSelf = self;
    
    dispatch_sync(self.queue, ^{
        NSArray *actionsToRemove = [weakSelf.actions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isFinished == YES"]];
        [weakSelf.actions removeObjectsInArray:actionsToRemove];
        NSLog(@"actionsToRemove: %zd", actionsToRemove.count);
        
        NSArray *actions = [weakSelf.actions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isRunning == NO"]];
        
        for (QSKAction *action in actions) {
            NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:action.enqueueDate];
            if (interval > weakSelf.startInterval) {
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@ && isRunning == YES", action.key];
                QSKAction *cancellableAction = [[weakSelf.actions filteredArrayUsingPredicate:predicate] firstObject];
                
                if (cancellableAction && cancellableAction.cancel) {
                    cancellableAction.finished = YES;
                    cancellableAction.cancel(cancellableAction, nil);
                    NSLog(@"CANCELED old action");
                }
                
                if (action.block) {
                    action.running = YES;
                    action.block(action, nil);
                    NSLog(@"RUN new action");
                }
            }
        }
        
        if (weakSelf.actions.count == 0) {
            [weakSelf.timer invalidate];
            weakSelf.timer = nil;
        }
    });
}

#pragma mark - Methods

- (void)enqueueAction:(QSKAction *)action {
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(self.queue, ^{
        [weakSelf startPolling];
        
        QSKAction *oldAction = [[weakSelf.actions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"key == %@", action.key]] firstObject];
        
        if (!oldAction.isRunning) {
            if (weakSelf.strategy == QSKLimiterStrategyIgnoreLastAction && oldAction) {
                NSLog(@"last action discarded");
                return;
            }
            
            if (weakSelf.strategy == QSKLimiterStrategyIgnorePreviousAction && oldAction) {
                [weakSelf.actions removeObject:oldAction];
            }
        }
        
        action.enqueueDate = [NSDate date];
        [weakSelf.actions addObject:action];
        
        NSLog(@"action enqueue - %@", (oldAction ? @"overwrite the old one" : @"a new action"));
    });
}

@end
