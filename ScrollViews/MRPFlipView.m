//
//  RPFlipView.m
//  ScrollViews
//
//  Created by Ryan Poolos on 6/23/13.
//  Copyright (c) 2013 PopArcade. All rights reserved.
//

#import "MRPFlipView.h"

@interface MRPFlipView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *scrollContainerView;
@property (nonatomic, strong) UIView *flipContainerView;

@end

@implementation MRPFlipView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame) * 2.0, CGRectGetHeight(self.scrollView.frame))];
}

#pragma mark - Views

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        
        [_scrollView setDelegate:self];
        
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        
        [_scrollView setClipsToBounds:NO];
        
        [_scrollView setPagingEnabled:YES];
        
        [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(_scrollView.frame) * 2.0, CGRectGetHeight(_scrollView.frame))];
        
        [self addSubview:_scrollView];
    }
    
    return _scrollView;
}

- (UIView *)scrollContainerView
{
    if (!_scrollContainerView) {
        _scrollContainerView = [[UIView alloc] initWithFrame:self.scrollView.bounds];
        [_scrollContainerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        [self.scrollView addSubview:_scrollContainerView];
    }
    
    return _scrollContainerView;
}

- (UIView *)flipContainerView
{
    if (!_flipContainerView) {
        _flipContainerView = [[UIView alloc] initWithFrame:self.scrollContainerView.bounds];
        [_flipContainerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        [self.scrollContainerView addSubview:_flipContainerView];
    }
    
    return _flipContainerView;
}

- (UIView *)frontView
{
    if (!_frontView) {
        _frontView = [[UIView alloc] initWithFrame:self.flipContainerView.bounds];
        [_frontView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        [_frontView setBackgroundColor:[UIColor whiteColor]];
        [_frontView setClipsToBounds:YES];
        
        [self.flipContainerView addSubview:_frontView];
    }
    
    return _frontView;
}

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:self.flipContainerView.bounds];
        [_backView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        
        [_backView setBackgroundColor:[UIColor whiteColor]];
        [_backView setClipsToBounds:YES];
        [_backView setHidden:YES];
        
        [self.flipContainerView addSubview:_backView];
    }
    
    return _backView;
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(flipViewWillBeginDragging:)]) {
        [self.delegate flipViewWillBeginDragging:self];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Make sure the container doesn't scroll
    [self.scrollContainerView setTransform:CGAffineTransformMakeTranslation(scrollView.contentOffset.x, 0.0)];
    
    // Calculate a flip based on scrollView offset
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / 800.0;
    transform = CATransform3DRotate(transform, M_PI * (scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame)), 0.0, 1.0, 0.0);
    [self.flipContainerView.layer setTransform:transform];
    
    // Show appropriate content
    [self.frontView setHidden:(scrollView.contentOffset.x >= (CGRectGetWidth(scrollView.frame) / 2.0))];
    [self.backView setHidden:!(scrollView.contentOffset.x >= (CGRectGetWidth(scrollView.frame) / 2.0))];
    
    // Record
    self.flipped = (scrollView.contentOffset.x >= (CGRectGetWidth(scrollView.frame) / 2.0));
}

@end
