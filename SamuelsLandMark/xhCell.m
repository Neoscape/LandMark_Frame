//
//  xhCell.m
//  framework_SL
//
//  Created by Xiaohe Hu on 9/12/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import "xhCell.h"

@implementation xhCell

@synthesize titleLabel = _titleLabel;
//@synthesize countLabel = _countLabel;
@synthesize cellThumb = _cellThumb;
@synthesize imgFrame = _imgFrame;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"xhCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
    }
    
    return self;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
