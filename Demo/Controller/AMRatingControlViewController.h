#import <UIKit/UIKit.h>
#import "AMRatingControl.h"

@interface AMRatingControlViewController : UIViewController
{
	IBOutlet UILabel *label;
    IBOutlet UILabel *endLabel;
}

@property (nonatomic, strong) AMRatingControl *simpleRatingControl;

@end

