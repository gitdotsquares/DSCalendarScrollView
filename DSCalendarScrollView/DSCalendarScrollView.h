//
//  DSCalendarScrollView.h
//  FastivalApp
//
//  Created by Sumit Shastri on 12/4/15.
//  Copyright © 2015 ds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSCalendarItem.h"
@class DSCalendarScrollView;

@protocol DSCalendarScrollViewDelegate <NSObject>

@required
- (void)calendarScrollView:(DSCalendarScrollView*)calendarScrollView  didSelectDateFromPicker:(NSInteger)index pickerItem:(DSCalendarItem *)pickerItem;
@optional
- (void)calendarScrollView:(DSCalendarScrollView*)calendarScrollView  pickerDateChanged:(NSInteger)index pickerItem:(DSCalendarItem *)pickerItem;
@end


@interface DSCalendarScrollView : UIScrollView<DSCalendarItemDelegate,UIScrollViewDelegate,UIScrollViewAccessibilityDelegate>
{
    NSInteger numberofItems;
    NSDate *endDate;
    NSMutableArray * daysArray;
    UIPageControl *pageControl;
    NSMutableArray * arrayOfSubViews;
    NSInteger selectedIndex;
    
}
@property (nonatomic ,strong) NSDate *startDate;
@property(nonatomic) NSInteger dayNeedToBeShow;
@property(nonatomic,strong) NSDate *selectedDate;
@property (nonatomic, weak) id <DSCalendarScrollViewDelegate> delegate;
@property(nonatomic,strong) UIColor * textColor;
@property(nonatomic,strong) UIColor * textHighlightedColor;
@property(nonatomic,strong) UIColor * textSelectedColor;
@property(nonatomic,strong) UIFont * font;
@property(nonatomic) double maxFontSize;
@property(nonatomic) double minFontSize;
@end
