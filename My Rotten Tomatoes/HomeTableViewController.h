//
//  HomeTableViewController.h
//  My Rotten Tomatoes
//
//  Created by Jim Liu on 2/6/15.
//  Copyright (c) 2015 Jim Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewController : UIViewController

@property (nonatomic, strong) NSString *tabTitle;
@property (nonatomic, strong) NSString *endpoint;

- (instancetype) initWithTitle:(NSString *) tabTitle endpoint:(NSString *) endpoint;

@end
