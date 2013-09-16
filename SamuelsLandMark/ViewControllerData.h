//
//  ViewControllerData.h
//  SamuelsLandMark
//
//  Created by Xiaohe Hu on 9/6/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerModel.h"

@interface ViewControllerData : NSObject
{
    ViewControllerModel *vcModel;
}

@property (nonatomic, copy) NSMutableArray* arr_vcData;
@property (nonatomic, copy) NSMutableArray* arr_vcSectionData00;
@property (nonatomic, copy) NSMutableDictionary *dict_vcSectionData00;

@end
