//
//  CAShowRouteViewController.m
//  CA
//
//  Created by Simone Bierti on 03/05/12.
//  Copyright (c) 2012 none. All rights reserved.
//

#import "CAShowRouteViewController.h"

@interface CAShowRouteViewController ()

@end

@implementation CAShowRouteViewController

@synthesize points=_points;
@synthesize pointsCount = _pointsCount;

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
    self.pointsCount.text = [NSString stringWithFormat:@"il numero di passi è: %i",[self.points count]];
}

- (void)viewDidUnload
{
    [self setPointsCount:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
