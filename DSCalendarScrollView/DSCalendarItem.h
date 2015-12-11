//
//  DSCalendarItem.h
//  FastivalApp
//
//  Created by Sumit Shastri on 12/4/15.
//  Copyright © 2015 ds. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@class DSCalendarItem;

typedef enum {
    DSCalendarItemStateNormal = 1,
    DSCalendarItemStateHighlighted,
    DSCalendarItemStateSelected,
    DSCalendarItemStateFirstItem
} DSCalendarItemState;

@protocol DSCalendarItemDelegate <NSObject>

@required
- (void)pickerView:(DSCalendarItem *)pickerView didSelectDateFromPicker:(NSInteger)index;

@end

@interface DSCalendarItem : UIView<UITableViewDelegate>
{
    IBOutlet UILabel * lblDay;
    IBOutlet UILabel * lblDate;
    IBOutlet UIButton * btnDatePick;
    
}
-(IBAction)btnDatePickerClicked:(id)sender;
@property (nonatomic, weak) id <DSCalendarItemDelegate> delegate;
@property(nonatomic) DSCalendarItemState state;
@property(nonatomic,strong) UIColor * textColor;
@property(nonatomic,strong) UIColor * textHighlightedColor;
@property(nonatomic,strong) UIColor * textSelectedColor;
@property(nonatomic,strong) UIFont * font;
@property(nonatomic) double maxFontSize;
@property(nonatomic) double minFontSize;
@property(nonatomic,strong) NSDate * date;
@end