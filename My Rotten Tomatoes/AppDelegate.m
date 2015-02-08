//
//  AppDelegate.m
//  My Rotten Tomatoes
//
//  Created by Jim Liu on 2/5/15.
//  Copyright (c) 2015 Jim Liu. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "HomeTableViewController.h"
#import "FICImageCache.h"
#import "MoviePosterImage.h"

@interface AppDelegate ()<FICImageCacheDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    [self setupImageCache];
    
     HomeTableViewController *collectionView = [[HomeTableViewController alloc] init];

    
    UINavigationController* nvc = [[UINavigationController alloc] initWithRootViewController:collectionView];
    self.window.rootViewController = nvc;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) setupImageCache {
    NSMutableArray *mutableImageFormats = [NSMutableArray array];
    
    FICImageFormat *thumbnailImageFormat = [[FICImageFormat alloc] init];
    thumbnailImageFormat.name = RTImageFormatPosterThumbnail;
    thumbnailImageFormat.family = RTPhotoImageFormatFamily;
    thumbnailImageFormat.style = FICImageFormatStyle16BitBGR;
    thumbnailImageFormat.imageSize = CGSizeMake(65, 100);
    thumbnailImageFormat.maximumCount = 100;
    thumbnailImageFormat.devices = FICImageFormatDevicePhone;
    thumbnailImageFormat.protectionMode = FICImageFormatProtectionModeNone;
    [mutableImageFormats addObject:thumbnailImageFormat];
    
    FICImageFormat *posterImageFormat = [[FICImageFormat alloc] init];
    posterImageFormat.name = RTImageFormatPoster;
    posterImageFormat.family = RTPhotoImageFormatFamily;
    posterImageFormat.style = FICImageFormatStyle32BitBGRA;
    posterImageFormat.imageSize = CGSizeMake(320, 500);
    posterImageFormat.maximumCount = 100;
    posterImageFormat.devices = FICImageFormatDevicePhone;
    posterImageFormat.protectionMode = FICImageFormatProtectionModeNone;
    [mutableImageFormats addObject:posterImageFormat];
    
    // Configure the image cache
    FICImageCache *sharedImageCache = [FICImageCache sharedImageCache];
    [sharedImageCache setDelegate:self];
    [sharedImageCache setFormats:mutableImageFormats];
}

@end
