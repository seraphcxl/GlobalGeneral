//
//  DCMulticastDelegate.m
//  GlobalGeneral
//
//  Created by Derek Chen on 4/3/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCMulticastDelegate.h"

@implementation DCMulticastDelegate {
    NSMutableArray *_delegates;
    Protocol *_protocol;
}

- (id)initWithProtocol:(Protocol *)protocol {
    if (!protocol) {
        return nil;
    }
    if (self = [super init]) {
        _delegates = [NSMutableArray array];
        _protocol = protocol;
    }
    return self;
}

- (void)addDelegate:(id)delegate {
    do {
        if (delegate) {
            if (![delegate conformsToProtocol:_protocol]) {
                break;
            }
            @synchronized(_delegates) {
                [_delegates addObject:delegate];
            }
        }
    } while (NO);
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL result = NO;
    do {
        if ([super respondsToSelector:aSelector]) {
            result = YES;
            break;
        }
        
        @synchronized(_delegates) {
            // if any of the delegates respond to this selector, return YES
            for (id delegate in _delegates) {
                if ([delegate respondsToSelector:aSelector]) {
                    result = YES;
                    break;
                }
            }
            if (result) {
                break;
            }
        }
    } while (NO);
    return result;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    // can this class create the signature?
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    do {
        // if not, try our delegates
        if (!signature) {
            @synchronized(_delegates) {
                for (id delegate in _delegates) {
                    if ([delegate respondsToSelector:aSelector]) {
                        signature = [delegate methodSignatureForSelector:aSelector];
                    }
                }
            }
        }
    } while (NO);
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    do {
        if (!anInvocation) {
            break;
        }
        @synchronized(_delegates) {
            // forward the invocation to every delegate
            for(id delegate in _delegates) {
                if ([delegate respondsToSelector:[anInvocation selector]]) {
                    [anInvocation invokeWithTarget:delegate];
                }
            }
        }
    } while (NO);
}

@end
