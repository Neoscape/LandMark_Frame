//
//  ebSimpleScrollView.h
//  quadrangle
//
//  Created by Evan Buxton on 6/28/13.
//  Copyright (c) 2013 neoscape. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ebSimpleScrollView;

@protocol ebSimpleScrollViewDelegate
@optional
-(void)didRemove:(ebSimpleScrollView *)customClass;
- (void)currentImageAtIndex:(NSUInteger)index fromSender:(UIScrollView*)scroll;
@end

@interface ebSimpleScrollView : UIScrollView <UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
	CGFloat maximumZoomScale;
	CGFloat minimumZoomScale;
}
- (id)initWithFrame:(CGRect)frame closeBtnLoc:(CGRect)btnFrame btnImg:(NSString*)btnNamed boolBtn:(BOOL)showBtn bgImg:(NSString*)bgNamed andArray:(NSArray*)images andTag:(int)myTag;
-(int)currenScrollPage:(UIScrollView*)scroll;

// define delegate property
@property (nonatomic, assign) id  delegate;

// default is slide
@property NSUInteger startIndex;
@property BOOL withButton;
@property (nonatomic, strong) NSString* btnBG;
// define public functions
-(void)didRemove;

@end

