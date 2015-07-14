#import "AMRatingControlViewController.h"

@interface AMRatingControlViewController (Private)

- (void)updateRating:(id)sender;
- (void)updateEndRating:(id)sender;

@end


@implementation AMRatingControlViewController

@synthesize simpleRatingControl;

/**************************************************************************************************/
#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Create a simple instance, initing with :
    // - a CGPoint (the position in your view from which it will be drawn)
    // - and max rating
	self.simpleRatingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(90, 50)
                                                                        andMaxRating:5];
    
    // Customize the current rating if needed
    [self.simpleRatingControl setRating:3];
    [self.simpleRatingControl setStarSpacing:10];
	
	//KVO test
	[self.simpleRatingControl addObserver:self
							   forKeyPath:@"rating"
								  options:(NSKeyValueObservingOptionNew |
										   NSKeyValueObservingOptionOld)
								  context:NULL];
	
    // Define block to handle events
	__weak AMRatingControlViewController *weakSelf = self;
	
	self.simpleRatingControl.editingChangedBlock = ^(NSUInteger rating) {
		AMRatingControlViewController *strongSelf = weakSelf;
		if (strongSelf) {
			[strongSelf->label setText:[NSString stringWithFormat:@"%d", rating]];
		}
	};
	
	self.simpleRatingControl.editingDidEndBlock = ^(NSUInteger rating) {
		AMRatingControlViewController *strongSelf = weakSelf;
		if (strongSelf) {
			[strongSelf->endLabel setText:[NSString stringWithFormat:@"%d", rating]];
		}
	};
	
    
    // Create an instance with images, initing with :
    // - a CGPoint (the position in your view from which it will be drawn)
    // - a custom empty image and solid image if you wish (pass nil if you want to use the default).
    // - and max rating
	UIImage *dot, *star;
	dot = [UIImage imageNamed:@"dot.png"];
	star = [UIImage imageNamed:@"star.png"];
	AMRatingControl *imagesRatingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(110, 250)
                                                                          emptyImage:dot
                                                                          solidImage:star
                                                                        andMaxRating:5];
    
    // Create an instance with custom color, initing with :
    // - a CGPoint (the position in your view from which it will be drawn)
    // - a custom empty image and solid image if you wish (pass nil if you want to use the default).
    // - and max rating
	AMRatingControl *coloredRatingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(110, 370)
                                                                           emptyColor:[UIColor yellowColor]
                                                                           solidColor:[UIColor redColor]
                                                                         andMaxRating:5];
    
    
    
    
    // Add the control(s) as a subview of your view
	[self.view addSubview:self.simpleRatingControl];
    [self.view addSubview:imagesRatingControl];
    [self.view addSubview:coloredRatingControl];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqual:@"rating"]) {
		NSLog(@"KVO rating: %@", [change objectForKey:NSKeyValueChangeNewKey]);
	} else {
		[super observeValueForKeyPath:keyPath
							 ofObject:object
							   change:change
							  context:context];
	}
}

@end
