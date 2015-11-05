//
//  QSKOperationQueue.m
//  QuasarKit
//
//  Created by Massimo Oliviero on 28/10/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "QSKOperationQueue.h"

#import "QSKAction.h"
#import "QSKLimiter.h"

@interface QSKOperationQueue ()

@property (nonatomic, readwrite, strong) QSKLimiter *limiter;

@end

@implementation QSKOperationQueue

- (QSKLimiter *)limiter {
    if (!_limiter) {
        _limiter = [[QSKLimiter alloc] init];
        _limiter.startInterval = 0.5f;
        _limiter.strategy = QSKLimiterStrategyIgnorePreviousAction;
    }
    
    return _limiter;
}

- (void)addThrottledOperation:(NSOperation *)operation {
    __weak typeof(self) weakSelf = self;
    
    [self.limiter enqueueAction:[QSKAction actionWithKey:operation.name block:^(QSKAction *action, id params) {
        operation.completionBlock = ^(){
            action.finished = YES;
        };
        
        if (!operation.isCancelled) {
            [weakSelf addOperation:operation];
        } else {
            action.finished = YES;
        }
    } cancel:^(QSKAction *action, id params) {
        [operation cancel];
    }]];
}

@end
