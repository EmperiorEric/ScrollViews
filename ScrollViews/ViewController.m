//
//  ViewController.m
//  ScrollViews
//
//  Created by Ryan Poolos on 6/4/13.
//  Copyright (c) 2013 PopArcade. All rights reserved.
//

#import "ViewController.h"

@interface ClipView : UIView

@end

@implementation ClipView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *scrollView = self.subviews.lastObject;
    
    if ([self pointInside:point withEvent:event]) {
        if ([scrollView hitTest:point withEvent:event]) {
            return [scrollView hitTest:point withEvent:event];
        }
        
        return scrollView;
    }
    
    return nil;
}

@end

//@interface ClipScrollView : UIScrollView
//
//@end
//
//@implementation ClipScrollView
//
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if ([self pointInside:point withEvent:event]) {
//        return self.subviews.lastObject;
//    }
//    
//    return nil;
//}
//
//@end

@interface ViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    UIScrollView *superScrollView;
    
    UIScrollView *leftScrollView;
    UIScrollView *rightScrollView;
    
    UIScrollView *topScrollView;
    
    BOOL scrollingSubView;
    
}

@end

/*
 
 The Requirements
 
 1. three scrollViews: one horizontal, two independent vertical.
 2. the horizontal needs to act like a searchbar, hiding above the fold when pushed up.
 3. each vertical scrollView needs to be capable of pushing the the horizontal above the fold before scrolling
    - If both verticals have a {0,0} offset and you push up on either
 3. each vertical when reaching the top of its content needs to pull the horizontal back down.
    - If both verticals have a {0,0} offset and you pull either further
 
 
 
 The less fancy alternative
 
 Have a single huge scrollView.
 There is a horizontal scrollView as a header
 The left nav is no longer independently scrollable.
    - This limits the ability of the left nav to extend
        beyond the height of the view because you couldn't
        show selection if it was below the old AND the
        first row of content from the selection.
 
 */

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGFloat headerHeight = 224.0;
    CGFloat padding = 8.0;
    
    ClipView *hackView = [[ClipView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(128.0, 0.0, 0.0, 0.0))];
    [hackView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.25]];
    [hackView setClipsToBounds:YES];
    [self.view addSubview:hackView];
    
    superScrollView = [[UIScrollView alloc] initWithFrame:hackView.bounds];//CGRectMake(0.0, 128.0, CGRectGetWidth(self.view.bounds), headerHeight)];//UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(128.0, 0.0, 0.0, 0.0))];
    [superScrollView setContentSize:CGSizeMake(CGRectGetWidth(superScrollView.frame), CGRectGetHeight(hackView.frame) + headerHeight)];
//    [superScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"128-189.jpg"]]];
    [superScrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [superScrollView setPagingEnabled:YES];
//    [superScrollView setScrollEnabled:NO];
    [superScrollView setClipsToBounds:NO];
    [superScrollView setDelegate:self];
    [hackView addSubview:superScrollView];
    
    topScrollView = [[UIScrollView alloc] initWithFrame:CGRectInset(CGRectMake(0.0, 0.0, CGRectGetWidth(superScrollView.frame), headerHeight), padding, padding)];
    [topScrollView setContentSize:CGSizeMake(CGRectGetWidth(topScrollView.frame) * 5.0, CGRectGetHeight(topScrollView.frame))];
    [topScrollView setBackgroundColor:[UIColor underPageBackgroundColor]];
    [topScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
    [topScrollView setDelegate:self];
    [superScrollView addSubview:topScrollView];
    
    CGFloat leftRightScrollViewHeight = CGRectGetHeight(hackView.frame) - (padding * 2.0);
    
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

#pragma mark - Sub ScrollView Logic

- (void)didBeginScrolling:(UIScrollView *)scrollView
{
    // Disable the SuperScrollView to ensure nothing funny happens
    [superScrollView setScrollEnabled:NO];
}

- (void)scrollView:(UIScrollView *)scrollView didChangeOffset:(CGFloat)offset
{
    [superScrollView setContentOffset:CGPointMake(0, superScrollView.contentOffset.y + offset)];
    
    [scrollView setContentOffset:CGPointZero];
}

- (void)didEndScrolling:(UIScrollView *)scrollView
{
    [superScrollView setScrollEnabled:YES];
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
        
        
        
//        // Did we just start dragging down
//        if (offset > 0.0 && !scrollingSubView) {
//            [self didBeginScrolling:scrollView];
//            scrollingSubView = YES;
//        }
//        
//        if (scrollingSubView) {
//            CGFloat scrollOffset = offset;
//            
//            [self scrollView:scrollView didChangeOffset:scrollOffset];
//        }

//        if (offset <= 0.0) {
//            // Stop scrolling when it reaches the top
//            [scrollView setScrollEnabled:NO];
//            
//            CGFloat delta = MIN(0, offset);
//            
//            // Keep the scrolling going on the superScrollView
//            // by adjust contentOffset by delta
//            [superScrollView setContentOffset:CGPointMake(superScrollView.contentOffset.x, superScrollView.contentOffset.y - offset)];
//        }

    }
}

//- (void)subScrollingEnded:(UIScrollView *)scrollView
//{    
//    // If the header is fully visible, we need to rest on it.
//    if (CGRectContainsRect(superScrollView.bounds, topScrollView.frame)) {
//        [superScrollView setContentOffset:CGPointZero];
//    }
//    
//    // if the header is not fully visible, we need to decide
//    // how visible it is and if we should hide or show it fully
//    else {
//        CGFloat headerLimit = CGRectGetMaxY(topScrollView.frame);
//        CGFloat percentInvisible = superScrollView.contentOffset.y/headerLimit;
//        
//        if (percentInvisible > 0.51) {
//            [superScrollView setContentOffset:CGPointMake(0, headerLimit)];
//        } else {
//            [superScrollView setContentOffset:CGPointZero];
//        }
//    }
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (!decelerate) {
//        if (scrollView == leftScrollView || scrollView == rightScrollView) {
//            [self subScrollingEnded:scrollView];
//        }
//    }
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if (scrollView == leftScrollView || scrollView == rightScrollView) {
//        [self subScrollingEnded:scrollView];
//    }
//}

@end
