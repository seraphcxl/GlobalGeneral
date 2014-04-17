//
//  DCTestTextViewDelegate.m
//  GlobalGeneral
//
//  Created by Derek Chen on 4/17/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCTestTextViewDelegate.h"

@implementation DCTestTextViewDelegate

#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    do {
        NSLog(@"DCTestTextViewDelegate textViewDidBeginEditing:");
    } while (NO);
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    do {
        NSLog(@"DCTestTextViewDelegate textViewDidEndEditing:");
    } while (NO);
}
@end
