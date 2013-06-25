//
//  OptionOneViewController.m
//  ScrollViews
//
//  Created by Ryan Poolos on 6/24/13.
//  Copyright (c) 2013 PopArcade. All rights reserved.
//

#import "OptionOneViewController.h"

@interface OptionOneViewController () <UIScrollViewDelegate>
{
    ColorLabel *header;
    ColorLabel *menu;
}
@end

@implementation OptionOneViewController

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
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 144.0, 1024.0, 604.0)];
    [scrollView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.1]];
    [scrollView setContentSize:CGSizeMake(CGRectGetWidth(scrollView.frame), 2048.0)];
    [scrollView setDelegate:self];
    [self.view addSubview:scrollView];
    
    header = [[ColorLabel alloc] initWithFrame:CGRectMake(padding, padding, 1024.0 - (padding * 2.0), 188.0)];
    [header setBackgroundColor:[UIColor orangeColor]];
    [header setText:@"Header"];
    [scrollView addSubview:header];
    
    menu = [[ColorLabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(header.frame) + padding, 256.0 - (padding * 2.0), 480.0)];
    [menu setBackgroundColor:[UIColor greenColor]];
    [menu setText:@"Menu"];
    [scrollView addSubview:menu];
    
    ColorLabel *toolBar = [[ColorLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(menu.frame) + padding, CGRectGetMaxY(header.frame) + padding, 768.0 - (padding ), 44.0)];
    [toolBar setBackgroundColor:[UIColor yellowColor]];
    [toolBar setText:@"ToolBar"];
    [scrollView addSubview:toolBar];
    
    ColorLabel *content = [[ColorLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(menu.frame) + padding, CGRectGetMaxY(toolBar.frame) + padding, 768.0 - (padding), scrollView.contentSize.height - (CGRectGetMaxY(toolBar.frame) + (padding * 2.0)))];
    [content setBackgroundColor:[UIColor blueColor]];
    [content setText:@"Content"];
    [scrollView addSubview:content];

    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat threshold = CGRectGetMaxY(header.frame);
    CGFloat offset = scrollView.contentOffset.y;
    
    if (offset > threshold) {
        [menu setTransform:CGAffineTransformMakeTranslation(0.0, offset - threshold)];
    } else {
        [menu setTransform:CGAffineTransformIdentity];
    }
}

@end
