//
//  SecondViewController.m
//  PJiOSAppConsole
//
//  Created by Pritesh Jawale on 10/8/14.
//  Copyright (c) 2014 Pritesh Jawale. All rights reserved.
//

#import "SecondViewController.h"
#import "PJiOSAppConsole.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [PJiOSAppConsole NSLog:@"in SecondViewController ViewDidload" forView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnShowMeOnConsolePressed:(id)sender{
    [PJiOSAppConsole NSLog:@"in SecondViewController btnShowMeOnConsolePressed" forView:self.view];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
