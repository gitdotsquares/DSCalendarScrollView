# DSCalendarScrollView

[![CI Status](http://img.shields.io/travis/admin/DSCalendarScrollView.svg?style=flat)](https://travis-ci.org/admin/DSCalendarScrollView)
[![Version](https://img.shields.io/cocoapods/v/DSCalendarScrollView.svg?style=flat)](http://cocoapods.org/pods/DSCalendarScrollView)
[![License](https://img.shields.io/cocoapods/l/DSCalendarScrollView.svg?style=flat)](http://cocoapods.org/pods/DSCalendarScrollView)
[![Platform](https://img.shields.io/cocoapods/p/DSCalendarScrollView.svg?style=flat)](http://cocoapods.org/pods/DSCalendarScrollView)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DSCalendarScrollView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DSCalendarScrollView"
```

## Author

Sumit Shastri, sumit.kumar@dotsquares.com


## Create DSCalendarScrollView 

DSCalendarScrollView *calenderScroll = [[DSCalendarScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 90)];
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


## Delegate Method 

- (void)calendarScrollView:(DSCalendarScrollView*)calendarScrollView  didSelectDateFromPicker:(NSInteger)index pickerItem:(DSCalendarItem *)pickerItem;
{

    self.lblDate.text = [NSString stringWithFormat:@"%@",pickerItem.date];
}

- (void)calendarScrollView:(DSCalendarScrollView*)calendarScrollView  pickerDateChanged:(NSInteger)index pickerItem:(DSCalendarItem *)pickerItem
{
    self.lblDate.text = [NSString stringWithFormat:@"%@",pickerItem.date];
}


## License

DSCalendarScrollView is available under the MIT license. See the LICENSE file for more info.
