//
//  citylistdemoAppDelegate.h
//  citylistdemo
//
//  Created by BW on 11-11-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class citylistdemoViewController;

@interface citylistdemoAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet citylistdemoViewController *viewController;

@end
