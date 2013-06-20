//
//  ViewController.m
//  ScrollViews
//
//  Created by Ryan Poolos on 6/4/13.
//  Copyright (c) 2013 PopArcade. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    UIScrollView *superScrollView;
    
    UIScrollView *leftScrollView;
    UIScrollView *rightScrollView;
    
    UIScrollView *topScrollView;
    
    BOOL scrollingSubView;
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGFloat headerHeight = 224.0;
    CGFloat padding = 8.0;
    
    superScrollView = [[UIScrollView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(128.0, 0.0, 0.0, 0.0))];
    [superScrollView setContentSize:CGSizeMake(CGRectGetWidth(superScrollView.frame), CGRectGetHeight(superScrollView.frame) + headerHeight)];
    [superScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"128-189.jpg"]]];
    [superScrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [superScrollView setDelegate:self];
    [self.view addSubview:superScrollView];
    [superScrollView setScrollEnabled:NO];
    
    topScrollView = [[UIScrollView alloc] initWithFrame:CGRectInset(CGRectMake(0.0, 0.0, CGRectGetWidth(superScrollView.frame), headerHeight), padding, padding)];
    [topScrollView setContentSize:CGSizeMake(CGRectGetWidth(topScrollView.frame) * 5.0, CGRectGetHeight(topScrollView.frame))];
    [topScrollView setBackgroundColor:[UIColor underPageBackgroundColor]];
    [topScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
    [topScrollView setDelegate:self];
    [superScrollView addSubview:topScrollView];
    
    CGFloat leftRightScrollViewHeight = CGRectGetHeight(superScrollView.frame) - (padding * 2.0);
    
    leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(padding, headerHeight, 256.0 - (padding * 2.0), leftRightScrollViewHeight)];
    [leftScrollView setContentSize:CGSizeMake(CGRectGetWidth(leftScrollView.frame), CGRectGetHeight(leftScrollView.frame) * 5.0)];
    [leftScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"128-190.jpg"]]];
    [leftScrollView setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin];
    [leftScrollView setDelegate:self];
    [superScrollView addSubview:leftScrollView];
    
    rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftScrollView.frame) + padding, headerHeight, CGRectGetWidth(superScrollView.frame) - CGRectGetWidth(leftScrollView.frame) - (padding * 3.0), leftRightScrollViewHeight)];
    [rightScrollView setContentSize:CGSizeMake(CGRectGetWidth(rightScrollView.frame), CGRectGetHeight(rightScrollView.frame) * 5.0)];
    [rightScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"128-191.jpg"]]];
    [rightScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
    [rightScrollView setDelegate:self];
    [superScrollView addSubview:rightScrollView];
}

#pragma mark - UIScrollView Delegate



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == superScrollView) {
        
    } else if (scrollView == topScrollView) {
        
    } else if (scrollView == leftScrollView || scrollView == rightScrollView) {
        /*
         
         if super offset < height of header section
         then scroll super until its not.
         
         once super offset == height of header (meaning header is no longer visible)
         begin scrolling normally
         
         */
        
        CGFloat offset = scrollView.contentOffset.y;
        
        CGFloat superOffset = superScrollView.contentOffset.y;
        if (superOffset <= CGRectGetMaxY(topScrollView.frame)) {
            // Scroll superScrollView by content offset
            [superScrollView setContentOffset:CGPointMake(superScrollView.contentOffset.x, superScrollView.contentOffset.y + offset)];
            
            // Don't scroll subScrollView
            [scrollView setContentOffset:CGPointZero];
        } else if (offset <= 0.0) {
            // Scroll superScrollView by content offset
            [superScrollView setContentOffset:CGPointMake(superScrollView.contentOffset.x, superScrollView.contentOffset.y + offset)];
            
            // Don't scroll subscrollView
            [scrollView setContentOffset:CGPointZero];
        }
        

    }
}

@end
