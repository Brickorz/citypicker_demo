//
//  citylistdemoViewController.m
//  citylistdemo
//
//  Created by BW on 11-11-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "citylistdemoViewController.h"
#import "CityListViewController.h"

@implementation citylistdemoViewController
@synthesize cityButton;

- (void)dealloc
{
    [cityButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setCityButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)pressCityButton:(id)sender {
    //launch city list view
    CityListViewController *detailViewController = [[CityListViewController alloc] initWithNibName:@"CityListViewController" bundle:nil];
    
    detailViewController.delegate = self;
    
    detailViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:detailViewController animated:YES];
    [detailViewController release];

}

//CityListViewController protocol
- (void) citySelectionUpdate:(NSString*)selectedCity
{
    [cityButton setTitle:selectedCity forState:UIControlStateNormal];
}

- (NSString*) getDefaultCity
{
    return cityButton.titleLabel.text;
}

@end
