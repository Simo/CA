//
//  CAInsertRouteViewController.m
//  CA
//
//  Created by Simone Bierti on 03/05/12.
//  Copyright (c) 2012 none. All rights reserved.
//

#import "CAInsertRouteViewController.h"

@interface CAInsertRouteViewController ()

@end

static NSString* const SHOW_ROUTE_SEGUE = @"Show Route Segue";

@implementation CAInsertRouteViewController

@synthesize journeyPoints=_journeyPoints;
@synthesize address;
@synthesize label;


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

# pragma mark - Parsing JSON

- (void)fetchedData:(NSData *)responseData {
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions error:nil];
    
    NSArray* array = [[NSArray alloc] initWithArray:[[[[json valueForKey:@"routes"] valueForKey:@"legs"] valueForKey:@"steps"] objectAtIndex:0]];
    NSArray* steps = [[NSArray alloc] initWithArray:[array objectAtIndex:0]];
    
    NSMutableArray* tmpJourneyPoints = [[NSMutableArray alloc] initWithCapacity:[steps count]];
    
    for (NSDictionary* step in steps) {
        CLLocation* location = [[CLLocation alloc] initWithLatitude:[[[step valueForKey:@"start_location"] valueForKey:@"lat"] floatValue]
                                                          longitude:[[[step valueForKey:@"start_location"] valueForKey:@"lng"] floatValue]];
        [tmpJourneyPoints addObject:location];
    }
    
    //mi assicuro che l'array non sia più modificato
    self.journeyPoints = [tmpJourneyPoints copy];
    
    NSLog(@"journeyPoints è lungo: %i", [_journeyPoints count]);
    /*
     NSLog(@"è un array %i", [[[array objectAtIndex:0] objectAtIndex:0] isKindOfClass:[NSDictionary class]]);
     
     
     NSArray* origins = [[NSArray alloc] initWithArray:[[array objectAtIndex:0] valueForKey:@"start_location"]];
     NSArray* destinations = [[NSArray alloc] initWithArray:[[array objectAtIndex:0] valueForKey:@"end_location"]];
     
     NSLog(@"il json è lungo: %i", [[[[[[json valueForKey:@"routes"] valueForKey:@"legs"] valueForKey:@"steps"] objectAtIndex:0] objectAtIndex:0] count]);
     NSLog(@"%@", [[[[[[json valueForKey:@"routes"] valueForKey:@"legs"] valueForKey:@"steps"] objectAtIndex:0] objectAtIndex:0] objectAtIndex:0]);
     NSLog(@"la lunghezza dell'array è: %i", [origins count]);
     NSLog(@"la lunghezza dell'array è: %i", [destinations count]);
     
     NSMutableArray *elements = [[NSMutableArray alloc] initWithCapacity:[json count]];
     
     NSDictionary* routes = json[0];
     
     for (NSDictionary *dict in json) {
     
     [distributoriTMP addObject:c]; //5
     }
     //mi assicuro che l'array non possa essere modificato.
     self.distributors = [distributoriTMP copy]; //6
     */
}

- (IBAction)geolocate:(id)sender {
    /*
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    CLGeocodeCompletionHandler completionHandler = 
    ^(NSArray *placemarks, NSError *error)
    {
        if ([placemarks count] > 0)
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
            NSLog(@"Found placemark: %@", placemark);
            NSLog(@"i punti sono:\n\tlat\t->%f\n\tlon\t->%f",placemark.location.coordinate.latitude,placemark.location.coordinate.longitude);
            NSString *string =  [NSString stringWithFormat:@"%f,%f",placemark.location.coordinate.latitude,placemark.location.coordinate.longitude];
            NSLog(@"%@",string);
            self.label.text = string;
            
            NSString* origin = @"46.224423,13.19731";
            NSString* destination = [NSString stringWithString:string];
            
            NSString* googleMaps = [[NSString alloc] initWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&region=it&sensor=false",origin,destination];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:googleMaps]];
                [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES]; });
            
        }
    };
    
    [geocoder geocodeAddressString:address.text completionHandler:completionHandler];
    */
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self performSelectorOnMainThread:@selector(forwardGeolocation:) withObject:address.text waitUntilDone:YES];
    });
    
    
    [self performSegueWithIdentifier:SHOW_ROUTE_SEGUE sender:self];
    
}

- (void) forwardGeolocation: (NSString*) indirizzo {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    CLGeocodeCompletionHandler completionHandler = 
    ^(NSArray *placemarks, NSError *error)
    {
        if ([placemarks count] > 0)
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
            NSLog(@"Found placemark: %@", placemark);
            NSLog(@"i punti sono:\n\tlat\t->%f\n\tlon\t->%f",placemark.location.coordinate.latitude,placemark.location.coordinate.longitude);
            NSString *string =  [NSString stringWithFormat:@"%f,%f",placemark.location.coordinate.latitude,placemark.location.coordinate.longitude];
            NSLog(@"%@",string);
            self.label.text = string;
            
            NSString* origin = @"46.224423,13.19731";
            NSString* destination = [NSString stringWithString:string];
            
            NSString* googleMaps = [[NSString alloc] initWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&region=it&sensor=false",origin,destination];
            
            dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:googleMaps]];
                [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES]; });
            
        }
    };
    
    [geocoder geocodeAddressString:indirizzo completionHandler:completionHandler];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SHOW_ROUTE_SEGUE]) {
        CAShowRouteViewController* showRouteController = segue.destinationViewController;
        showRouteController.points = self.journeyPoints;
        //showRouteController.delegate = self;
        //showRouteController.defaultUnit = self.weightHistory.defaultUnits;
    }
}


@end
