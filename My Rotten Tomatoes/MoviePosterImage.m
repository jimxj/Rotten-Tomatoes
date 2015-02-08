//
//  MoviePosterImage.m
//  My Rotten Tomatoes
//
//  Created by Jim Liu on 2/6/15.
//  Copyright (c) 2015 Jim Liu. All rights reserved.
//

#import "MoviePosterImage.h"
#import "FICUtilities.h"

NSString *const RTPhotoImageFormatFamily = @"RTPhotoImageFormatFamily";

NSString *const RTImageFormatPosterThumbnail = @"com.jim.Rotten.Tomatoes.RTPosterThumbnail";
NSString *const RTImageFormatPoster = @"com.jim.Rotten.Tomatoes.RTPoster";


@implementation MoviePosterImage {
    NSURL *_thumbnailFileURL;
    NSString *_UUID;
}

#pragma mark - Property Accessors

- (UIImage *)sourceImage {
    UIImage *sourceImage = [UIImage imageWithContentsOfFile:[_sourceImageURL path]];
    
    return sourceImage;
}

- (UIImage *)thumbnailImage {
    UIImage *thumbnailImage = [UIImage imageWithContentsOfFile:[[self _thumbnailURL] path]];
    
    return thumbnailImage;
}

- (BOOL)thumbnailImageExists {
    BOOL thumbnailImageExists = [[NSFileManager defaultManager] fileExistsAtPath:[self _thumbnailURL]];
    
    return thumbnailImageExists;
}

- (NSURL *)_thumbnailURL {
    if (!_thumbnailFileURL) {
        NSString *urlString = [[self sourceImageURL] absoluteString];
        _thumbnailFileURL = [NSURL URLWithString:[urlString stringByReplacingOccurrencesOfString:@"tmb.jpg" withString:@"ori.jpg"]];
    }
    
    return _thumbnailFileURL;
}

#pragma mark - Protocol Implementations

#pragma mark - FICImageCacheEntity

- (NSString *)UUID {
    if (_UUID == nil) {
        // MD5 hashing is expensive enough that we only want to do it once
        NSString *imageName = [_sourceImageURL lastPathComponent];
        CFUUIDBytes UUIDBytes = FICUUIDBytesFromMD5HashOfString(imageName);
        _UUID = FICStringWithUUIDBytes(UUIDBytes);
    }
    
    return _UUID;
}

- (NSString *)sourceImageUUID {
    return [self UUID];
}

- (NSURL *)sourceImageURLWithFormatName:(NSString *)formatName {
    return _sourceImageURL;
}

@end
