//
//  CAShowRouteViewController.h
//  CA
//
//  Created by Simone Bierti on 03/05/12.
//  Copyright (c) 2012 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAShowRouteViewController : UIViewController <MKMapViewDelegate> {
    //il rect che conterrà tutto il percorso
    MKMapRect routeRect;
}

@property (strong, nonatomic) NSArray* points;
@property (strong, nonatomic) IBOutlet UILabel *pointsCount;
//proprietà per il disegno del percorso sulla mappa
@property (strong, nonatomic) IBOutlet MKMapView* mapView;
@property (strong, nonatomic) MKPolyline* routeLine;
@property (strong, nonatomic) MKPolylineView* routeLineView;
//proviamo con una webview
@property (strong, nonatomic) IBOutlet UIWebView* webView;


//carica i punti degli step intermedi
-(void) loadRoute;

// use the computed _routeRect to zoom in on the route. 
-(void) zoomInOnRoute;


@end
