//
//  ebSimpleScrollView.m
//  quadrangle
//
//  Created by Evan Buxton on 6/28/13.
//  Copyright (c) 2013 neoscape. All rights reserved.
//

#import "ebSimpleScrollView.h"
#import "SMPageControl.h"
#import "UIView+NeoUtilities.h"

@interface ebSimpleScrollView () <UIScrollViewDelegate>
@property (nonatomic, strong, readonly) UIScrollView *uis_scrollView;
@property (nonatomic, strong) UIImageView *uiiv_infoView;
@property (nonatomic, strong) UIView *uiv_scrollHolder;
@property (strong, nonatomic) SMPageControl* uis_pageControl;
@property (strong, nonatomic) UIButton *h;
@end

@implementation ebSimpleScrollView

@synthesize uis_scrollView = _uis_scrollView;
@synthesize uiiv_infoView = _uiiv_infoView;
@synthesize uiv_scrollHolder = _uiv_scrollHolder;
@synthesize delegate;

-(void)baseInit
{
	_withButton=YES;
	
}

- (id)initWithFrame:(CGRect)frame closeBtnLoc:(CGRect)btnFrame btnImg:(NSString*)btnNamed boolBtn:(BOOL)showBtn bgImg:(NSString*)bgNamed andArray:(NSArray*)images andTag:(int)myTag
{
	self = [super initWithFrame:frame];
	if (self) {
			[self baseInit];
		if (nil == _uiv_scrollHolder) {
			NSLog(@"settip");
			_withButton=YES;
			_uiv_scrollHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
			[_uiv_scrollHolder setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:bgNamed]]];

			// setup scrollview
			_uis_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _uiv_scrollHolder.frame.size.width, _uiv_scrollHolder.frame.size.height)];
			self.uis_scrollView.tag = myTag;
			//Pinch Zoom Stuff
			_uis_scrollView.maximumZoomScale = 4.0;
			_uis_scrollView.minimumZoomScale = 1.0;
			_uis_scrollView.clipsToBounds = YES;
			_uis_scrollView.delegate = self;
			_uis_scrollView.scrollEnabled = YES;
			_uis_scrollView.pagingEnabled = YES;
			
			[_uiv_scrollHolder addSubview:_uis_scrollView];
			NSArray *imageArray = images;
			
			if (imageArray.count>1) {
				_uis_pageControl = [[SMPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-65, 200, 100)];
				
				_uis_pageControl.pageIndicatorImage = [UIImage imageNamed:@"grfx_dot_Off"];
				_uis_pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"grfx_dot_On"];
				_uis_pageControl.alignment = SMPageControlAlignmentCenter;
				[_uiv_scrollHolder insertSubview:_uis_pageControl aboveSubview:_uis_scrollView];
				_uis_pageControl.numberOfPages = imageArray.count;
				_uis_pageControl.centerX = frame.size.width/2;
			}
			
			for (int i = 0; i < imageArray.count; i++) {
				CGRect framee;
				framee.origin.x = self.uis_scrollView.frame.size.width * i;
				framee.origin.y = 0;
				framee.size = self.uis_scrollView.frame.size;
				
				UIImageView *subview = [[UIImageView alloc] initWithFrame:framee];
				[subview setContentMode:UIViewContentModeScaleToFill];
				subview.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
				[self.uis_scrollView addSubview:subview];
			}
			[self addSubview:_uiv_scrollHolder];
			
			self.uis_scrollView.contentSize = CGSizeMake(self.uis_scrollView.frame.size.width*imageArray.count, self.uis_scrollView.frame.size.height);
		
			NSLog(@"_withButton = %@\n", (_withButton ? @"YES" : @"NO"));

			if (showBtn==YES) {
				_h = [UIButton buttonWithType:UIButtonTypeCustom];
				_h.frame = btnFrame;
				NSLog(@"_btnBG %@",_btnBG);
				_h.titleLabel.text = @"X";
				//_h.frame = CGRectMake(self.frame.size.width-73, -5, 73, 68);
				[_h setBackgroundImage:[UIImage imageNamed:btnNamed] forState:UIControlStateNormal];
				[_h setBackgroundImage:[UIImage imageNamed:btnNamed] forState:UIControlStateHighlighted];
				//set their selector using add selector
				[_h addTarget:self action:@selector(didRemove) forControlEvents:UIControlEventTouchUpInside];
				[self insertSubview:_h aboveSubview:self];
			}
		}
	}
	return self;
}

-(void)zoomableScrollview:(id)sender withImage:(UIImageView*)thisImage
{
	//NSLog(@"sender tag %i",[sender tag]);
		
//	UITapGestureRecognizer *tap2Recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomMyPlan:)];
//	[tap2Recognizer setNumberOfTapsRequired:2];
//	[tap2Recognizer setDelegate:self];
//	[_scrollView addGestureRecognizer:tap2Recognizer];
	
	//NSLog(@"%@ render",renderImageView);
	
	[self.uis_scrollView setContentMode:UIViewContentModeScaleAspectFit];
	self.uis_scrollView.frame = CGRectMake(0, 0, 1024, 768);
	[_uis_scrollView addSubview:thisImage];
	
	UIButton *h = [UIButton buttonWithType:UIButtonTypeCustom];
	h.frame = CGRectMake(1024-20-33, 768-20-33, 33, 33);
	[h setTitle:@"X" forState:UIControlStateNormal];
	h.titleLabel.font = [UIFont fontWithName:@"ArialMT" size:14];
	[h setBackgroundImage:[UIImage imageNamed:@"ui_btn_mm_default.png"] forState:UIControlStateNormal];
	[h setBackgroundImage:[UIImage imageNamed:@"ui_btn_mm_select.png"] forState:UIControlStateHighlighted];
	[h setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	//set their selector using add selector
	[h addTarget:self action:@selector(removeRenderScroll:) forControlEvents:UIControlEventTouchUpInside];
	[_uiv_scrollHolder insertSubview:h aboveSubview:self];
	
	self.uis_scrollView.contentSize = CGSizeMake(self.uis_scrollView.frame.size.width, self.uis_scrollView.frame.size.height);
	
	_uiv_scrollHolder.transform = CGAffineTransformMakeScale(1.5, 1.5);
	_uiv_scrollHolder.alpha=0.0;
	[self addSubview:_uiv_scrollHolder];
	
	UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction  | UIViewAnimationOptionCurveEaseInOut;
	
	[UIView animateWithDuration:0.3 delay:0.0 options:options
					 animations:^{
						 _uiv_scrollHolder.alpha=1.0;
						 _uiv_scrollHolder.transform = CGAffineTransformIdentity;
					 }
					 completion:^(BOOL  completed){
					 }];
	
}

-(void)hideScroll:(id)sender {
//	UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction  | UIViewAnimationOptionCurveEaseInOut;
//	
//	CGRect transformedBounds = CGRectApplyAffineTransform(_uiv_scrollHolder.bounds, _uiv_scrollHolder.transform);
//	NSLog(@"%@",NSStringFromCGRect(transformedBounds));
//
//	if (transformedBounds.origin.x==-420) {
//		[UIView animateWithDuration:0.3 delay:0.0 options:options
//						 animations:^{
//							 //_h.transform = CGAffineTransformIdentity;
//							 //_h.alpha=1.0;
//							 self.transform = CGAffineTransformIdentity;
//							 self.alpha=1.0;
//							 NSLog(@"%@",NSStringFromCGRect(transformedBounds));						 }
//						 completion:^(BOOL  completed){
//						 }];
//	} else {
//		NSLog(@"%@",NSStringFromCGRect(transformedBounds));
//
//		[UIView animateWithDuration:0.3 delay:0.0 options:options
//						 animations:^{
//							 self.alpha=0.0;
//							 // _h.alpha=0.0;
//							self.frame = CGRectMake(-420, 0, self.frame.size.width, self.frame.size.height);
//							 // _h.transform = CGAffineTransformMakeTranslation(-420, 0);
//						 }
//						 completion:^(BOOL  completed){
//							 
//							 _h = [UIButton buttonWithType:UIButtonTypeCustom];
//							 _h.frame = CGRectMake(0, 0, 73, 68);
//							 [_h setBackgroundImage:[UIImage imageNamed:@"ui_avail_btn.png"] forState:UIControlStateNormal];
//							 [_h setBackgroundImage:[UIImage imageNamed:@"ui_avail_btn.png"] forState:UIControlStateHighlighted];
//							 //set their selector using add selector
//							 [_h addTarget:self action:@selector(hideScroll:) forControlEvents:UIControlEventTouchUpInside];
//							 [self insertSubview:_h aboveSubview:self];
//							 
//						 }];
//	}	
}

#pragma mark - scrollview - building info for hotspots

- (void)scrollViewDidScroll:(UIScrollView *)sender {
	int page = [self currenScrollPage:sender];
	self.uis_pageControl.currentPage = page;
	//_uis_pageControl.hidden=YES;
    //NSLog(@"\n\n\n%i", page);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
	self.uis_pageControl.currentPage = page;
    [self currentImageAtIndex:page fromSender:scrollView];
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
	int page = scrollView.contentOffset.x / scrollView.frame.size.width;
	self.uis_pageControl.currentPage = page;
}

- (void)currentImageAtIndex:(NSUInteger)index fromSender:(UIScrollView*)scroll
{
    [self.delegate currentImageAtIndex:index fromSender:scroll];
}


-(int)currenScrollPage:(UIScrollView*)scroll
{
	int page = scroll.contentOffset.x / scroll.frame.size.width;
	self.uis_pageControl.currentPage = page;
	//NSLog(@"%i currenScrollPage",page);
	return page;
}

//-(int)didEndScrollPageIndex:(UIScrollView *)sender
//{
//    int page = sender.contentOffset.x / sender.frame.size.width;
//    return page;
//}

#pragma mark - Delegate methods
-(void)didRemove {
    // send message the message to the delegate!
    [delegate didRemove:self];
}

@end
