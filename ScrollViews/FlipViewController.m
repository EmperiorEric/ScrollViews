//
//  FlipViewController.m
//  ScrollViews
//
//  Created by Ryan Poolos on 6/23/13.
//  Copyright (c) 2013 PopArcade. All rights reserved.
//

#import "FlipViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FlipViewController () <UIScrollViewDelegate>
{
    UIScrollView *theScrollView;
    
    UIView *view;
    UIView *subView;
}
@end

@implementation FlipViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.99 alpha:1.0]];
    
    theScrollView = [[UIScrollView alloc] initWithFrame:CGRectInset(self.view.bounds, 160.0, 320.0)];
    [theScrollView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin];
    
    [theScrollView setDelegate:self];
    
    [theScrollView setClipsToBounds:NO];
    [theScrollView setShowsHorizontalScrollIndicator:NO];
    
    [theScrollView setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
    
    [theScrollView setPagingEnabled:YES];
    
    [theScrollView setContentSize:CGSizeMake(CGRectGetWidth(theScrollView.frame) * 2.0, CGRectGetHeight(theScrollView.frame))];
    
    [self.view addSubview:theScrollView];

    view = [[UIView alloc] initWithFrame:CGRectInset(theScrollView.bounds, 4.0, 4.0)];
    [theScrollView addSubview:view];
    
    subView = [[UIView alloc] initWithFrame:view.bounds];
    [subView.layer setCornerRadius:4.0];
    [subView setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.35]];
    [view addSubview:subView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [view setTransform:CGAffineTransformMakeTranslation(scrollView.contentOffset.x, 0.0)];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / 800.0;
    transform = CATransform3DRotate(transform, M_PI * (scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame)), 0.0, 1.0, 0.0);
    [subView.layer setTransform:transform];
    
    if (scrollView.contentOffset.x >= (CGRectGetWidth(scrollView.frame) / 2.0)) {
        [subView setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.35]];
    } else {
        [subView setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.35]];
    }
}

@end
