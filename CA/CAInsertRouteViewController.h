//
//  CAInsertRouteViewController.h
//  CA
//
//  Created by Simone Bierti on 03/05/12.
//  Copyright (c) 2012 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAShowRouteViewController.h"

@interface CAInsertRouteViewController : UIViewController

@property (strong, nonatomic) NSArray* journeyPoints;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UILabel *label;

- (IBAction)geolocate:(id)sender;

@end
