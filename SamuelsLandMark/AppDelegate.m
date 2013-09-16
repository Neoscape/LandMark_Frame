//
//  AppDelegate.m
//  SamuelsLandMark
//
//  Created by Xiaohe Hu on 9/6/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    self.rtViewContorller = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    
    _navigationController = [[UINavigationController alloc]
							 initWithRootViewController:self.rtViewContorller];
	[_navigationController setNavigationBarHidden:YES];
	[_navigationController.navigationBar setTintColor:[UIColor blackColor]];
	self.window.rootViewController = _navigationController;
    self.window.rootViewController = _navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)initAppViewControllerArrays
{
	ViewControllerData *pageData = [[ViewControllerData alloc] init];
	_arr_pageData = pageData.arr_vcData;
}


+ (AppDelegate *)appDelegate
{
    AppDelegate *theDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return theDelegate;
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
