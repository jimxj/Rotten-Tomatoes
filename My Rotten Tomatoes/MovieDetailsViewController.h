//
//  MovieDetailsViewController.h
//  My Rotten Tomatoes
//
//  Created by Jim Liu on 2/7/15.
//  Copyright (c) 2015 Jim Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailsViewController : UIViewController

@property (nonatomic, strong) NSDictionary *movieDictionary;

@property (nonatomic, strong) UIImage *thumbnailImage;

-(instancetype) initWithMovieInfo:(NSDictionary *) movieInfo thumbnailImage:(UIImage *) thumbnailImage;

@end
