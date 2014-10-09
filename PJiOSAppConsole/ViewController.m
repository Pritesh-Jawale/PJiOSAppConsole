//
//  ViewController.m
//  PJiOSAppConsole
//
//  Created by Pritesh Jawale on 10/8/14.
//  Copyright (c) 2014 Pritesh Jawale. All rights reserved.
//

#import "ViewController.h"
#import "PJiOSAppConsole.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [PJiOSAppConsole NSLog:@"in ViewController ViewDidload" forView:self.view];
}

- (void) viewWillAppear:(BOOL)animated{
    // Your code
    [PJiOSAppConsole NSLog:@"in ViewController viewWillAppear" forView:self.view];
}

- (IBAction)btnSubmitPressed:(id)sender{
    // Your code
    [PJiOSAppConsole NSLog:@"in ViewController btnSubmitPressed" forView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
