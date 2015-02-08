//
//  MovieDetailsViewController.m
//  My Rotten Tomatoes
//
//  Created by Jim Liu on 2/7/15.
//  Copyright (c) 2015 Jim Liu. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation MovieDetailsViewController

-(instancetype) initWithMovieInfo:(NSDictionary *) movieInfo thumbnailImage:(UIImage *) thumbnailImage{
    self = [super init];
    if(self) {
        _movieDictionary = movieInfo;
        _thumbnailImage = thumbnailImage;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    
    //self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.synopsisLabel.frame.size.height);
    // add myLabel
    //[self.scrollView addSubview:self.synopsisLabel];
    
    [self updateUI];
    // Do any additional setup after loading the view from its nib.
}

-(void) updateUI {
    //self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView setImageWithURL:[self originalImageURL] placeholderImage:self.thumbnailImage];
    
    [self.synopsisLabel setText:[self.movieDictionary valueForKey:@"synopsis"]];
    self.synopsisLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.synopsisLabel.numberOfLines = 0;
    [self.synopsisLabel sizeToFit];
    
    int totalHeight = self.synopsisLabel.frame.size.height + 480;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, totalHeight);
    
    self.title = [self.movieDictionary valueForKey:@"title"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
    }];
}

- (NSURL *)originalImageURL{

       return[NSURL URLWithString:[[self.movieDictionary valueForKeyPath:@"posters.thumbnail"] stringByReplacingOccurrencesOfString:@"tmb.jpg" withString:@"ori.jpg"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
