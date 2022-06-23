//
//  DetailsViewController.h
//  twitter
//
//  Created by Bienn Viquiera on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userHandle;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UILabel *favCount;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (nonatomic, weak) TweetCell *passedTweet;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@end

NS_ASSUME_NONNULL_END
