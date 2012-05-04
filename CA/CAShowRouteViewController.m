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
@synthesize mapView = _mapView;
@synthesize routeLine = _routeLine;
@synthesize routeLineView = _routeLineView;
@synthesize webView=_webView;

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
    
    // creo l'overlay
	[self loadRoute];
	
	// add the overlay to the map
	if (nil != self.routeLine) {
		[self.mapView addOverlay:self.routeLine];
	}
	
	// zoom in on the route. 
	[self zoomInOnRoute];
    
    //NSString* google = @"http://maps.google.it/maps?saddr=46.224423,13.19731&daddr=46.055063,13.225847";
    
    //NSURL* url = [NSURL URLWithString:google];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://maps.google.it/maps?saddr=46.224423,13.19731&daddr=46.055063,13.225847"]];
    
    [_webView loadRequest:request];
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

// creates the route (MKPolyline) overlay
-(void) loadRoute
{
    /*
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"route" ofType:@"csv"];
	NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
	NSArray* pointStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	*/
	
	// while we create the route points, we will also be calculating the bounding box of our route
	// so we can easily zoom in on it. 
	MKMapPoint northEastPoint; 
	MKMapPoint southWestPoint; 
	
	// create a c array of points. 
	MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * _points.count);
	
	for(int idx = 0; idx < _points.count; idx++)
	{
		// break the string down even further to latitude and longitude fields.
        /*
		NSString* currentPointString = [pointStrings objectAtIndex:idx];
		NSArray* latLonArr = [currentPointString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        
		CLLocationDegrees latitude  = [[latLonArr objectAtIndex:0] doubleValue];
		CLLocationDegrees longitude = [[latLonArr objectAtIndex:1] doubleValue];
        */
        
        CLLocation* location = [_points objectAtIndex:idx];
        
		// create our coordinate and add it to the correct spot in the array 
		CLLocationCoordinate2D coordinate = location.coordinate;
        
		MKMapPoint point = MKMapPointForCoordinate(coordinate);
        NSLog(@"parliamo del punto n.%i con coordinate %f",idx,point.x);
		
		//
		// adjust the bounding box
		//
		
		// if it is the first point, just use them, since we have nothing to compare to yet. 
		if (idx == 0) {
			northEastPoint = point;
			southWestPoint = point;
		}
		else 
		{
			if (point.x > northEastPoint.x) 
				northEastPoint.x = point.x;
			if(point.y > northEastPoint.y)
				northEastPoint.y = point.y;
			if (point.x < southWestPoint.x) 
				southWestPoint.x = point.x;
			if (point.y < southWestPoint.y) 
				southWestPoint.y = point.y;
		}
        
		pointArr[idx] = point;
        
	}
    
	// create the polyline based on the array of points.
    
	self.routeLine = [MKPolyline polylineWithPoints:pointArr count:_points.count];
    
	routeRect = MKMapRectMake(southWestPoint.x, southWestPoint.y, northEastPoint.x - southWestPoint.x, northEastPoint.y - southWestPoint.y);
    
    
	// clear the memory allocated earlier for the points
	free(pointArr);
	
}

-(void) zoomInOnRoute
{
	[self.mapView setVisibleMapRect:routeRect];
}

#pragma mark MKMapViewDelegate

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
	MKOverlayView* overlayView = nil;
	
	if(overlay == self.routeLine)
	{
		//if we have not yet created an overlay view for this overlay, create it now. 
		if(nil == self.routeLineView)
		{
			self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
			self.routeLineView.fillColor = [UIColor redColor];
			self.routeLineView.strokeColor = [UIColor redColor];
			self.routeLineView.lineWidth = 3;
		}
		
		overlayView = self.routeLineView;
		
	}
	
	return overlayView;
	
}

@end
