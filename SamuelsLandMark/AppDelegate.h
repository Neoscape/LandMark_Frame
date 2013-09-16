//
//  AppDelegate.h
//  SamuelsLandMark
//
//  Created by Xiaohe Hu on 9/6/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "ViewControllerData.h"

@class RootViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) NSMutableArray *arr_pageData;
@property (nonatomic, strong) RootViewController *rtViewContorller;


+ (AppDelegate *)appDelegate;

@end
