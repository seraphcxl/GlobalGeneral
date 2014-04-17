//
//  DCMulticastDelegatePool.m
//  GlobalGeneral
//
//  Created by Derek Chen on 4/17/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCMulticastDelegatePool.h"

@interface DCMulticastDelegatePool() {
}

- (NSString *)keyForObject:(NSObject *)aObject;

@end

@implementation DCMulticastDelegatePool{
    NSMapTable *_multicastDelegates;
}

DEFINE_SINGLETON_FOR_CLASS(DCMulticastDelegatePool);

- (id)init {
    if (self = [super init]) {
        _multicastDelegates = [NSMapTable strongToStrongObjectsMapTable];
    }
    return self;
}

- (void)setMulticastDelegate:(DCMulticastDelegate *)aMulticastDelegate forObject:(NSObject *)aObject {
    do {
        if (!aMulticastDelegate || !aObject || !_multicastDelegates) {
            break;
        }
        NSString *key = [self keyForObject:aObject];
        [_multicastDelegates setObject:aMulticastDelegate forKey:key];
    } while (NO);
}

- (void)removeMulticastDelegateForObject:(NSObject *)aObject {
    do {
        if (!aObject || !_multicastDelegates) {
            break;
        }
        NSString *key = [self keyForObject:aObject];
        [_multicastDelegates removeObjectForKey:key];
    } while (NO);
}

- (DCMulticastDelegate *)multicastDelegateForObject:(NSObject *)aObject {
    DCMulticastDelegate *result = nil;
    do {
        if (!aObject || !_multicastDelegates) {
            break;
        }
        NSString *key = [self keyForObject:aObject];
        result = [_multicastDelegates objectForKey:key];
    } while (NO);
    return result;
}

- (NSString *)keyForObject:(NSObject *)aObject {
    NSString *result = nil;
    do {
        if (!aObject) {
            break;
        }
        result = [NSString stringWithFormat:@"%p", aObject];
    } while (NO);
    return result;
}

@end
