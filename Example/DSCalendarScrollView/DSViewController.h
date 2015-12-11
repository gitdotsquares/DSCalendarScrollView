//
//  DSViewController.h
//  DSCalendarScrollView
//
//  Created by Sumit Shastri on 12/09/2015.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

@import UIKit;
#import "DSCalendarScrollView.h"

@interface DSViewController : UIViewController<DSCalendarScrollViewDelegate>
{
    DSCalendarScrollView * calenderScroll;
}
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end
