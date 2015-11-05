//
//  QSKAction.m
//  QuasarKit
//
//  Created by Massimo Oliviero on 29/10/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "QSKAction.h"

@implementation QSKAction

+ (instancetype)actionWithKey:(NSString *)key block:(QSKActionBlock)block {
    return [self actionWithKey:key block:block cancel:nil];
}

+ (instancetype)actionWithKey:(NSString *)key block:(QSKActionBlock)block cancel:(QSKActionBlock)cancel {
    QSKAction *action = [[self alloc] init];
    action.key = key;
    action.block = block;
    action.cancel = cancel;
    return action;
}

@end
