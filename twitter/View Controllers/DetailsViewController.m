//
//  DetailsViewController.m
//  twitter
//
//  Created by Bienn Viquiera on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController
- (IBAction)didTapRetweet:(id)sender {
    
    if (self.passedTweet.tweet.retweeted) {
        [[APIManager shared] unretweet:self.passedTweet.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                self.passedTweet.tweet.retweeted = NO;
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
                self.passedTweet.tweet.retweetCount -= 1;
                [self refreshLabels];
            }
        }];
    }
    else {
        [[APIManager shared] retweet:self.passedTweet.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                self.passedTweet.tweet.retweeted = YES;
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                self.passedTweet.tweet.retweetCount += 1;
                [self refreshLabels];
            }
        }];
    }
    
}
- (IBAction)didTapFavorite:(id)sender {
    
    if (self.passedTweet.tweet.favorited) {
        [[APIManager shared] unfavorite:self.passedTweet.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                self.passedTweet.tweet.favorited = NO;
                self.passedTweet.tweet.favoriteCount -= 1;
                [self refreshLabels];
            }
        }];
    }
    else {
        [[APIManager shared] favorite:self.passedTweet.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                self.passedTweet.tweet.favorited = YES;
                self.passedTweet.tweet.favoriteCount += 1;
                [self refreshLabels];
            }
        }];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //set labels to the passed tweet's
    NSLog(@"%@", self.passedTweet.tweet.createdAtString);
    [self refreshLabels];
}

- (void)refreshLabels {
    self.userImage.image = self.passedTweet.userImage.image;
    self.userImage.clipsToBounds = true;
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width/2;
    self.userName.text = self.passedTweet.tweet.user.name;
    self.userHandle.text = [NSString stringWithFormat:@"@%@", self.passedTweet.tweet.user.screenName];
    self.tweetText.text = self.passedTweet.tweet.text;
    self.date.text = self.passedTweet.tweet.createdAtString;
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.passedTweet.tweet.retweetCount];
    self.favCount.text = [NSString stringWithFormat:@"%d", self.passedTweet.tweet.favoriteCount];
    
    //for updating when buttons are clicked
    if (self.passedTweet.tweet.favorited) {
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    if (!self.passedTweet.tweet.favorited) {
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    if (self.passedTweet.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }
    if (!self.passedTweet.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
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
