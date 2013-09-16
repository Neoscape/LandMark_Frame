//
//  ViewControllerModel.h
//  SamuelsLandMark
//
//  Created by Xiaohe Hu on 9/6/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewControllerModel : NSObject
{
    ViewControllerModel *vcModel;
}
@property (nonatomic, retain) NSString* vcName;
@property (nonatomic, retain) NSString* vcButtonName;
@property (nonatomic, strong) NSString* vcLogoType;

@end
