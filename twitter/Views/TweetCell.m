//
//  TweetCell.m
//  twitter
//
//  Created by Bienn Viquiera on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "TimelineViewController.h"
#import "APIManager.h"
#import "DateTools.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapFavorite:(id)sender {
    
    if (self.tweet.favorited) {
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                self.tweet.favorited = NO;
                self.tweet.favoriteCount -= 1;
                [self refreshLabels];
            }
        }];
    }
    else {
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                self.tweet.favorited = YES;
                self.tweet.favoriteCount += 1;
                [self refreshLabels];
            }
        }];
    }
    
}
- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted) {
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                self.tweet.retweeted = NO;
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
                self.tweet.retweetCount -= 1;
                [self refreshLabels];
            }
        }];
    }
    else {
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                self.tweet.retweeted = YES;
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                self.tweet.retweetCount += 1;
                [self refreshLabels];
            }
        }];
    }
    
    
}

- (void)refreshLabels {
    //set values
    self.favLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
    //set images
    if (self.tweet.favorited) {
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    }
    if (!self.tweet.favorited) {
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    if (self.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    }
    if (!self.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
    //set time
    self.dateLabel.text = self.tweet.createdAtString;
}

@end
