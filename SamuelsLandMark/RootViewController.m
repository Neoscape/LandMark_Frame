//
//  RootViewController.m
//  framework_SL
//
//  Created by Xiaohe Hu on 9/9/13.
//  Copyright (c) 2013 Xiaohe Hu. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) AppDelegate     *appDelegate;

@property (nonatomic, strong) NSMutableArray  *arr_buildingImgs;

@property (nonatomic, strong) embAlbumViewController* albumGallery;

@property (nonatomic, strong) embAlbumViewController* mapGallery;

@property (nonatomic, strong) UIImageView     *uiiv_mainMenuBg;

@end

@implementation RootViewController

@synthesize arr_viewControllers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    _appDelegate = [AppDelegate appDelegate];
//    delegatePageArray = _appDelegate.arr_pageData;
    [self initbg];
    [self initButtons];
}

#pragma -mark Init buttons
-(void)initbg
{
    _uiiv_mainMenuBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_menu.jpg"]];
    [self.view addSubview:_uiiv_mainMenuBg];
}

-(void)initButtons
{
    _uib_building = [[UIButton alloc] init];
    _uib_building = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_uib_building setTitle:@"Building" forState:UIControlStateNormal];
    _uib_building.frame = CGRectMake(155.0f, 50.0f, 350.0f, 380.0f);
    [_uib_building setBackgroundColor:[UIColor clearColor]];
//    [_uib_building setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _uib_building.tag = 1;
    [_uib_building addTarget:self action:@selector(loadVC:) forControlEvents:UIControlEventTouchDown ];
    
//    _uib_building.alpha = 0.6f;
    
    [self.view addSubview: _uib_building];
    
    _uib_neighborhood = [[UIButton alloc] init];
    _uib_neighborhood = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_uib_neighborhood setTitle:@"Neighborhood" forState:UIControlStateNormal];
    _uib_neighborhood.frame = CGRectMake(155.0f, 450.0f, 350.0f, 280.0f);
    [_uib_neighborhood setBackgroundColor:[UIColor clearColor]];
//    [_uib_neighborhood setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _uib_neighborhood.tag = 2;
    [_uib_neighborhood addTarget:self action:@selector(loadVC:) forControlEvents:UIControlEventTouchDown ];
//    _uib_neighborhood.alpha = 0.6f;
    
    [self.view addSubview: _uib_neighborhood];
    
    _uib_gallery = [[UIButton alloc] init];
    _uib_gallery = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_uib_gallery setTitle:@"Gallery" forState:UIControlStateNormal];
    _uib_gallery.frame = CGRectMake(510.0f, 380.0f, 360.0f, 280.0f);
    [_uib_gallery setBackgroundColor:[UIColor clearColor]];
//    [_uib_gallery setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _uib_gallery.tag = 3;
    [_uib_gallery addTarget:self action:@selector(loadVC:) forControlEvents:UIControlEventTouchDown ];
    
//    _uib_gallery.alpha = 0.6f;
    
    [self.view addSubview: _uib_gallery];
}

-(void)setDataForMenuObject:(int)index
{
	vcObject = self.arr_viewControllers[index];
}


#pragma -mark Init ScrView for Building
-(void)initBuildingScrView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"buildingScrImgs" ofType:@"plist"];
    _arr_buildingImgs = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    uis_buildingImgs = [[ebSimpleScrollView alloc] initWithFrame:self.view.bounds closeBtnLoc:CGRectMake(20.0f, 20.0f, 35.0f, 35.0f) btnImg:@"ui_team_close.png" boolBtn:YES bgImg:nil andArray:_arr_buildingImgs andTag:10];
    [uis_buildingImgs setDelegate:self];
    [uis_buildingImgs setBackgroundColor:[UIColor darkGrayColor]];
    
    uis_buildingImgs.alpha = 0.0f;    
    [self.view addSubview:uis_buildingImgs];
    [UIView animateWithDuration:0.33f
                     animations:^{
                         uis_buildingImgs.alpha = 1.0f;
                     }
                     completion:^(BOOL finished) {   }
     ];

}

#pragma mark
#pragma mark Actions of Buttons
-(void)loadVC:(id)sender
{
    UIButton *uib_bldBtn = (UIButton*)sender;
    int tag = uib_bldBtn.tag;
    vcObjectIndex = tag;
    
    dict_delegatePageArray = [delegatePageArray objectAtIndex:0];
    self.arr_viewControllers = [dict_delegatePageArray objectForKey:@"vcArrayData"];
    
	[self setDataForMenuObject:(vcObjectIndex)];
	NSString *nibString = @"nil";
	
	nibString = vcObject.vcName;

    
    if (tag == 1) {
        [self initBuildingScrView];
    }
    if (tag == 2) {
        _mapGallery = [[embAlbumViewController alloc] init];
        _mapGallery.plistName = @"neighborhoodData";
        _mapGallery.backgroundName = @"scr02.png";
        
        [self performSelector:@selector(neighborhoodTransition) withObject:nil];
    }
    if (tag == 3) {
        _albumGallery = [[embAlbumViewController alloc] init];
		_albumGallery.plistName = @"galleryData";
		_albumGallery.backgroundName = @"scr01.png";

		[self performSelector:@selector(albumTransition) withObject:nil];
		return;
    }
    
    Class viewControllerClass = NSClassFromString( nibString );
	_controller = (UIViewController*) [[viewControllerClass alloc] initWithNibName:nibString bundle:nil];
    
}

-(void)albumTransition
{
    self.albumGallery.view.alpha = 0.0f;
    [self.view addSubview:self.albumGallery.view];
    [UIView animateWithDuration:0.33f
                     animations:^{
                         self.albumGallery.view.alpha = 1.0f;
                     }
                     completion:^(BOOL finished) {    }
     ];

}

-(void)neighborhoodTransition
{
    self.mapGallery.view.alpha = 0.0f;
    [self.view addSubview:self.mapGallery.view];
    [UIView animateWithDuration:0.33f
                     animations:^{
                         self.mapGallery.view.alpha = 1.0f;
                     }
                     completion:^(BOOL finished) {    }
     ];

}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[UIApplication sharedApplication].statusBarHidden = YES;
    self.view.frame = [UIScreen mainScreen].applicationFrame;
    CGRect frame = self.navigationController.navigationBar.frame;
    frame.origin.y = 0;
    self.navigationController.navigationBar.frame = frame;
	self.navigationController.navigationBar.translucent = YES;
    
	[self.navigationController setNavigationBarHidden:YES animated:animated];
	[self.navigationController setToolbarHidden:YES animated:YES];
}
#pragma -mark Info from ScrView

- (void)currentImageAtIndex:(NSUInteger)index fromSender:(UIScrollView*)scroll
{
    return;
}

-(void)didRemove:(ebSimpleScrollView *)customClass
{
    [customClass removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
