//
//  ColorLabel.m
//  ScrollViews
//
//  Created by Ryan Poolos on 6/24/13.
//  Copyright (c) 2013 PopArcade. All rights reserved.
//

#import "ColorLabel.h"

@interface ColorLabel ()
{
    UIColor *accentColor;
    UIColor *fillColor;
}
@end

@implementation ColorLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer setBorderWidth:2.0];
        
        [self.layer setCornerRadius:8.0];
        
        [self setFont:[UIFont systemFontOfSize:24.0]];
        [self setTextAlignment:NSTextAlignmentCenter];
        [self setAdjustsLetterSpacingToFitWidth:YES];
        [self setAdjustsFontSizeToFitWidth:YES];
        [self setMinimumScaleFactor:0.1];
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [self setTextColor:backgroundColor];
    
    accentColor = [backgroundColor colorWithAlphaComponent:0.75];
    
    [self.layer setBorderColor:accentColor.CGColor];
    
    fillColor = [backgroundColor colorWithAlphaComponent:0.25];
    
    [super setBackgroundColor:fillColor];
}

@end
