//
//  QSKOperationQueue.h
//  QuasarKit
//
//  Created by Massimo Oliviero on 28/10/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

@import Foundation;

@class QSKLimiter;

@interface QSKOperationQueue : NSOperationQueue

@property (nonatomic, readonly, strong) QSKLimiter *limiter;

- (void)addThrottledOperation:(NSOperation *)operation;

@end
