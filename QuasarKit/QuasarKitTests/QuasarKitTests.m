//
//  QuasarKitTests.m
//  QuasarKitTests
//
//  Created by Massimo Oliviero on 28/10/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "QSKAction.h"
#import "QSKLimiter.h"

@interface QuasarKitTests : XCTestCase

@end

@implementation QuasarKitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLimiter {
    QSKLimiter *limiter = [[QSKLimiter alloc] init];
    limiter.strategy = QSKLimiterStrategyIgnorePreviousAction;
    limiter.startInterval = 30.0f;
    
    XCTAssert(limiter);
    XCTAssertEqual(limiter.strategy, QSKLimiterStrategyIgnorePreviousAction);
    XCTAssertEqual(limiter.startInterval, 30.0F);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        
        // Put the code you want to measure the time of here.
        QSKLimiter *limiter = [[QSKLimiter alloc] init];
        limiter.strategy = QSKLimiterStrategyIgnorePreviousAction;
        limiter.startInterval = 30.0f;
        
        [limiter enqueueAction:[QSKAction actionWithKey:@"key1" block:^(QSKAction *action, id params) {
            action.finished = YES;
        }]];
    }];
}

@end
