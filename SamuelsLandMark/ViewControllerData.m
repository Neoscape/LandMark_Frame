//
//  ViewControllerData.m
//  SamuelsLandMark
//
//  Created by Xiaohe Hu on 9/6/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import "ViewControllerData.h"

@implementation ViewControllerData
@synthesize arr_vcData;
@synthesize arr_vcSectionData00,dict_vcSectionData00;

- (id) init
{
    if (self = [super init]){
        
		arr_vcSectionData00 = [NSMutableArray arrayWithCapacity:4];
		

		
		vcModel = [[ViewControllerModel alloc] init];
		vcModel.vcButtonName=@"Neighborhood";
		vcModel.vcName = @"embAlbumViewController";
		vcModel.vcLogoType = @"logo-color-white-box-grdnt-flip.png";
		[arr_vcSectionData00 addObject:vcModel];
        
        vcModel = [[ViewControllerModel alloc] init];
		vcModel.vcButtonName=@"Gallery";
		vcModel.vcName = @"embAlbumViewController";
		vcModel.vcLogoType = @"logo-color-white-box-grdnt-flip.png";
		[arr_vcSectionData00 addObject:vcModel];
		

		dict_vcSectionData00 = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"0", @"vcArrayIndex",
                                @"View Controllers", @"vcArrayName",
                                arr_vcSectionData00, @"vcArrayData",
                                nil];
        
		self.arr_vcData = [NSArray arrayWithObjects:dict_vcSectionData00, nil];
    }
    return self;
}
@end
