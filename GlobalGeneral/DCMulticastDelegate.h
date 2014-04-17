//
//  DCMulticastDelegate.h
//  GlobalGeneral
//
//  Created by Derek Chen on 4/3/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCMulticastDelegate : NSObject

- (id)initWithProtocol:(Protocol *)protocol;

- (void)addWeakDelegate:(id)delegate;

- (void)addStrongDelegate:(id)delegate;

@end
