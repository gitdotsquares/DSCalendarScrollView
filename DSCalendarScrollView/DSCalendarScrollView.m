//
//  DSCalendarScrollView.m
//  FastivalApp
//
//  Created by Sumit Shastri on 12/4/15.
//  Copyright © 2015 ds. All rights reserved.
//

#import "DSCalendarScrollView.h"
#import <math.h>
@implementation DSCalendarScrollView
@synthesize delegate,startDate,textColor,textHighlightedColor,textSelectedColor,font,selectedDate =_selectedDate;
@synthesize dayNeedToBeShow = _dayNeedToBeShow;
@synthesize maxFontSize,minFontSize;
-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        [super setDelegate:self];
        self.startDate = [NSDate date];
        self.textColor =UIColorFromRGBWithAlpha(0x85009E, 1.0);
        self.textHighlightedColor =UIColorFromRGBWithAlpha(0xC800D2, 1.0);
        self.textSelectedColor =UIColorFromRGBWithAlpha(0xFFFFFF, 1.0);
        self.dayNeedToBeShow = 10;
        self.maxFontSize = 20;
        self.minFontSize = 16;
    }
    return self;
}

-(void) setDayNeedToBeShow:(NSInteger)dayNeedToBeShow
{
    _dayNeedToBeShow = dayNeedToBeShow;
    daysArray = [[NSMutableArray alloc] init];
    arrayOfSubViews = [[NSMutableArray alloc] init];
    for (DSCalendarItem * item in [self subviews]) {
        if([item isKindOfClass:[DSCalendarItem class]])
        {
            [item removeFromSuperview];
        }
    }
    
    for (int i =0; i<=dayNeedToBeShow; i++) {
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        dayComponent.day = i;
        
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *date = [theCalendar dateByAddingComponents:dayComponent toDate:self.startDate options:0];
        [daysArray addObject:date];
        
        DSCalendarItem * item = [self calendarScrollView:self addItemsInCalendarScrollView:i];
        [arrayOfSubViews addObject:item];
        [self addSubview:item];
    }
    endDate = [daysArray lastObject];
    self.bounces = NO;
    self.contentSize = CGSizeMake((self.frame.size.width/2) * (dayNeedToBeShow+2) ,0);
    if(arrayOfSubViews.count>0){
    [self scrollAtIndex:0 :[arrayOfSubViews objectAtIndex:0]];
    }
}

- (DSCalendarItem *)calendarScrollView:(DSCalendarScrollView *)calendarScrollView addItemsInCalendarScrollView:(NSInteger)index;
{
    DSCalendarItem * item = [[DSCalendarItem alloc] initWithFrame:CGRectMake((self.frame.size.width/2)*(index+1), 0, self.frame.size.width/2, self.frame.size.height)];
    item.textColor = self.textColor;
    item.delegate = self;
    item.textHighlightedColor = self.textHighlightedColor;
    item.textSelectedColor = self.textSelectedColor;
    item.maxFontSize =self.maxFontSize;
    item.minFontSize = minFontSize;
    item.font = self.font;
    item.date = [daysArray objectAtIndex:index];
    item.state = DSCalendarItemStateNormal;
    return item;
}

#pragma mark - ScrollView Delegate
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    [self resetCellApperience:scrollView];
}
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self resetCellApperience:scrollView];
}
-(void) resetCellApperience :(UIScrollView *)scrollView
{
    float ofsetX =scrollView.contentOffset.x;
    float widthOfCell =scrollView.frame.size.width/2;
    float pos =ofsetX+(widthOfCell/2)-(fmodf(ofsetX, widthOfCell));
    [scrollView setContentOffset:CGPointMake(pos, scrollView.contentOffset.y) animated:YES];
    
}
-(void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
}
-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    float ofsetX =scrollView.contentOffset.x;
    float widthOfCell =scrollView.frame.size.width/2;
    int cellpos =floor(ofsetX/widthOfCell);
    int cellPrePos  = cellpos-1;
    int cellNextPos  = cellpos+1;
    DSCalendarItem * item;
    if(cellpos<[arrayOfSubViews count])
    {
        if(cellpos == selectedIndex && self.selectedDate)
        {
            item = [arrayOfSubViews objectAtIndex:cellpos];
            item.state = DSCalendarItemStateSelected;
        }
        else
        {
            item = [arrayOfSubViews objectAtIndex:cellpos];
            item.state = DSCalendarItemStateHighlighted;
        }
        
        if((cellPrePos)>=0)
        {
            item = [arrayOfSubViews objectAtIndex:(cellPrePos)];
            item.state = DSCalendarItemStateNormal;
        }
        if((cellNextPos)<[arrayOfSubViews count])
        {
            item = [arrayOfSubViews objectAtIndex:(cellNextPos)];
            item.state = DSCalendarItemStateNormal;
        }
    }
}

-(void) pickerView:(DSCalendarItem *)pickerView didSelectDateFromPicker:(NSInteger)index
{
    NSInteger indexPath = [arrayOfSubViews indexOfObject:pickerView];
    self.selectedDate = pickerView.date;
    

    if([self.delegate respondsToSelector:@selector(calendarScrollView: didSelectDateFromPicker: pickerItem:)])
    {
        [self.delegate calendarScrollView:self didSelectDateFromPicker:indexPath pickerItem:pickerView];
    }
}
-(void)scrollAtIndex :(NSInteger ) index :(DSCalendarItem *)pickerView
{
    float widthOfCell =self.frame.size.width/2;
    float pos1 = (index)*widthOfCell;
    float pos =pos1+(widthOfCell/2)-(fmodf(pos1, widthOfCell));
    int currectIndex = floor(self.contentOffset.x/widthOfCell);
    
    DSCalendarItem * item;
    if(currectIndex == index && selectedIndex == index && self.selectedDate)
    {
        pickerView.state = DSCalendarItemStateSelected;
    }
    else
    {
        pickerView.state = DSCalendarItemStateHighlighted;
    }
    if(currectIndex>0 && currectIndex<[arrayOfSubViews count])
    {
        item = [arrayOfSubViews objectAtIndex:(currectIndex+1)];
        item.state = DSCalendarItemStateNormal;
        
        item = [arrayOfSubViews objectAtIndex:(currectIndex-1)];
        item.state = DSCalendarItemStateNormal;
    }
    else if(currectIndex>0)
    {
        item = [arrayOfSubViews objectAtIndex:(currectIndex-1)];
        item.state = DSCalendarItemStateNormal;
    }
    else
    {
        item = [arrayOfSubViews objectAtIndex:(currectIndex+1)];
        item.state = DSCalendarItemStateNormal;
    }
    [self setContentOffset:CGPointMake(pos, self.contentOffset.y) animated:YES];
    if(selectedIndex && self.selectedDate)
    {
        if([self.delegate respondsToSelector:@selector(calendarScrollView: pickerDateChanged: pickerItem:)])
        {
            [self.delegate calendarScrollView:self pickerDateChanged:selectedIndex pickerItem:pickerView];
        }
    }
}

-(void) setSelectedDate:(NSDate *)selectedDate
{
    _selectedDate = selectedDate;
    for (NSDate * date in daysArray) {
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *compDate = [cal components:NSDayCalendarUnit fromDate:selectedDate toDate:date options:0];
        NSInteger numbersOfDaysDiff = [compDate day];
        
        if (numbersOfDaysDiff==0) {
            _selectedDate  = date;
            selectedIndex = [daysArray indexOfObject:date];
            [self scrollAtIndex:selectedIndex :[arrayOfSubViews objectAtIndex:selectedIndex]];
            
            
            break;
        }
        
        
    }
    
}

@end

