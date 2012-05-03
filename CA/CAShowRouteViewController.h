//
//  CAShowRouteViewController.h
//  CA
//
//  Created by Simone Bierti on 03/05/12.
//  Copyright (c) 2012 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAShowRouteViewController : UIViewController

@property (strong, nonatomic) NSArray* points;
@property (strong, nonatomic) IBOutlet UILabel *pointsCount;

@end
