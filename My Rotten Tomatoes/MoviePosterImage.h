//
//  MoviePosterImage.h
//  My Rotten Tomatoes
//
//  Created by Jim Liu on 2/6/15.
//  Copyright (c) 2015 Jim Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FICEntity.h"

extern NSString *const RTPhotoImageFormatFamily;

extern NSString *const RTImageFormatPosterThumbnail;
extern NSString *const RTImageFormatPoster;

@interface MoviePosterImage : NSObject<FICEntity>

@property (nonatomic, copy) NSURL *sourceImageURL;
@property (nonatomic, strong, readonly) UIImage *sourceImage;
@property (nonatomic, strong, readonly) UIImage *thumbnailImage;
@property (nonatomic, assign, readonly) BOOL thumbnailImageExists;


@end
