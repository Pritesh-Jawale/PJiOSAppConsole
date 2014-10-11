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
static const int kYCONSTANTTextView = 90; // Includes navigation controller height
@implementation PJiOSAppConsole{
    CGAffineTransform rotationTransform;
    UIButton *btnShowControls, *btnClearTextView, *btnShowConsole;
    UITextView *txtViewData;
    UIView *parentView;
    NSString *strCompleteLogForView;
    UIPanGestureRecognizer *panGesture;
}
BOOL isViewDisplayed = NO;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initPJiOSAppConsoleView];
        [self initSubView];
        [self registerForNotifications];
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
    [self setBackgroundColor:[UIColor clearColor]];
    self.alpha = 1.0f;
    [parentView bringSubviewToFront:self];
}

- (void) initSubView{
    strCompleteLogForView = @"";
    
    // Show console button ...
    btnShowConsole = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnShowConsole.frame = CGRectMake(30,kYCONSTANT,90,90);
    [btnShowConsole setBackgroundColor:[UIColor redColor]];
    [btnShowConsole setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnShowConsole.tag = 100;
    [btnShowConsole setTitle:@"Console" forState:UIControlStateNormal];
    [btnShowConsole addTarget:self action:@selector(showConsole:) forControlEvents:UIControlEventTouchUpInside];
    btnShowConsole.layer.cornerRadius=45;
    btnShowConsole.center = parentView.center;
    [parentView addSubview:btnShowConsole];
    
    // Pan gesture
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panGesture setMaximumNumberOfTouches:2];
    [panGesture setDelegate:self];
    [btnShowConsole addGestureRecognizer:panGesture];

    
    // Hide button ...
    btnShowControls = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnShowControls.frame = CGRectMake(10,parentView.frame.origin.y+15,50,31);
    [btnShowControls setBackgroundColor:[UIColor clearColor]];
    [btnShowControls setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnShowControls.tag = 1;
    [btnShowControls setTitle:@"Hide" forState:UIControlStateNormal];
    [btnShowControls addTarget:self action:@selector(showConsole:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnShowControls];
    
    // TextView
    txtViewData = [[UITextView alloc] initWithFrame:CGRectMake(kREQUESTCONSTANT, kYCONSTANT, parentView.frame.size.width-kREQUESTCONSTANT, parentView.frame.size.height-kYCONSTANT)];
    [txtViewData setFont:[UIFont fontWithName:@"Menlo" size:14]];
    [txtViewData setScrollEnabled:YES];
    [txtViewData setEditable:NO];
    [txtViewData setUserInteractionEnabled:YES];
    [txtViewData setBackgroundColor:[UIColor blackColor]];
    [txtViewData setTextColor:[UIColor greenColor]];
    [self addSubview:txtViewData];
    
    // Clear Button
    btnClearTextView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnClearTextView.frame = CGRectMake(parentView.frame.size.width-100,parentView.frame.origin.y+15,100,31);
    [btnClearTextView setBackgroundColor:[UIColor clearColor]];
    [btnClearTextView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnClearTextView.tag = 2;
    [btnClearTextView setTitle:@"Clear" forState:UIControlStateNormal];
    [btnClearTextView addTarget:self action:@selector(btnClearTextViewPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnClearTextView];
}


#pragma mark - Button events
- (void) showConsole: (id) sender{
    isViewDisplayed = !isViewDisplayed;
    if(!isViewDisplayed){
        [btnShowConsole setAlpha:0.0f];
        [self setHidden:NO];
    }
    else if(isViewDisplayed){
        [btnShowConsole setAlpha:1.0f];
        [self setHidden:YES];
    }
}

- (void) btnClearTextViewPressed: (id) sender{
    [txtViewData setText:@""];
    strCompleteLogForView = @"";
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
    [temp addShowConsole:view];
}


- (void) addShowConsole:(UIView *)view{
    [view addSubview:btnShowConsole];
}
// Setting boundary for Console button
- (void)handlePan:(UIPanGestureRecognizer*)recognizer {
    CGPoint movement;
    
    if(recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged || recognizer.state == UIGestureRecognizerStateEnded)
    {
        CGRect rec = recognizer.view.frame;
        CGRect mainView = parentView.frame;
        if((rec.origin.x >= mainView.origin.x && (rec.origin.x + rec.size.width <= mainView.origin.x + mainView.size.width)) && (rec.origin.y >= mainView.origin.y && (rec.origin.y + rec.size.height <= mainView.origin.y + mainView.size.height)))
        {
            CGPoint translation = [recognizer translationInView:recognizer.view.superview];
            movement = translation;
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
            rec = recognizer.view.frame;
            
            if( rec.origin.x < mainView.origin.x )
                rec.origin.x = mainView.origin.x;
            
            if( rec.origin.y < mainView.origin.y )
                rec.origin.y = mainView.origin.y;
            
            if( rec.origin.x + rec.size.width > mainView.origin.x + mainView.size.width )
                rec.origin.x = mainView.origin.x + mainView.size.width - rec.size.width;
            
            if( rec.origin.y + rec.size.height > mainView.origin.y + mainView.size.height )
                rec.origin.y = mainView.origin.y + mainView.size.height - rec.size.height;
            
            recognizer.view.frame = rec;
            
            [recognizer setTranslation:CGPointZero inView:recognizer.view.superview];
        }
    }
    
}
#pragma mark - Notifications

- (void)registerForNotifications {
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(deviceOrientationDidChange:)
			   name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)unregisterFromNotifications {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    // Adjusting "Console" button on screen as per orientation change
    CGRect rec = btnShowConsole.frame;
    CGRect mainView = parentView.frame;
    rec = btnShowConsole.frame;
    if( rec.origin.x < mainView.origin.x )
        rec.origin.x = mainView.origin.x;
    
    if( rec.origin.y < mainView.origin.y )
        rec.origin.y = mainView.origin.y;
    
    if( rec.origin.x + rec.size.width > mainView.origin.x + mainView.size.width )
        rec.origin.x = mainView.origin.x + mainView.size.width - rec.size.width;
    
    if( rec.origin.y + rec.size.height > mainView.origin.y + mainView.size.height )
        rec.origin.y = mainView.origin.y + mainView.size.height - rec.size.height;
    
    btnShowConsole.frame = rec;

    // Adjusting textview on screen as per orientation change
    CGRect frame = txtViewData.frame;
    frame.size.height = mainView.size.height-(kYCONSTANTTextView);
    frame.size.width = parentView.frame.size.width;
    txtViewData.frame = frame;
}

@end
