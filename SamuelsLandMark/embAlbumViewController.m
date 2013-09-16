//
//  ebGalleryViewController.m
//  quadrangle
//
//  Created by Evan Buxton on 4/3/13.
//  Copyright (c) 2013 neoscape. All rights reserved.
//

#import "embAlbumViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "embCollectionViewLayout.h"
#import "CVCell.h"

@interface embAlbumViewController ()
//@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSMutableArray* arr_AlbumData;
@property (nonatomic,strong) AppDelegate *appDelegate;
@end

@implementation embAlbumViewController

@synthesize collectionView;

#pragma mark - Gallery UICollection View
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	NSUInteger numGallSections = [albumSections count];
	NSLog(@"gallerySections %i",[albumSections count]);
	return numGallSections;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	NSDictionary *ggallDict = [albumSections objectAtIndex:section];
	NSArray *sectionAlbums = [ggallDict objectForKey:@"sectioninfo"];
	int galleryIndex = [sectionAlbums count];
	return  galleryIndex;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)ccollectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    SupplementaryView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SupplementaryView" forIndexPath:indexPath];
    
    if(kind == UICollectionElementKindSectionHeader){
        supplementaryView.backgroundColor = [UIColor clearColor];
		NSDictionary *gallDictionary = albumSections[indexPath.section]; // grab dict
		secTitle = [[gallDictionary objectForKey:@"SectionName"] uppercaseString];
		supplementaryView.label.text = secTitle;
    }
    
    return supplementaryView;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(50, 50);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)ccollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Setup cell identifier
    static NSString *cellIdentifier = @"xhCell";
//	UICollectionViewCell *theCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    xhCell *theCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
	NSDictionary *ggallDict = [_arr_AlbumData objectAtIndex:indexPath.section];
	NSArray *ggalleryArray = [ggallDict objectForKey:@"sectioninfo"];
	NSDictionary *aalbumDict = [ggalleryArray objectAtIndex:indexPath.row];
	NSMutableArray *imageCount = [[NSMutableArray alloc]initWithCapacity:1];
    
	[imageCount addObjectsFromArray:[aalbumDict objectForKey:@"images"]];
    
    [theCell.titleLabel setText:[aalbumDict objectForKey:@"albumcaption"]];
	theCell.cellThumb.image = [UIImage imageNamed:[aalbumDict objectForKey:@"albumthumb"]];
	theCell.imgFrame.image = [UIImage imageNamed:[aalbumDict objectForKey:@"albumframe"]];
	
//	if (imageCount.count>0) {
//		[cell.countLabel setText:[NSString stringWithFormat:@"%i",[imageCount count]]];
//		cell.countLabel.hidden=NO;
//	} else {
//		cell.countLabel.hidden=YES;
//	}
    NSLog(@"111111111111%@",theCell);
    return theCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	UIButton *tmp = [[UIButton alloc] init];
	int currentIndex = indexPath.section;
	tmp.tag = indexPath.row;
	[self clickOpen:tmp inSection:currentIndex];
}

#pragma mark - CLick Action
-(void)clickOpen:(id)sender inSection:(int)section {
	
    //	NSMutableArray *imageArr = [[NSMutableArray alloc] initWithCapacity:1];
    //	NSMutableArray *capArr = [[NSMutableArray alloc] initWithCapacity:1];
    //
    //	NSDictionary *ggallDict = [_arr_AlbumData objectAtIndex:section];
    //	NSArray *ggalleryArray = [ggallDict objectForKey:@"sectioninfo"];
    //	NSDictionary *aalbumDict = [ggalleryArray objectAtIndex:[sender tag]];
    //	[imageArr addObjectsFromArray:[aalbumDict objectForKey:@"images"]];
    //	[capArr addObjectsFromArray:[aalbumDict objectForKey:@"captions"]];
    //	localImages =  imageArr;
    //	localCaptions = [NSArray arrayWithArray:capArr];
    //
    //	localGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
    //	[_appDelegate.navigationController pushViewController:localGallery animated:YES];
	
	NSMutableArray *imageArr = [[NSMutableArray alloc] initWithCapacity:1];
	NSMutableArray *capArr = [[NSMutableArray alloc] initWithCapacity:1];
    
	NSDictionary *ggallDict = [_arr_AlbumData objectAtIndex:section];
	NSArray *ggalleryArray = [ggallDict objectForKey:@"sectioninfo"];
	NSDictionary *aalbumDict = [ggalleryArray objectAtIndex:[sender tag]];
	
    
	if ([[aalbumDict objectForKey:@"albumtype"] isEqualToString:@"film"]) {
		
		NSString *fileString = [[[aalbumDict objectForKey:@"film"] lastPathComponent] stringByDeletingPathExtension];
		NSString *extensionString = [[aalbumDict objectForKey:@"film"] pathExtension];
		NSLog(@"%@.%@",fileString,extensionString);
        
		[self playMovie:fileString ofType:extensionString];
		
	} else if ([[aalbumDict objectForKey:@"albumtype"] isEqualToString:@"image"]) {
		NSLog(@"image");
		[imageArr addObjectsFromArray:[aalbumDict objectForKey:@"images"]];
		[capArr addObjectsFromArray:[aalbumDict objectForKey:@"captions"]];
		localImages =  imageArr;
		localCaptions = [NSArray arrayWithArray:capArr];
		[self imageViewer:sender];
		localGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
		[_appDelegate.navigationController pushViewController:localGallery animated:YES];
		
        //	} else if ([ebgalleryItem.gallType isEqualToString:@"slideshow"]) {
        //
        //		[self slideViewer:nil];
		
	} else if ([[aalbumDict objectForKey:@"albumtype"] isEqualToString:@"pdf"]) {
		NSLog(@"pdf %@",[aalbumDict objectForKey:@"pdf"]);
		[self viewPDF:[aalbumDict objectForKey:@"pdf"]];
		
        //	}  else if ([ebgalleryItem.gallType isEqualToString:@"web"]) {
        //
        //		[self openWeb:ebgalleryItem.gallName]
	}
}

#pragma mark - Image gallery
#pragma mark FGalleryViewControllerDelegate Methods
- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery
{
    int num;
    //    if( gallery == localGallery ) {
    //		num = [localImages count];
    //	}
    //	else if( gallery == networkGallery ) {
    //		num = [networkImages count];
    //	}
	num = [localImages count];
	return num;
}

- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index
{
	if( gallery == localGallery ) {
		return FGalleryPhotoSourceTypeLocal;
	}
	else return FGalleryPhotoSourceTypeNetwork;
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index
{
    NSString *caption;
    if( gallery == localGallery ) {
        caption = [localCaptions objectAtIndex:index];
    }
	//    else if( gallery == networkGallery ) {
	//        caption = [networkCaptions objectAtIndex:index];
	//    }
	return caption;
}

- (NSString*)photoGallery:(FGalleryViewController*)gallery filePathForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return [localImages objectAtIndex:index];
}

- (void)handleTrashButtonTouch:(id)sender {
    // here we could remove images from our local array storage and tell the gallery to remove that image
    // ex:
    //[localGallery removeImageAtIndex:[localGallery currentIndex]];
}

- (void)handleEditCaptionButtonTouch:(id)sender {
    // here we could implement some code to change the caption for a stored image
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
	// nsarray of dictionaries (galleries)
	// Path to the plist (in the application bundle)
	NSString *path = [[NSBundle mainBundle] pathForResource:
					  _plistName ofType:@"plist"];
	// Build the array from the plist
	NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
	
	self.arr_AlbumData = array;
	albumSections = self.arr_AlbumData;
	
	_appDelegate = [AppDelegate appDelegate];
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(200, 180)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20.0f, 75.0f, 400.0f, 600.0f) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
//    UIColor * bgColor = [UIColor colorWithRed:67/255.0f green:22/255.0f blue:213/255.0f alpha:1.0f];
	[self.collectionView setBackgroundColor: [UIColor clearColor]];
	
//	[self.collectionView registerClass:[CVCell class] forCellWithReuseIdentifier:@"cvCell"];
    
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cvCell"];
    [self.collectionView registerClass:[xhCell class] forCellWithReuseIdentifier:@"xhCell"];
	[self.collectionView registerClass:[SupplementaryView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SupplementaryView"];
    [self.view addSubview: self.collectionView];
	_uiiv_Background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_backgroundName]];
//	[self.view insertSubview:_uiiv_Background belowSubview:self.collectionView];
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    [self initBackBtn];

}
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    
//	[self.collectionView setBackgroundColor:[UIColor redColor]];
//	
//	[self.collectionView registerClass:[CVCell class] forCellWithReuseIdentifier:@"cvCell"];
//	[self.collectionView registerClass:[SupplementaryView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SupplementaryView"];
//    
//	flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    [flowLayout setItemSize:CGSizeMake(200, 180)];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    [self.collectionView setCollectionViewLayout:flowLayout];
//	
//	// nsarray of dictionaries (galleries)
//	// Path to the plist (in the application bundle)
//	NSString *path = [[NSBundle mainBundle] pathForResource:
//					  _plistName ofType:@"plist"];
//	// Build the array from the plist
//	NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
//	
//	self.arr_AlbumData = array;
//	albumSections = self.arr_AlbumData;
//	
//	_appDelegate = [AppDelegate appDelegate];
//	
//	_uiiv_Background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_backgroundName]];
////	[self.view insertSubview:_uiiv_Background belowSubview:self.collectionView];
//    [self.view addSubview:_uiiv_Background];
//    NSLog(@"%@",[self.collectionView description]);
//    [self.view addSubview:self.collectionView];
//}
#pragma mark
#pragma mark Back Button
-(void)initBackBtn
{
    UIButton *backBtn = [[UIButton alloc] init];
    backBtn = [[UIButton alloc] init];
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backBtn setTitle:@"Back" forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(20.0f, 20.0f, 35.0f, 35.0f);
    [backBtn setBackgroundColor:[UIColor clearColor]];
//    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    backBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"ui_team_close.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToMainScreen:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview: backBtn];
    
}
-(void)backToMainScreen:(id)sender
{
    [UIView animateWithDuration:0.33f
                     animations:^{
                         self.view.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         [self.view removeFromSuperview];
                     }
     ];
}
#pragma mark
#pragma mark Open Websites
// TODO: add webcontroller

//- (IBAction)openWeb:(NSString*)thisWEB {
//
//	ebWebViewController *webViewController = [[ebWebViewController alloc]
//											  initWithNibName:@"ebWebViewController"
//											  bundle:nil];
//	[webViewController socialButton:thisWEB];
//	webViewController.title = thisWEB;
//    [self presentModalViewController:webViewController animated:YES];
//}
//
#pragma mark - SlideShow Viewer
// TODO: add slideshow controller
//-(void)slideViewer:(id)sender {
//
//	ebSlideViewController *vc = [[ebSlideViewController alloc] init];
//
//	UIButton *bbackButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	[bbackButton addTarget:self action:@selector(pop)forControlEvents:UIControlEventTouchDown];
//	[bbackButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"ui_btn_close.png"]] forState:UIControlStateNormal];
//	bbackButton.frame = CGRectMake(-3, -5, 76, 64);
//	[vc.view insertSubview:bbackButton atIndex:4];
//
//	CATransition* transition = [CATransition animation];
//	transition.duration = 0.33;
//	transition.type = kCATransitionFade;
//	transition.subtype = kCATransitionFromTop;
//
//	[self.navigationController.view.layer
//	 addAnimation:transition forKey:kCATransition];
//	[self.navigationController pushViewController:vc animated:NO];
//}

#pragma mark
#pragma mark Image Viewer

-(void)imageViewer:(id)sender {
	
    //	UIButton *tmpBtn = (UIButton*)sender;
    //
    //	galleryNameString = tmpBtn.titleLabel.text;
    //	tmpBtn.alpha = 0.6;
    //
    //	GalleryImagesViewController *vc = [[GalleryImagesViewController alloc] initWithGallery:[Gallery galleryNamed:galleryNameString]];
    //	[vc goToPageAtIndex:0 animated:NO];
    //
    //	CATransition* transition = [CATransition animation];
    //	transition.duration = 0.33;
    //	transition.type = kCATransitionFade;
    //	transition.subtype = kCATransitionFromTop;
    //
    //	[self.navigationController.view.layer
    //	 addAnimation:transition forKey:kCATransition];
    //	[self.navigationController pushViewController:vc animated:NO];
}

#pragma mark
#pragma mark PDF Viewer

-(void)viewPDF:(NSString*)thisPDF {
	
	NSLog(@"thisPDF %@",thisPDF);
    
	NSString *fileToOpen = [[NSBundle mainBundle] pathForResource:thisPDF ofType:@"pdf"];
	NSLog(@"fileToOpen %@",fileToOpen);
	NSURL *url = [NSURL fileURLWithPath:fileToOpen];
	
	doccontroller = [UIDocumentInteractionController interactionControllerWithURL:url];
	[self previewDocumentWithURL:url];
}

- (void)previewDocumentWithURL:(NSURL*)url
{
    UIDocumentInteractionController* preview = [UIDocumentInteractionController interactionControllerWithURL:url];
    preview.delegate = self;
    [preview presentPreviewAnimated:YES];
}
//======================================================================
- (void)documentInteractionControllerDidDismissOptionsMenu:(UIDocumentInteractionController *)controller{
}

//===================================================================
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
	return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
	return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
	return self.view.frame;
}


#pragma mark - External Monitor Detection
- (void)setupExternalScreen
{
	if ([[UIScreen screens] count] > 1)
    {
		[self setUpScreenConnectionNotificationHandlers];
        // Get the screen object that represents the external display.
        external_disp = [[UIScreen screens] objectAtIndex:1];
        // Get the screen's bounds so that you can create a window of the correct size.
        CGRect screenBounds = external_disp.bounds;
		
        external_wind = [[UIWindow alloc] initWithFrame:screenBounds];
        external_wind.screen = external_disp;
        // Set up initial content to display...
        // Show the window.
        external_wind.hidden = NO;
    }
}

#pragma mark - Movie Player
#pragma mark - PLAY MOVIE
-(void)playMovie:(NSString*)movieName ofType:(NSString*)extension {
	
	NSString *url = [[NSBundle mainBundle]
					 pathForResource:movieName
					 ofType:extension];
	
    _playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:url]];
	_playerViewController.view.frame = CGRectMake(0, 0, 1024, 768);
	
    _playerViewController.wantsFullScreenLayout = YES;
	//_playerViewController.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
	_playerViewController.moviePlayer.controlStyle =  MPMovieControlStyleNone;
	[_playerViewController.moviePlayer setAllowsAirPlay:YES];
	_playerViewController.moviePlayer.repeatMode = MPMovieRepeatModeOne;
	
	if (!external_wind) {
		[self setupExternalScreen];
	}
	if (external_wind) {
		[external_wind addSubview:_playerViewController.view];
		[self useCustomMovieControls];
	} else {
		[self.view addSubview:_playerViewController.view];
		[_playerViewController.moviePlayer play];
	}
	
	[[NSNotificationCenter defaultCenter] removeObserver:_playerViewController
													name:MPMoviePlayerPlaybackDidFinishNotification
												  object:_playerViewController.moviePlayer];
	
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(movieFinishedCallback:)
												 name:MPMoviePlayerPlaybackDidFinishNotification
											   object:_playerViewController.moviePlayer];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidecontrol)
												 name:MPMoviePlayerLoadStateDidChangeNotification
											   object:_playerViewController.moviePlayer];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDurationAvailableNotification)
												 name:MPMovieDurationAvailableNotification
											   object:_playerViewController.moviePlayer];
	
	[self.navigationController setNavigationBarHidden:YES animated:YES];
	[self.navigationController setToolbarHidden:YES animated:YES];
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)useCustomMovieControls
{
	// Create a category view and add it to the window.
	mpControlsView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 1024, 768)];
	[mpControlsView setBackgroundColor: [UIColor blackColor]];
	mpControlsView.alpha = 0.8;
	[self.view addSubview:mpControlsView];
	
	closeMovieButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
	[closeMovieButton setTitle:@"PAUSE" forState:UIControlStateNormal];
	CGRect frame = CGRectMake (512, 384, 90, 37);
	[closeMovieButton setFrame: frame];
	[closeMovieButton addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
	[mpControlsView addSubview:closeMovieButton];
	
	UIButton* closeMe = [UIButton buttonWithType: UIButtonTypeRoundedRect];
	[closeMe setTitle:@"CLOSE" forState:UIControlStateNormal];
	frame = CGRectMake (512, 430, 90, 37);
	[closeMe setFrame: frame];
	[closeMe addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
	[mpControlsView addSubview:closeMe];
	
	frame = CGRectMake(512, 530.0, 200.0, 10.0);
    progressIndicator = [[UISlider alloc] initWithFrame:frame];
    [progressIndicator addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [progressIndicator setBackgroundColor:[UIColor clearColor]];
    //progressIndicator.minimumValue = 0.0;
    //progressIndicator.maximumValue = 5000.0;
    progressIndicator.continuous = YES;
    //progressIndicator.value = 25.0;
	[mpControlsView addSubview:progressIndicator];
	
	[self monitorPlaybackTime];
}

- (IBAction)sliderAction: (UISlider*)sender
{
	_playerViewController.moviePlayer.currentPlaybackTime = totalVideoTime*progressIndicator.value;
}

-(void)pause {
	if (_playerViewController.moviePlayer.playbackState == MPMoviePlaybackStatePlaying) {
		[_playerViewController.moviePlayer pause];
		[closeMovieButton setTitle:@"PLAY" forState:UIControlStateNormal];
	} else {
		[_playerViewController.moviePlayer play];
		[closeMovieButton setTitle:@"PAUSE" forState:UIControlStateNormal];
		[self monitorPlaybackTime];
	}
}

-(void)remove {
    if ([[UIScreen screens] count] > 1) {
        // Hide and then delete the window.
		[_playerViewController.moviePlayer pause];
		external_wind.hidden = YES;
		external_wind = nil;
		[mpControlsView removeFromSuperview];
		[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(monitorPlaybackTime) object:nil];
	}
}

- (void)monitorPlaybackTime
{
	[[NSNotificationCenter defaultCenter] removeObserver:_playerViewController
													name:MPMovieDurationAvailableNotification
												  object:_playerViewController.moviePlayer];
	
	progressIndicator.value = _playerViewController.moviePlayer.currentPlaybackTime / totalVideoTime;
	//constantly keep checking if at the end of video:
	if (totalVideoTime != 0 && _playerViewController.moviePlayer.currentPlaybackTime >= totalVideoTime - 0.1)
	{
		//-------- rewind code:
		_playerViewController.moviePlayer.currentPlaybackTime = 0;
		[_playerViewController.moviePlayer pause];
	}
	else
	{
		[self performSelector:@selector(monitorPlaybackTime) withObject:nil afterDelay:0.5];
	}
}

- (void) handleDurationAvailableNotification
{
	totalVideoTime = _playerViewController.moviePlayer.duration;
	_playerViewController.moviePlayer.currentPlaybackTime = 0;
	[_playerViewController.moviePlayer play];
	NSLog(@"handleDurationAvailableNotification");
}

- (void)movieFinishedCallback:(NSNotification*)aNotification {
	NSLog(@"movieFinishedCallback");
    
	// Obtain the reason why the movie playback finished
    NSNumber *finishReason = [[aNotification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
	// Dismiss the view controller ONLY when the reason is not "playback ended"
    if ([finishReason intValue] != MPMovieFinishReasonPlaybackEnded)
    {
		NSLog(@"!!MPMovieFinishReasonPlaybackEnded");
        
		MPMoviePlayerController *moviePlayer = [aNotification object];
        // Remove this class from the observers
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:moviePlayer];
        // Dismiss the view controller
		[_playerViewController.view removeFromSuperview];
		_playerViewController = nil;
    } else {
		NSLog(@"else movieFinishedCallback");
        
		[_playerViewController.view removeFromSuperview];
		_playerViewController = nil;
	}
	
	if ([[UIScreen screens] count] > 1) {
		NSLog(@"window");
		// Hide and then delete the window.
		external_wind.hidden = YES;
		external_wind = nil;
		[mpControlsView removeFromSuperview];
		[[NSNotificationCenter defaultCenter] removeObserver:self
														name:MPMovieDurationAvailableNotification
													  object:_playerViewController.moviePlayer];
	} else {
		NSLog(@"who knows movieFinishedCallback");
        
		[_playerViewController.view removeFromSuperview];
		_playerViewController = nil;
	}
}

- (void)setUpScreenConnectionNotificationHandlers
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	
    [center addObserver:self selector:@selector(handleScreenDidConnectNotification:)
				   name:UIScreenDidConnectNotification object:nil];
    [center addObserver:self selector:@selector(handleScreenDidDisconnectNotification:)
				   name:UIScreenDidDisconnectNotification object:nil];
}

- (void)handleScreenDidConnectNotification:(NSNotification*)aNotification
{
    UIScreen *newScreen = [aNotification object];
    CGRect screenBounds = newScreen.bounds;
	
    if (!external_wind)
    {
        external_wind = [[UIWindow alloc] initWithFrame:screenBounds];
        external_wind.screen = newScreen;
		
        // Set the initial UI for the window.
    }
}

- (void)handleScreenDidDisconnectNotification:(NSNotification*)aNotification
{
    if ([[UIScreen screens] count] > 1)
    {
        // Hide and then delete the window.
        external_wind.hidden = YES;
        external_wind = nil;
    }
}

- (void)hidecontrol {
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:MPMoviePlayerNowPlayingMovieDidChangeNotification
												  object:_playerViewController];
	_playerViewController.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)moviePlaybackComplete:(NSNotification *)notification
{
	NSLog(@"moviePlaybackComplete");
    
	MPMoviePlayerController *moviePlayerController = [notification object];
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:MPMoviePlayerPlaybackDidFinishNotification
												  object:moviePlayerController];
}


- (void)viewWillAppear:(BOOL)animated {
    self.view.frame = [UIScreen mainScreen].applicationFrame;
    CGRect frame = self.navigationController.navigationBar.frame;
    frame.origin.y = 20;
    self.navigationController.navigationBar.frame = frame;
	self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidAppear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:NO animated:animated];
	[self.navigationController setToolbarHidden:YES animated:YES];
	[super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
