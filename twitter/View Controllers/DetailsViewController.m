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
    self.userHandle.text = self.passedTweet.tweet.user.screenName;
    self.tweetText.text = self.passedTweet.tweet.text;
    self.date.text = self.passedTweet.tweet.createdAtString;
    self.retweetCount.text = [NSString stringWithFormat:@"%d", self.passedTweet.tweet.retweetCount];
    self.favCount.text = [NSString stringWithFormat:@"%d", self.passedTweet.tweet.favoriteCount];
    
    
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
