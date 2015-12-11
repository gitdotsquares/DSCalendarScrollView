//
//  DSViewController.m
//  DSCalendarScrollView
//
//  Created by Sumit Shastri on 12/09/2015.
//  Copyright (c) 2015 Dotsquares. All rights reserved.
//

#import "DSViewController.h"

@interface DSViewController ()

@end

@implementation DSViewController

- (void)viewDidLoad {
    
    
    calenderScroll = [[DSCalendarScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 90)];
    calenderScroll.delegate = self;
    calenderScroll.textColor =UIColorFromRGBWithAlpha(0x85009E, 1.0);
    calenderScroll.textHighlightedColor =UIColorFromRGBWithAlpha(0xC800D2, 1.0);
    calenderScroll.textSelectedColor =UIColorFromRGBWithAlpha(0xFFFFFF, 1.0);
    calenderScroll.font =[UIFont fontWithName:@"arial" size:25];
    calenderScroll.maxFontSize = 32;
    calenderScroll.minFontSize = 20;
    calenderScroll.dayNeedToBeShow = 365;
    calenderScroll.selectedDate = [NSDate dateWithTimeIntervalSinceNow:60*60*24*1];
    [self.view addSubview:calenderScroll];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)calendarScrollView:(DSCalendarScrollView*)calendarScrollView  didSelectDateFromPicker:(NSInteger)index pickerItem:(DSCalendarItem *)pickerItem;
{
    NSLog(@"Selected index %ld ", index);
    self.lblDate.text = [NSString stringWithFormat:@"%@",pickerItem.date];
}
- (void)calendarScrollView:(DSCalendarScrollView*)calendarScrollView  pickerDateChanged:(NSInteger)index pickerItem:(DSCalendarItem *)pickerItem
{
    NSLog(@"Date Changed index %ld ", index);
    self.lblDate.text = [NSString stringWithFormat:@"%@",pickerItem.date];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
