//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Tweet.h"
#import "User.h"
#import "TweetCell.h"

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource>
- (IBAction)didTapLogout:(id)sender;
@property (nonatomic, strong) NSMutableArray *arrayOfTweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation TimelineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 600;
    
    //create refresh instance
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    //swipe to refresh
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    [self beginRefresh:refreshControl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfTweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell" forIndexPath:indexPath];
//    NSLog(@"%@", [(User *)[self.arrayOfTweets[indexPath.row] user] name]);
    
    Tweet *currentTweet = self.arrayOfTweets[indexPath.row];
    User *currentUser = (User *)[currentTweet user];
    
    //set tweet labels
    cell.userName.text = [currentUser name];
    NSString *handle = [NSString stringWithFormat: @"%s%@", "@", [currentUser screenName]];
    cell.userHandle.text = handle;
    cell.tweetLabel.text = [currentTweet text];
    cell.dateLabel.text = [currentTweet createdAtString];
    cell.favLabel.text = [NSString stringWithFormat:@"%i", [currentTweet favoriteCount]];
    cell.retweetLabel.text = [NSString stringWithFormat:@"%i", [currentTweet retweetCount]];
    
    
    //get user image
    NSString *URLString = currentUser.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    cell.userImage.image = [UIImage imageWithData:urlData];
    cell.userImage.clipsToBounds = true;
    cell.userImage.layer.cornerRadius = cell.userImage.frame.size.width/2;

    return cell;
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSMutableArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
//            for (NSDictionary *dictionary in tweets) {
//                NSString *text = dictionary[@"text"];
//                NSLog(@"%@", text);
//            }
            
            self.arrayOfTweets = tweets;
            NSLog(@"%lu", self.arrayOfTweets.count);
            [self.tableView reloadData];

        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
       // Reload the tableView now that there is new data
        [self.tableView reloadData];

       // Tell the refreshControl to stop spinning
        [refreshControl endRefreshing];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)didTapLogout:(id)sender {
    //usees the delegate to change the root view controller to the login
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    //clears out the access token
    [[APIManager shared] logout];

}
@end
