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
#import "ComposeViewController.h"
#import "DetailsViewController.h"
#import "Tweet.h"
#import "User.h"
#import "TweetCell.h"

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate>
- (IBAction)didTapLogout:(id)sender;
@property (nonatomic, strong) NSMutableArray *arrayOfTweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) UIRefreshControl *refreshControl;
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
    
    Tweet *currentTweet = self.arrayOfTweets[indexPath.row];
    User *currentUser = (User *)[currentTweet user];
    cell.tweet = currentTweet;
    
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
    [cell refreshLabels];

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


//protocol to check if compose was pressed
- (void)didTweet:(Tweet *)tweet {
    NSLog(@"delegate triggered");
    [self.arrayOfTweets addObject:tweet];
    [self beginRefresh:self.refreshControl];
}

- (IBAction)didTapLogout:(id)sender {
    //usees the delegate to change the root view controller to the login
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    //clears out the access token
    [[APIManager shared] logout];

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([[segue identifier] isEqualToString:@"ComposeSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        // Pass the selected object to the new view controller.
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
    if ([[segue identifier] isEqualToString:@"DetailSegue"]) {
        TweetCell *tappedCell = sender;
        
        DetailsViewController *navigationController = [segue destinationViewController];
        // Pass the selected object to the new view controller.
        navigationController.passedTweet = tappedCell;
    }
    if ([[segue identifier] isEqualToString:@"ReplySegue"]) {
        
    }
}

@end
