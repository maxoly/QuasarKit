//
//  QSKAction.h
//  QuasarKit
//
//  Created by Massimo Oliviero on 29/10/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

@import Foundation;

@class QSKAction;

typedef void(^QSKActionBlock)(QSKAction *action, id params);

@interface QSKAction : NSObject

@property (nonatomic, readwrite, assign, getter=isRunning) BOOL running;
@property (nonatomic, readwrite, assign, getter=isFinished) BOOL finished;

@property (nonatomic, readwrite, copy) NSString *key;
@property (nonatomic, readwrite, copy) NSDate *enqueueDate;
@property (nonatomic, readwrite, copy) QSKActionBlock block;
@property (nonatomic, readwrite, copy) QSKActionBlock cancel;

+ (instancetype)actionWithKey:(NSString *)key block:(QSKActionBlock)block;
+ (instancetype)actionWithKey:(NSString *)key block:(QSKActionBlock)block cancel:(QSKActionBlock)cancel;

@end
