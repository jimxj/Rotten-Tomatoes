//
//  HomeViewController.m
//  My Rotten Tomatoes
//
//  Created by Jim Liu on 2/6/15.
//  Copyright (c) 2015 Jim Liu. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) UIRefreshControl *refreshController;

@property (nonatomic, strong) NSArray *movies;
@end

@implementation HomeViewController{
    NSString *_cellIdentify;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 150);
    flowLayout.minimumLineSpacing = 6;
    flowLayout.minimumInteritemSpacing = 6;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(3, 23, self.view.frame.size.width - 6, self.view.frame.size.height - 25) collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor clearColor];
    
    _cellIdentify = @"MovieCell";
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:_cellIdentify];
    
    [self.view addSubview:collectionView];
    
    [self fetchMovies];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return [self.movies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentify forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

-(void) onRefresh {
    [self fetchMovies];
}

-(void) fetchMovies {
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=9sx7gw734qybnmm8mgq25423"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"Response %@", responseDictionary);
        
        self.movies = [responseDictionary valueForKey:@"movies"];
        
        [self.collectionView reloadData];
        
        [self.refreshController endRefreshing];
    }];
    
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
