//
//  MovieDataProviderDelegate.h
//  My Rotten Tomatoes
//
//  Created by Jim Liu on 2/8/15.
//  Copyright (c) 2015 Jim Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MovieDataProviderDelegate <NSObject>

- (NSUInteger)count;
- (NSDictionary *)movieAtIndex:(NSInteger) index;
- (UIImage *) thumbnailImageAtIndex:(NSInteger) index;

@end
