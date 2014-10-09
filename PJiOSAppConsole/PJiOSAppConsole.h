//
//  PJiOSAppConsole.h
//  PJiOSAppConsole
//
//  Created by Pritesh Jawale on 10/6/14.
//  Copyright (c) 2014 Pritesh Jawale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJiOSAppConsole : UIView
+ (PJiOSAppConsole *) initPJiOSAppConsole:(UIView *)view;
- (void) showLog:(NSString *)strLog;
+ (void) NSLog:(NSString *)strLog forView:(UIView *) view;
@end
