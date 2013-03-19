//
//  CityListViewController.m
//
//  Created by Big Watermelon on 11-11-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CityListViewController.h"

@interface CityListViewController ()
@property (nonatomic, retain) UIImageView* checkImgView;
@property NSUInteger curSection;
@property NSUInteger curRow;
@property NSUInteger defaultSelectionRow;
@property NSUInteger defaultSelectionSection;
@end

@implementation CityListViewController
@synthesize tbView;

#define CHECK_TAG 1110

@synthesize cities, keys, checkImgView, curSection, curRow, delegate;
@synthesize defaultSelectionRow, defaultSelectionSection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [tbView release];
    [super dealloc];
    [cities release];
    [keys release];
    [checkImgView release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    curRow = NSNotFound;    
    
    self.checkImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check"]];
    checkImgView.tag = CHECK_TAG;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"   
                                                   ofType:@"plist"]; 
    self.cities = [[NSDictionary alloc]   
                   initWithContentsOfFile:path];
    
    self.keys = [[cities allKeys] sortedArrayUsingSelector:  
                 @selector(compare:)]; 
    
    NSString *defaultCity = [delegate getDefaultCity];
    if (defaultCity) {
        self.defaultSelectionSection = NSNotFound;
        NSArray *citySection;
        for (NSString *key in keys) {
            citySection = [cities objectForKey:key];
            self.defaultSelectionRow = [citySection indexOfObject:defaultCity];
            if (defaultSelectionRow == NSNotFound) {
                continue;
            }else{
                self.defaultSelectionSection = [keys indexOfObject:key];
                break;
            }
        }
        if (defaultSelectionRow != NSNotFound) {
            self.curSection = defaultSelectionRow;
            self.curRow = defaultSelectionRow;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:curRow inSection:curSection];
            [self.tbView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        }
    }
    
    //get default selection from delegate
    /*NSString* defaultCity = [delegate getDefaultCity];  //感觉有点繁琐，可以简化
    if (defaultCity) {
        NSArray *citySection;
        self.defaultSelectionRow = NSNotFound;
        //set table index to this city if it existed
        for (NSString* key in keys) {
            citySection = [cities objectForKey:key];
            self.defaultSelectionRow = [citySection indexOfObject:defaultCity];
            if (NSNotFound == defaultSelectionRow)
                continue;
            //found match recoard position
            self.defaultSelectionSection = [keys indexOfObject:key];
            break;
        }
        
        if (NSNotFound != defaultSelectionRow) {
            self.curSection = defaultSelectionSection;
            self.curRow = defaultSelectionRow;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:defaultSelectionRow inSection:defaultSelectionSection];
            [self.tbView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        }
    }*/
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.keys = nil;
    self.cities = nil;
    self.checkImgView = nil;
    self.tbView = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *key = [keys objectAtIndex:section];  
    NSArray *citySection = [cities objectForKey:key];
    return [citySection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    NSString *key = [keys objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    } else {
        /*
        for (UIView *view in cell.contentView.subviews) {
            if (view.tag == CHECK_TAG) {
                if (indexPath.section != curSection || indexPath.row != curRow)
                    checkImgView.hidden = true;
                else
                    checkImgView.hidden = false;
            }
        }*/
    }
    
    // Configure the cell...
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.text = [[cities objectForKey:key] objectAtIndex:indexPath.row];
    
    if (indexPath.section == curSection && indexPath.row == curRow)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{  
    NSString *key = [keys objectAtIndex:section];  
    return key;  
}  

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView  
{  
    return keys;  
} 


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
/*    
    //clear previous selection first
    [checkImgView removeFromSuperview];
    
    //add new check mark
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //make sure the image size is fit for cell height;
    
    CGRect cellRect = cell.bounds;
    float imgHeight = cellRect.size.height * 2 / 3; // 2/3 cell height
    float imgWidth = 20.0; //hardcoded
    
    
    checkImgView.frame = CGRectMake(cellRect.origin.x + cellRect.size.width - 100, //shift for index width plus image width 
                                    cellRect.origin.y + cellRect.size.height / 2 - imgHeight / 2, 
                                    imgWidth, 
                                    imgHeight);
    
    [cell.contentView addSubview:checkImgView];
    checkImgView.hidden = false;
*/    
    //clear previous
    NSIndexPath *prevIndexPath = [NSIndexPath indexPathForRow:curRow inSection:curSection];
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:prevIndexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    curSection = indexPath.section;
    curRow = indexPath.row;
    
    //add new check mark
    cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (IBAction)pressReturn:(id)sender {
    //notify delegate user selection if it different with default
    if (curRow != NSNotFound) {
        NSString* key = [keys objectAtIndex:curSection];
        [delegate citySelectionUpdate:[[cities objectForKey:key] objectAtIndex:curRow]];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}
@end
