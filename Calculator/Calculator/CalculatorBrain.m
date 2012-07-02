//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Lion User on 01/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic, strong) NSMutableArray* operands;

@end

@implementation CalculatorBrain
@synthesize operands = _operands;


-(NSMutableArray*) operands {
    if (!_operands) {
        _operands = [[NSMutableArray alloc] init];
    }
    return _operands;
}

-(void)pushOperand:(double)operand {
    
    NSNumber* number = [NSNumber numberWithDouble:operand];
    [[self operands] addObject:number];
    
}

-(double) getOperand {
    
    NSNumber * number = [[self operands] lastObject];
    if (number) [[self operands] removeLastObject];
    return [number doubleValue];
}

-(double)performOperation:(NSString *)operation {
    
    double result = 0;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self getOperand] + [self getOperand];
    }
    else if ([operation isEqualToString:@"-"]) {
        double secondOperand = [self getOperand];
        result = [self getOperand] - secondOperand;
    }
    else if ([operation isEqualToString:@"*"]) {
        result = [self getOperand] * [self getOperand];
    }
    else if ([operation isEqualToString:@"/"]) {
        double divisor = [self getOperand];
        if (divisor) result = [self getOperand] / divisor;
    }
    else if ([operation isEqualToString:@"sin"]) {
        result = sin([self getOperand] * M_PI / 180);
    }
    else  if ([operation isEqualToString:@"cos"]) {
        result = cos([self getOperand] * M_PI / 180);
    }
    else  if ([operation isEqualToString:@"sqrt"]) {
        double number = [self getOperand];
        if (number > 0) {
            result = sqrt(number);
        }
    }
    else if ([operation isEqualToString:@"pi"]) {
        result = M_PI;
    }
    
    [self pushOperand:result];
    
    return result;
    
}

-(void) resetBrain {
    [[self operands] removeAllObjects];
}

@end
