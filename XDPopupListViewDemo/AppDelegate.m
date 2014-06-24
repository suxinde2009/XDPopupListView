//
//  AppDelegate.m
//  XDPopupListViewDemo
//
//  Created by su xinde on 14-6-25.
//  Copyright (c) 2014年 su xinde. All rights reserved.
//

#import "AppDelegate.h"
#import "MyViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    MyViewController *vc = [[[MyViewController alloc] initWithNibName:@"MyViewController" bundle:nil] autorelease];
    self.window.rootViewController = vc;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
