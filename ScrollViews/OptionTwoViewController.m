//
//  OptionTwoViewController.m
//  ScrollViews
//
//  Created by Ryan Poolos on 6/24/13.
//  Copyright (c) 2013 PopArcade. All rights reserved.
//

#import "OptionTwoViewController.h"

@interface OptionTwoViewController () <UIScrollViewDelegate>
{
    UIScrollView *mainScrollView;
    UIScrollView *menuScrollView;
    
    ColorLabel *header;
    ColorLabel *menu;
}
@end

@implementation OptionTwoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGFloat padding = 8.0;
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 144.0, 1024.0, 604.0)];
    [mainScrollView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.1]];
    [mainScrollView setContentSize:CGSizeMake(CGRectGetWidth(mainScrollView.frame), 2048.0)];
    [mainScrollView setDelegate:self];
    [self.view addSubview:mainScrollView];
    
    header = [[ColorLabel alloc] initWithFrame:CGRectMake(padding, padding, 1024.0 - (padding * 2.0), 188.0)];
    [header setBackgroundColor:[UIColor orangeColor]];
    [header setText:@"Header"];
    [mainScrollView addSubview:header];
        
    ColorLabel *toolBar = [[ColorLabel alloc] initWithFrame:CGRectMake(256.0, CGRectGetMaxY(header.frame) + padding, 768.0 - (padding ), 44.0)];
    [toolBar setBackgroundColor:[UIColor yellowColor]];
    [toolBar setText:@"ToolBar"];
    [mainScrollView addSubview:toolBar];
    
    ColorLabel *content = [[ColorLabel alloc] initWithFrame:CGRectMake(256.0, CGRectGetMaxY(toolBar.frame) + padding, 768.0 - (padding), mainScrollView.contentSize.height - (CGRectGetMaxY(toolBar.frame) + (padding * 2.0)))];
    [content setBackgroundColor:[UIColor blueColor]];
    [content setText:@"Content"];
    [mainScrollView addSubview:content];
    
    
    menuScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 144.0, 256.0, 604.0)];
    [menuScrollView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.1]];
    [menuScrollView setContentSize:CGSizeMake(CGRectGetWidth(menuScrollView.frame), 1024.0)];
    [menuScrollView setDelegate:self];
    [self.view addSubview:menuScrollView];
    
    menu = [[ColorLabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(header.frame) + padding, 256.0 - (padding * 2.0), menuScrollView.contentSize.height - (CGRectGetMaxY(header.frame) + (padding * 2.0)))];
    [menu setBackgroundColor:[UIColor greenColor]];
    [menu setText:@"Menu"];
    [menuScrollView addSubview:menu];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // mainScrollView pushed up with menu if both at top
    // menuScrollView pushed up with main if both at top
    
    // mainScrollView pulled down with menu if both near top (If not, scroll only menuScrollView until its near the top as well)
    // menuScrollView pulled down with main if both near top (If not, scroll only mainScrollView until its near the top as well)
    
    CGFloat menuOffset = menuScrollView.contentOffset.y;
    CGFloat mainOffset = mainScrollView.contentOffset.y;
    
    if (menuScrollView == scrollView) {
        CGFloat threshold = CGRectGetMaxY(header.frame);
        
        // This will pull the mainScrollView down with the menuScrollView if they are both at the top.
        if (mainOffset < threshold) {
            [mainScrollView setContentOffset:scrollView.contentOffset];
        }
        
//        // This will stop the menu at the top until the mainScrollView catches up
//        else if ((mainOffset > threshold) && menuOffset > CGRectGetMinY(menu.frame)) {
//            [menu setTransform:CGAffineTransformMakeTranslation(0.0, menuOffset)];
//        } else {
//            [menu setTransform:CGAffineTransformIdentity];
//        }
        
        
    } else {
        CGFloat threshold = CGRectGetMaxY(header.frame);
        
//        if (mainOffset < threshold && menuOffset > 0.0) {
//            [menuScrollView setContentOffset:scrollView.contentOffset];
//            [mainScrollView setContentOffset:CGPointMake(0.0, mainScrollView.contentOffset.y - mainOffset)];
//            
//        } else if (mainOffset < threshold) {
//            [menuScrollView setContentOffset:scrollView.contentOffset];
//        }
    }
    
//    CGFloat threshold = CGRectGetMaxY(header.frame);
//    CGFloat offset = scrollView.contentOffset.y;
//    
//    if (offset > threshold) {
//        [menu setTransform:CGAffineTransformMakeTranslation(0.0, offset - threshold)];
//    } else {
//        [menu setTransform:CGAffineTransformIdentity];
//    }
}

#pragma mark - Orientation Lock

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

@end
