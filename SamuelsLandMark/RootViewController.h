//
//  RootViewController.h
//  framework_SL
//
//  Created by Xiaohe Hu on 9/9/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerData.h"
#import "AppDelegate.h"
#import "ebSimpleScrollView.h"
#import "embAlbumViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface RootViewController : UIViewController <ebSimpleScrollViewDelegate>
{
    NSArray                 *delegatePageArray;
    NSDictionary            *dict_delegatePageArray;
	ViewControllerModel     *vcObject;
    int                     vcObjectIndex;
    
    ebSimpleScrollView      *uis_buildingImgs;
}

@property (nonatomic, strong) UIButton *uib_building;
@property (nonatomic, strong) UIButton *uib_neighborhood;
@property (nonatomic, strong) UIButton *uib_gallery;
@property (nonatomic, strong) NSMutableArray *arr_viewControllers;
@property (nonatomic, strong) UIViewController *controller;
@end
