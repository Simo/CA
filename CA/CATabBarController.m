//
//  CATabBarController.m
//  CA
//
//  Created by Simone Bierti on 03/05/12.
//  Copyright (c) 2012 none. All rights reserved.
//

#import "CATabBarController.h"

@interface CATabBarController ()

@end

@implementation CATabBarController

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
    //creo uno stack dei view controller
    NSMutableArray* stack = [NSMutableArray arrayWithArray:self.viewControllers];
    
    while ([stack count] > 0) {
        //estrae l'ultimo elemento dello stack
        id controller = [stack lastObject];
        [stack removeLastObject];
        //nel caso l'oggetto contenesse altri controller, li aggiunge
        if ([controller respondsToSelector:@selector(viewControllers)]) {
            [stack addObjectsFromArray: [controller viewControllers]];
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
