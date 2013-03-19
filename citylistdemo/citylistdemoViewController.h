//
//  citylistdemoViewController.h
//  citylistdemo
//
//  Created by BW on 11-11-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityListViewController.h"

@interface citylistdemoViewController : UIViewController <CityListViewControllerProtocol>{
    UIButton *cityButton;
}
@property (nonatomic, retain) IBOutlet UIButton *cityButton;
- (IBAction)pressCityButton:(id)sender;

@end
