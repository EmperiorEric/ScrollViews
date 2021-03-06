//
//  AppDelegate.m
//  ScrollViews
//
//  Created by Ryan Poolos on 6/4/13.
//  Copyright (c) 2013 PopArcade. All rights reserved.
//

#import "AppDelegate.h"
#import "OptionTwoViewController.h"

#import "ViewController.h"
#import "OptionOneViewController.h"

/* 
 
Option One - The Easiest
 
 Option One represents a simple scrollView with mostly stationary subviews.
 - A large header at the top
 - A stationary view on the left (stationary after header is hidden)
 - A toolbar area for search bar and filters
 - The key content area that would be filled with cells

Option Two represents one scrollView that covers the screen, with a second layer on top.
 - A large scrollView
    - A stationary header
    - A stationary toolbar
    - content area filled with cells
 - A small scrollview layered above
    - Menu
 
 Option Two represents one 
 
 
 
 */



#define OPTION 1

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
   
    
#if OPTION == 1
    self.window.rootViewController = [[OptionOneViewController alloc] init];
#elif OPTION == 2
    self.window.rootViewController = [[OptionTwoViewController alloc] init];
#else
    self.window.rootViewController = [[ViewController alloc] init];
#endif
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
