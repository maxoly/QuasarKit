//
//  QSKLimiter.h
//  QuasarKit
//
//  Created by Massimo Oliviero on 28/10/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

@import Foundation;

@class QSKAction;



/**
 *  Strategy enum.
 */
typedef NS_ENUM(NSInteger, QSKLimiterStrategy) {
    /**
     *  Limiter allow to enqueue actions with the same key.
     */
    QSKLimiterStrategyAllowDuplicate,
    
    /**
     *  Limiter discard last action if there is already enqueued action with the same key.
     */
    QSKLimiterStrategyIgnoreLastAction,
    
    /**
     *  Limiter discard the previous action if the last enqueued action has the same key.
     */
    QSKLimiterStrategyIgnorePreviousAction,
};



@interface QSKLimiter : NSObject

@property (nonatomic, readwrite, assign) NSTimeInterval startInterval;
@property (nonatomic, readwrite, assign) QSKLimiterStrategy strategy;

- (void)enqueueAction:(QSKAction *)action;

@end
