//
//  DCTestTextFieldDelegate.m
//  GlobalGeneral
//
//  Created by Derek Chen on 4/17/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCTestTextFieldDelegate.h"

@implementation DCTestTextFieldDelegate

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    do {
        NSLog(@"DCTestTextFieldDelegate textFieldDidBeginEditing:");
    } while (NO);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    do {
        NSLog(@"DCTestTextFieldDelegate textFieldDidEndEditing:");
    } while (NO);
}

@end
