//
//  MovieTableViewCell.h
//  My Rotten Tomatoes
//
//  Created by Jim Liu on 2/6/15.
//  Copyright (c) 2015 Jim Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterThumbnailImageView;

@property (nonatomic, strong) NSDictionary *movieDictionary;

@end
