//
//  DSCalendarItem.m
//  FastivalApp
//
//  Created by Sumit Shastri on 12/4/15.
//  Copyright © 2015 ds. All rights reserved.
//

#import "DSCalendarItem.h"
#define HIEGHT_DIFF @"2"

@implementation DSCalendarItem
@synthesize delegate,state = _state;
@synthesize textColor  = _textColor;
@synthesize textHighlightedColor  = _textHighlightedColor;
@synthesize textSelectedColor  = _textSelectedColor;
@synthesize font  = _font;
@synthesize date = _date;
@synthesize maxFontSize = _maxFontSize;
@synthesize minFontSize = _minFontSize;
-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        lblDay = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2)];
        lblDate = [[UILabel alloc] initWithFrame:CGRectMake(0,self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2)];
        self.maxFontSize = 20;
        self.minFontSize = 16;
        
        btnDatePick = [UIButton buttonWithType:UIButtonTypeCustom];
        btnDatePick.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [btnDatePick setTitle:@"" forState:UIControlStateNormal];
        [btnDatePick addTarget:self action:@selector(btnDatePickerClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.textColor =UIColorFromRGBWithAlpha(0x85009E, 1.0);
        self.textHighlightedColor =UIColorFromRGBWithAlpha(0xC800D2, 1.0);
        self.textSelectedColor =UIColorFromRGBWithAlpha(0xFFFFFF, 1.0);
        
        [self addSubview:lblDay];
        [self addSubview:lblDate];
        [self addSubview:btnDatePick];
    }
    return self;
}
-(void) setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
}
-(void) setTextHighlightedColor:(UIColor *)textHighlightedColor
{
    _textHighlightedColor = textHighlightedColor;
}

-(void) setTextSelectedColor:(UIColor *)textSelectedColor
{
    _textSelectedColor = textSelectedColor;
}
-(void) setFont:(UIFont *)font
{
    _font = font;
    lblDate.font  = font;
    lblDay.font  = font;
}
-(void) setState:(DSCalendarItemState)state
{
    _state = state;
    switch (state) {
        case DSCalendarItemStateNormal:
            lblDay.textColor = self.textColor;
            lblDate.textColor = self.textColor;
            lblDay.font = [UIFont fontWithName:[self.font fontName] size:self.maxFontSize-8];
            lblDate.font = [UIFont fontWithName:[self.font fontName] size:self.minFontSize-5];
            lblDay.frame = CGRectMake(0, ([HIEGHT_DIFF integerValue]*2), self.frame.size.width, (self.frame.size.height/2)-[HIEGHT_DIFF integerValue]);
            lblDate.frame = CGRectMake(0, (self.frame.size.height/2)+[HIEGHT_DIFF integerValue], self.frame.size.width, (self.frame.size.height/2)-[HIEGHT_DIFF integerValue]);
            break;
        case DSCalendarItemStateHighlighted:
            lblDay.textColor = self.textHighlightedColor;
            lblDate.textColor = self.textHighlightedColor;
            lblDay.font = [UIFont fontWithName:[self.font fontName] size:self.maxFontSize-5];
            lblDate.font = [UIFont fontWithName:[self.font fontName] size:self.minFontSize-3];
            lblDay.frame = CGRectMake(0, ([HIEGHT_DIFF integerValue]*2), self.frame.size.width, (self.frame.size.height/2)-[HIEGHT_DIFF integerValue]);
            lblDate.frame = CGRectMake(0, (self.frame.size.height/2)+[HIEGHT_DIFF integerValue], self.frame.size.width, (self.frame.size.height/2)-[HIEGHT_DIFF integerValue]);
            break;
        case DSCalendarItemStateSelected:
            lblDay.textColor = self.textSelectedColor;
            lblDate.textColor = self.textSelectedColor;
            lblDay.font = [UIFont fontWithName:[self.font fontName] size:self.maxFontSize];
            lblDate.font = [UIFont fontWithName:[self.font fontName] size:self.minFontSize];
            lblDay.frame = CGRectMake(0, 0, self.frame.size.width, (self.frame.size.height/2));
            lblDate.frame = CGRectMake(0, (self.frame.size.height/2), self.frame.size.width, (self.frame.size.height/2));
            break;
        case DSCalendarItemStateFirstItem:
            lblDay.hidden = YES;
            lblDate.hidden = YES;
            self.backgroundColor = [UIColor clearColor];
            break;
            
        default:
            break;
    }
}

-(void) setDate:(NSDate *)date
{
    _date = date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    lblDay.text = [dateFormatter stringFromDate:date];
    
    [dateFormatter setDateFormat:@"MMMM"];
    NSString *monthName = [dateFormatter stringFromDate:date];
    
    
    [dateFormatter setDateFormat:@"dd"];
    NSString *myDayString = [dateFormatter stringFromDate:date];
    switch ([myDayString integerValue]) {
        case 1:
        case 21:
        case 31:
            myDayString = [NSString stringWithFormat:@"%@st",myDayString];
            break;
        case 2:
        case 22:
            myDayString = [NSString stringWithFormat:@"%@nd",myDayString];
            break;
        case 3:
        case 23:
            myDayString = [NSString stringWithFormat:@"%@rd",myDayString];
            break;
            
        default:
            myDayString = [NSString stringWithFormat:@"%@th",myDayString];
            break;
    }
    lblDate.text = [NSString stringWithFormat:@"%@ %@",myDayString,monthName];
    lblDay.textAlignment = NSTextAlignmentCenter;
    lblDate.textAlignment = NSTextAlignmentCenter;
}

-(IBAction)btnDatePickerClicked:(id)sender
{
    if([self.delegate respondsToSelector:@selector(pickerView: didSelectDateFromPicker:)])
    {
        [self.delegate pickerView:self didSelectDateFromPicker:1];
    }
}

-(void) setMaxFontSize:(double)maxFontSize
{
    _maxFontSize = maxFontSize;
    
}

-(void) setMinFontSize:(double)minFontSize
{
    _minFontSize = minFontSize;
    lblDay.minimumFontSize = minFontSize-10;;
    lblDay.adjustsFontSizeToFitWidth = YES;
    lblDate.minimumFontSize = minFontSize-10;;
    lblDate.adjustsFontSizeToFitWidth = YES;
    
}
@end
