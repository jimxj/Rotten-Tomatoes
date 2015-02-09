//
//  HomeTableViewController.m
//  My Rotten Tomatoes
//
//  Created by Jim Liu on 2/6/15.
//  Copyright (c) 2015 Jim Liu. All rights reserved.
//

#import "HomeTableViewController.h"
#import "MovieTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailsViewController.h"
#import "AFNetworkReachabilityManager.h"
#import "SVProgressHUD.h"

@interface HomeTableViewController ()<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate, UISearchDisplayDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshController;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *networkWarningLabel;


@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) NSMutableArray *filteredMovies;
@property (nonatomic) BOOL isInSearchMode;
@end

@implementation HomeTableViewController {
    NSString *_cellName;
}

- (instancetype) initWithTitle:(NSString *) title endpoint:(NSString *) endpoint {
    self = [super init];
    if(self) {
        _tabTitle = title;
        _endpoint = endpoint;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        if(status == AFNetworkReachabilityStatusNotReachable) {
            self.networkWarningLabel.hidden = NO;
        } else {
            self.networkWarningLabel.hidden = YES;
        }
    }];
    
    self.title = self.tabTitle;
    
    self.networkWarningLabel.hidden = YES;
    
    [SVProgressHUD show];
    [self fetchMovies];
    
    self.searchBar.delegate = self;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    _cellName = @"MovieTableViewCell";
    UINib *photoCellNib = [UINib nibWithNibName:_cellName bundle:nil];
    [self.tableView registerNib:photoCellNib forCellReuseIdentifier:_cellName];
    
    self.refreshController = [[UIRefreshControl alloc] init];
    [self.refreshController addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshController atIndex:0];

}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.isInSearchMode ? [self.filteredMovies count] : [self.movies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellName forIndexPath:indexPath];
    NSDictionary *movieInfo = self.isInSearchMode ? self.filteredMovies[indexPath.row] :self.movies[indexPath.row];
    [cell.posterThumbnailImageView setImageWithURL:[NSURL URLWithString:[movieInfo valueForKeyPath:@"posters.thumbnail"]]];
    cell.movieDictionary = movieInfo;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MovieTableViewCell *selectedCell=[self.tableView cellForRowAtIndexPath:indexPath];
    
    NSDictionary *movieInfo = self.isInSearchMode ? self.filteredMovies[indexPath.row] :self.movies[indexPath.row];
   
    MovieDetailsViewController *detailsView = [[MovieDetailsViewController alloc] initWithMovieInfo:movieInfo thumbnailImage:selectedCell.posterThumbnailImageView.image];
    [self.navigationController pushViewController:detailsView animated:YES];
}

-(void) onRefresh {
    [self fetchMovies];
}

-(void) fetchMovies {
    NSURL *url = [NSURL URLWithString:self.endpoint];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(response && ((NSHTTPURLResponse *)response).statusCode == 200 && !connectionError) {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"Response %@", responseDictionary);
        
            //[self.movies removeAllObjects];
            self.movies = [responseDictionary valueForKey:@"movies"];
        
            [self.tableView reloadData];
            
            self.networkWarningLabel.hidden = YES;
        } else {
           self.networkWarningLabel.hidden = NO;
        }
        
        [self.refreshController endRefreshing];
        
        [SVProgressHUD dismiss];
    }];
    
}

#pragma mark search
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.filteredMovies removeAllObjects];
    
    if(!searchText || ![searchText length]) {
       self.isInSearchMode = NO;
    } else {
        self.isInSearchMode = YES;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.title BEGINSWITH[c] %@",searchText];
        self.filteredMovies = [NSMutableArray arrayWithArray:[self.movies filteredArrayUsingPredicate:predicate]];
    }
    
    [self.tableView reloadData];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.isInSearchMode = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.isInSearchMode = NO;
}

-(BOOL) isInternetReachable
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

//- (void)viewWillAppear:(BOOL)animated{
//    
//    if (self.navigationController.navigationBar.translucent) {
//        self.navigationController.navigationBar.translucent = NO;
//    }
//    
//    if (self.navigationController.navigationBarHidden) {
//        self.navigationController.navigationBarHidden = NO;
//    }
//    
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
