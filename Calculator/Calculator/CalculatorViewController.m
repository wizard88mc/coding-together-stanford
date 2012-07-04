//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Lion User on 29/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *messagesBrain;
@property (nonatomic) BOOL userIsInTheMiddleOfTypingANumber;
@property (nonatomic) BOOL userIsInTheMiddleOfTypingAFloatingPointNumber;
@property (nonatomic) int operationShowed;
@property (strong, nonatomic) CalculatorBrain* brain;

@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize messagesBrain = _messagesBrain;
@synthesize userIsInTheMiddleOfTypingANumber = _userIsInTheMiddleOfTypingANumber;
@synthesize userIsInTheMiddleOfTypingAFloatingPointNumber = _userIsInTheMiddleOfTypingAFloatingPointNumber;
@synthesize brain = _brain;
@synthesize operationShowed = _operationShowed;

-(CalculatorBrain*) brain {
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

-(void) addMessageBrainLabel:(NSString*)message {
    
    self.operationShowed++;
    NSString* current = [[self messagesBrain] text];
    // Maximum number of operation showed is 5;
    if ([self operationShowed] > 1) {
        NSRange range = [current rangeOfString:@" "];
        NSString* substring = [[[self messagesBrain] text] substringToIndex:range.location];
        
        current = [current stringByReplacingOccurrencesOfString:substring withString:@""];
    }
    [[self messagesBrain] setText:[current stringByAppendingFormat:@"%@ ", message]];
    
}

- (IBAction)digitPressed:(UIButton*)sender {
    
    if ([self userIsInTheMiddleOfTypingANumber]) {
        NSString* digit = [sender currentTitle];
    
        [[self display] setText:[[[self display] text] stringByAppendingString:digit]];
    }
    else {
        [self setUserIsInTheMiddleOfTypingANumber:YES];
        [[self display] setText:[sender currentTitle]];
    }
}
- (IBAction)pointPressed {
    if (![self userIsInTheMiddleOfTypingAFloatingPointNumber]) {
        [[self display] setText: [[[self display] text] stringByAppendingString: @"."]];
        
        [self setUserIsInTheMiddleOfTypingAFloatingPointNumber:YES];
    }
}

- (IBAction)enterPressed {
    
    NSString * digit = [[self display] text];
    [[self brain] pushOperand:[digit doubleValue]];
    NSLog(@"Digit:%@", digit);
    [self addMessageBrainLabel:digit];
    
    [self setUserIsInTheMiddleOfTypingANumber:NO];
    [self setUserIsInTheMiddleOfTypingAFloatingPointNumber:NO];
}

- (IBAction)operationPressed:(UIButton*)sender {
    
    if ([self userIsInTheMiddleOfTypingANumber]) {
        [self enterPressed];
    }
    [self addMessageBrainLabel:[sender currentTitle]];
    double result = [[self brain] performOperation:[sender currentTitle]];
    [[self display] setText: [NSString stringWithFormat:@"%g", result]];
}

- (IBAction)resetCalculator {
    
    [self setUserIsInTheMiddleOfTypingAFloatingPointNumber:NO];
    [self setUserIsInTheMiddleOfTypingANumber: NO];
    [[self display] setText: @"0"];
    [[self messagesBrain] setText:@""];
    [[self brain] resetBrain];
}



- (void)viewDidUnload {
    [self setMessagesBrain:nil];
    [super viewDidUnload];
}
@end
