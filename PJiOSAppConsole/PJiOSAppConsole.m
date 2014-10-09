//
//  PJiOSAppConsole.m
//  PJiOSAppConsole
//
//  Created by Pritesh Jawale on 10/6/14.
//  Copyright (c) 2014 Pritesh Jawale. All rights reserved.
//

#import "PJiOSAppConsole.h"

static const int kREQUESTCONSTANT = 10;
static const int kYCONSTANT = 50; // Includes navigation controller height

@implementation PJiOSAppConsole{
    CGAffineTransform rotationTransform;
    UIButton *btnShowControls, *btnClearTextView;
    UITextView *txtViewData;
    UIView *parentView;
    NSString *strCompleteLogForView;
}
BOOL isViewDisplayed = NO;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self initPJiOSAppConsoleView];
        [self initSubView];
        [self btnPullDrawer:btnShowControls withEvent:UIEventTypeTouches];
    }
    return self;
}

#pragma mark - Init View
+ (PJiOSAppConsole *) initPJiOSAppConsole:(UIView *)view{
    static PJiOSAppConsole *iOSConsole = nil;
    @synchronized(self) {
        if(iOSConsole == nil){
            iOSConsole = [[PJiOSAppConsole alloc] initWithView:view];
        }
        [view addSubview:iOSConsole];
    }
	return iOSConsole;
}

- (id)initWithView:(UIView *)view {
	NSAssert(view, @"View should not be nil.");
    parentView = view;
	id initialised = [self initWithFrame:view.bounds];
    return initialised;
}
- (void) initPJiOSAppConsoleView{
    
    [self setFrame:CGRectMake(parentView.frame.origin.x, parentView.frame.origin.y+kYCONSTANT, parentView.frame.size.width, parentView.frame.size.height)];
    [self setBackgroundColor:[UIColor blackColor]];
    self.alpha = 1.0f;
    [parentView bringSubviewToFront:self];
}

- (void) initSubView{
    strCompleteLogForView = @"";
    
    // Actuator ...
    btnShowControls = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnShowControls.frame = CGRectMake(10,parentView.frame.origin.y+15,50,31);
    [btnShowControls setBackgroundColor:[UIColor clearColor]];
    [btnShowControls setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnShowControls.tag = 1;
    [btnShowControls setTitle:@"Show" forState:UIControlStateNormal];
    [btnShowControls addTarget:self action:@selector(btnPullDrawer:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnShowControls];
    
    // TextView init
    txtViewData = [[UITextView alloc] initWithFrame:CGRectMake(kREQUESTCONSTANT, kYCONSTANT, parentView.frame.size.width-kREQUESTCONSTANT, parentView.frame.size.height-kYCONSTANT)];
    [txtViewData setFont:[UIFont fontWithName:@"Menlo" size:14]];
    [txtViewData setScrollEnabled:YES];
    [txtViewData setEditable:NO];
    [txtViewData setUserInteractionEnabled:YES];
    [txtViewData setBackgroundColor:[UIColor blackColor]];
    [txtViewData setTextColor:[UIColor greenColor]];
    CGRect frame = txtViewData.frame;
    frame.size.height = parentView.frame.size.height-kYCONSTANT;
    frame.size.width = parentView.frame.size.width;
    txtViewData.frame = frame;
    [self addSubview:txtViewData];
    
    // Clear Button
    btnClearTextView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnClearTextView.frame = CGRectMake(parentView.frame.size.width-100,parentView.frame.origin.y+15,100,31);
    [btnClearTextView setBackgroundColor:[UIColor clearColor]];
    [btnClearTextView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnClearTextView.tag = 2;
    [btnClearTextView setTitle:@"Clear" forState:UIControlStateNormal];
    [btnClearTextView addTarget:self action:@selector(btnClearTextViewPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnClearTextView];
}


#pragma mark - Button events
- (void) btnClearTextViewPressed: (id) sender{
    [txtViewData setText:@""];
    strCompleteLogForView = @"";
}
- (void) btnPullDrawer:(id) sender withEvent:(UIEvent *)event{
    isViewDisplayed = !isViewDisplayed;
    if(!isViewDisplayed){
        [btnShowControls setTitle:@"Hide" forState:UIControlStateNormal];
        [self slideUpTheFooter];
    }
    else if(isViewDisplayed){
        [btnShowControls setTitle:@"Show" forState:UIControlStateNormal];
        [self slideDownTheFooter];
    }
}
- (void)slideUpTheFooter {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.5];
    
    [self setFrame:CGRectMake(parentView.frame.origin.x, parentView.frame.origin.y+kYCONSTANT, parentView.frame.size.width, parentView.frame.size.height-kYCONSTANT)];
    [UIView commitAnimations];
}

- (void)slideDownTheFooter {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.5];
    
    [self setFrame:CGRectMake(parentView.frame.origin.x, parentView.frame.origin.y+parentView.frame.size.height-40, parentView.frame.size.width, parentView.frame.size.height-kYCONSTANT)];
    [UIView commitAnimations];
}


- (void) btnHidePJiOSAppConsolePressed:(id) sender{
    [self initSubView];
}

#pragma mark - Log methods
- (void) showLog:(NSString *)strLog{
    
    strCompleteLogForView = [strCompleteLogForView stringByAppendingString:[NSString stringWithFormat:@"\n\n %@ - %@", [NSDate date] ,strLog]];
    strCompleteLogForView = [strCompleteLogForView stringByReplacingOccurrencesOfString:@"+0000" withString:@""];
    [txtViewData setText:strCompleteLogForView];
}

+ (void) NSLog:(NSString *)strLog forView:(UIView *) view{
    PJiOSAppConsole *temp = [PJiOSAppConsole initPJiOSAppConsole:view];
    [temp showLog:strLog];
}

@end
