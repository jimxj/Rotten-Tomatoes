//
//  MovieTableViewCell.m
//  My Rotten Tomatoes
//
//  Created by Jim Liu on 2/6/15.
//  Copyright (c) 2015 Jim Liu. All rights reserved.
//

#import "MovieTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface MovieTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;
@property (weak, nonatomic) IBOutlet UILabel *mpaaRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@property (weak, nonatomic) IBOutlet UIImageView *criticsScoreImage;
@property (weak, nonatomic) IBOutlet UILabel *criticsScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *audienceScoreImage;
@property (weak, nonatomic) IBOutlet UILabel *audienceScoreLabel;

@end


@implementation MovieTableViewCell

-(void) setMovieDictionary:(NSDictionary *)movieDictionary {
    _movieDictionary = movieDictionary;
    
    [self updateUI];
}

- (void) updateUI {
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    //[self.posterThumbnailImageView setImageWithURL:[NSURL URLWithString:[self.movieDictionary valueForKeyPath:@"posters.thumbnail"]]];
    [self.titleLabel setText:[self.movieDictionary valueForKey:@"title"]];
    [self.castLabel setText:[self getCastLabelString]];
    [self.mpaaRatingLabel setText:[self.movieDictionary valueForKey:@"mpaa_rating"]];
    [self.runtimeLabel setText:[NSString stringWithFormat:@"%@min",[self.movieDictionary valueForKey:@"runtime"]]];
    if([self.movieDictionary valueForKey:@"year"]) {
        [self.yearLabel setText:((NSNumber *) [self.movieDictionary valueForKey:@"year"]).description];
    }
    //NSLog(@"ratings.critics_score %@", [self.movieDictionary valueForKeyPath:@"ratings.critics_score"]);
    //NSLog(@"ratings.audience_score %@", [self.movieDictionary valueForKeyPath:@"ratings.audience_score"]);
    if([self.movieDictionary valueForKeyPath:@"ratings.critics_score"]) {
        [self.criticsScoreLabel setText:((NSNumber *) [self.movieDictionary valueForKeyPath:@"ratings.critics_score"]).description];
    }
    if([self.movieDictionary valueForKeyPath:@"ratings.audience_score"]) {
        [self.audienceScoreLabel setText:((NSNumber *) [self.movieDictionary valueForKeyPath:@"ratings.audience_score"]).description];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

# pragma private methods
- (NSString *) getCastLabelString {
    NSArray *casts = [[self.movieDictionary valueForKey:@"abridged_cast"] valueForKeyPath:@"name"];
    NSString *castStr;
    if([casts count] == 1) {
        castStr = casts[0];
    } else if([casts count] > 1)  {
        castStr = [NSString stringWithFormat:@"%@, %@", casts[0], casts[1]];
    }
    
    return castStr;
}

@end
