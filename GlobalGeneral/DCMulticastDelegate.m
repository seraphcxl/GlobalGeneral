//
//  DCMulticastDelegate.m
//  GlobalGeneral
//
//  Created by Derek Chen on 4/3/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCMulticastDelegate.h"

@implementation DCMulticastDelegate {
    NSHashTable *_weakDelegates;
    NSHashTable *_strongDelegates;
    Protocol *_protocol;
}

- (id)initWithProtocol:(Protocol *)protocol {
    if (!protocol) {
        return nil;
    }
    if (self = [super init]) {
        _weakDelegates = [NSHashTable weakObjectsHashTable];
        _strongDelegates = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
        _protocol = protocol;
    }
    return self;
}

- (void)dealloc {
    do {
        NSLog(@"DCMulticastDelegate dealloc");
    } while (NO);
}

- (void)addWeakDelegate:(id)delegate {
    do {
        if (delegate) {
            if (![delegate conformsToProtocol:_protocol]) {
                break;
            }
            @synchronized(_weakDelegates) {
                [_weakDelegates addObject:delegate];
            }
        }
    } while (NO);
}

- (void)addStrongDelegate:(id)delegate {
    do {
        if (delegate) {
            if (![delegate conformsToProtocol:_protocol]) {
                break;
            }
            @synchronized(_strongDelegates) {
                [_strongDelegates addObject:delegate];
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
        
        @synchronized(_strongDelegates) {
            // if any of the delegates respond to this selector, return YES
            for (id delegate in _strongDelegates) {
                if ([delegate respondsToSelector:aSelector]) {
                    result = YES;
                    break;
                }
            }
            if (result) {
                break;
            }
        }
        
        @synchronized(_weakDelegates) {
            // if any of the delegates respond to this selector, return YES
            for (id delegate in _weakDelegates) {
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
            @synchronized(_strongDelegates) {
                BOOL find = NO;
                for (id delegate in _strongDelegates) {
                    if ([delegate respondsToSelector:aSelector]) {
                        signature = [delegate methodSignatureForSelector:aSelector];
                        find = YES;
                        break;
                    }
                }
                if (find) {
                    break;
                }
            }
            
            @synchronized(_weakDelegates) {
                BOOL find = NO;
                for (id delegate in _weakDelegates) {
                    if ([delegate respondsToSelector:aSelector]) {
                        signature = [delegate methodSignatureForSelector:aSelector];
                        find = YES;
                        break;
                    }
                }
                if (find) {
                    break;
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
        @synchronized(_strongDelegates) {
            // forward the invocation to every delegate
            for(id delegate in _strongDelegates) {
                if ([delegate respondsToSelector:[anInvocation selector]]) {
                    [anInvocation invokeWithTarget:delegate];
                }
            }
        }
        
        @synchronized(_weakDelegates) {
            // forward the invocation to every delegate
            for(id delegate in _weakDelegates) {
                if ([delegate respondsToSelector:[anInvocation selector]]) {
                    [anInvocation invokeWithTarget:delegate];
                }
            }
        }
    } while (NO);
}

@end
