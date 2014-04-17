//
//  DCViewController.m
//  GlobalGeneral
//
//  Created by Derek Chen on 4/17/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCViewController.h"

#import "DCMulticastDelegate.h"
#import "DCMulticastDelegatePool.h"
#import "DCTestTextFieldDelegate.h"
#import "DCTestTextViewDelegate.h"

@interface DCViewController ()

@end

@implementation DCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    DCTestTextFieldDelegate *textFieldDelegate = [[DCTestTextFieldDelegate alloc] init];
    
    DCTestTextViewDelegate *textViewDelegate = [[DCTestTextViewDelegate alloc] init];
    
    DCMulticastDelegate *multiDelegate = [[DCMulticastDelegate alloc] initWithProtocol:@protocol(UITextFieldDelegate)];
    
    [multiDelegate addStrongDelegate:textFieldDelegate];
    [multiDelegate addStrongDelegate:textViewDelegate];
    [multiDelegate addWeakDelegate:self];
    
    [[DCMulticastDelegatePool sharedDCMulticastDelegatePool] setMulticastDelegate:multiDelegate forObject:self.textField];
    
    self.textField.delegate = multiDelegate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    do {
        NSLog(@"DCViewController textFieldDidBeginEditing:");
    } while (NO);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    do {
        NSLog(@"DCViewController textFieldDidEndEditing:");
    } while (NO);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    do {
        [textField resignFirstResponder];
    } while (NO);
    return YES;
}
@end
