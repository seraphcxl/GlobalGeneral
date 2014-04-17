//
//  DCMulticastDelegatePool.h
//  GlobalGeneral
//
//  Created by Derek Chen on 4/17/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCSingletonTemplate.h"

@class DCMulticastDelegate;

@interface DCMulticastDelegatePool : NSObject

DEFINE_SINGLETON_FOR_HEADER(DCMulticastDelegatePool);

- (void)setMulticastDelegate:(DCMulticastDelegate *)aMulticastDelegate forObject:(NSObject *)aObject;
- (void)removeMulticastDelegateForObject:(NSObject *)aObject;
- (DCMulticastDelegate *)multicastDelegateForObject:(NSObject *)aObject;

@end
